#include <xc.h>
#include <stdlib.h>
#include <p32xxxx.h>
#include <plib.h>

#include "uart.h"


#define UART_RX_BUF_SIZE 64 
#define UART_RX_BUF_MASK ( UART_RX_BUF_SIZE - 1)


volatile uint8_t ascii_line;

volatile char UART_RxBuf[UART_RX_BUF_SIZE];
volatile uint8_t UART_RxHead;
volatile uint8_t UART_RxTail;

static void (*uart_rx_str_event_callback)(char * pBuf);


void register_uart_str_rx_event_callback(void (*callback)(char * pBuf)) {
	uart_rx_str_event_callback = callback;
}

void UART_RX_STR_EVENT(char * rbuf) {

	if( ascii_line ) {
		if( uart_rx_str_event_callback ) {
			uart_get_str( rbuf );
			(*uart_rx_str_event_callback)( rbuf );
		} else {
			UART_RxHead = UART_RxTail;
		}
	}
}


void uart_init (void) {
    TRISBSET = _TRISB_TRISB2_MASK;
    TRISBCLR = _TRISB_TRISB3_MASK;
    U1RXRbits.U1RXR = 0b0100;   //RPB2 RX
    RPB3Rbits.RPB3R = 0b0001;   //RPA0 TX
    
    INTSetVectorPriority(INT_VECTOR_UART(UART1), INT_PRIORITY_LEVEL_1);
    INTSetVectorSubPriority(INT_VECTOR_UART(UART1), INT_SUB_PRIORITY_LEVEL_1);

    INTClearFlag(INT_SOURCE_UART_RX(UART1));
    INTClearFlag(INT_SOURCE_UART_TX(UART1));
    INTEnable(INT_SOURCE_UART_RX(UART1), INT_ENABLED);
    OpenUART1(UART_EN | UART_NO_PAR_8BIT | UART_1STOPBIT | UART_DIS_BCLK_CTS_RTS, UART_RX_ENABLE | UART_TX_ENABLE, SYSCLK/16/UART1BAUD-1);
}

int uart_getc(void) {
	int data = -1;
    if ( UART_RxHead == UART_RxTail ) return data;
    UART_RxTail = (UART_RxTail + 1) & UART_RX_BUF_MASK;
    data = UART_RxBuf[UART_RxTail];
    return data;
}


char * uart_get_str(char * buf) {
	char c;
	char * wsk = buf;
	if( ascii_line ) {
		while( (c = uart_getc()) ) {
			if( 13 == c || c < 0) break;
			*buf++ = c;
		}
		*buf=0;
		ascii_line--;
	}
	return wsk;
}


void __ISR(_UART1_VECTOR, IPL1AUTO) IntUart1Handler (void) {
    
    uint8_t tmp_head;
    char data;
    
    if (INTGetFlag(INT_SOURCE_UART_RX(UART1))) {
        while(U1STAbits.URXDA) {
            data = U1RXREG;
            tmp_head = ( UART_RxHead + 1) & UART_RX_BUF_MASK;
            if ( tmp_head == UART_RxTail ) {
                UART_RxHead = UART_RxTail;
            } else {
                switch( data ) {
                    case 0:					
                    case 10: break;			
                    case 13: ascii_line++;	
                    default : UART_RxHead = tmp_head; UART_RxBuf[tmp_head] = data;
                }

            }
        }
          INTClearFlag(INT_SOURCE_UART_RX(UART1));
    }
    
    if (INTGetFlag(INT_SOURCE_UART_TX(UART1))) {

        INTClearFlag(INT_SOURCE_UART_TX(UART1));
    }
}