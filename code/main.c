/* 
 * File:   main.c
 * Author: Marek
 *
 * Created on 7 stycznia 2016, 12:22
 */

#include <xc.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <p32xxxx.h>
#include <plib.h>
#include <time.h>
#include <string.h>

#include "delay/delay.h"
#include "time/time.h"
#include "uart/uart.h"
#include "common.h"
#include "usb_host_msd/usb.h"
#include "usb_host_msd/usb_host_msd.h"
#include "usb_host_msd/usb_host_msd_scsi.h"
#include "fatfs/ff.h"
#include "fatfs/diskio.h"
#include "net/TCPIP.h"
#include "net/MQTT.h"
#include "nvram/nvram.h"
#include "config/config.h"
#include "geiger/geiger.h"
#include "HardwareProfile.h"
#include "lcd/i2c.h"
#include "lcd/hd44780.h"
#include "bme280/bme280.h"


#pragma config JTAGEN = OFF        // Disable JTAG
#pragma config FSOSCEN = ON        // ENABLE secondary oscillator

#pragma config POSCMOD=HS          // High speed crystal mode
#pragma config FNOSC=PRIPLL        // Use Primary Oscillator with PLL (XT, HS, or EC) 
#pragma config FPLLIDIV=DIV_2      // Divide 8MHz to between 4-5MHz before PLL (now 4MHz)
#pragma config FPLLMUL=MUL_20      // Multiply with PLL (now 80MHz)
#pragma config FPLLODIV=DIV_2      // Divide After PLL (now 40 MHz)

#pragma config FWDTEN = ON         // Enable watchdog timer
#pragma config WDTPS = PS4096
#pragma config ICESEL = ICS_PGx1   // select pins to transfer program data on (ICSP pins)

#pragma config FVBUSONIO = OFF
#pragma config FUSBIDIO = OFF
#pragma config UPLLEN   = ON
#pragma config UPLLIDIV = DIV_2

char buffer[128];
FATFS SPIFatFS;
FATFS USBFatFS;

extern void GenericTCPServer(void);
static void handle_usb_log (void);
static void handle_bme_read (void);
//void handle_mqtt(void);
char* constructJSON (char* buf, uint16_t len);
void mqtt_init (void);
void handle_mqtt_log(void);
void mqtt_on_connect(void);
void mqtt_on_publish(void);
void mqtt_on_subscribe(void);
void mqtt_on_receive(const char *topic, const WORD topicLength, const BYTE *payload, const WORD payloadLength);

int main(int argc, char** argv) {
    
    FRESULT res;
    uint32_t disk_timer, wdt_timer;
    uint8_t io;
    
    DisableWDT();
    SYSTEMConfigPerformance(SYSCLK);
    
    __XC_UART = 1;
    
    ANSELA = 0;
    ANSELB = 0;
    TRISBbits.TRISB15 = 0;      //ENC28J60 CS
    
    SDI1Rbits.SDI1R = 0b0000; 	//SDI1 is RPA1
    RPB5Rbits.RPB5R = 0b0011; 	//SDO1 is RPB5 (RB14 is hardwired as SCK1)
    T2CKRbits.T2CKR = 0b0000;   //T2CK is RPA0;
    TRISAbits.TRISA0 = 1;       //RA0 (T2CK) is input
    TRISAbits.TRISA1 = 1; 		//RA1 (SDI1) is input
    TRISBbits.TRISB5 = 0; 		//RB5 (SDO1) is output
    TRISBbits.TRISB14 = 0; 		//RB14 (SCK1) is output
    
    memset(buffer, 0x00, sizeof(buffer));
 
    time_init();
    MPFSInit();
    TickInit();
    uart_init();
    i2c_init();
    lcd_init();
    bme_init();
    bme_setup();
    INTEnableSystemMultiVectoredInt();
    
    USBInitialize(0);
//    while(!USBHostMSDSCSIMediaDetect()) {
//        USBTasks(); //wait   for usb attach
//        //tutuaj trzeba zaimplentowac timout oczekiwania na mediadetect()
//    }
    
    res = f_mount(&SPIFatFS, "0:", 1);
    if (res != FR_OK) {printf("f_mount error code: %i\r\n", res);}
    else {printf("f_mount OK\r\n");}
    
    res = f_mount(&USBFatFS, "1:", 0);
    if (res != FR_OK) {printf("f_mount error code: %i\r\n", res);}
    else {printf("f_mount OK\r\n");}
    
    CheckAndLoadDefaults();
    StackInit();
    
    geiger_init();
    
    ClearWDT();
    EnableWDT();
    
    i2c_send_byte(0xFF, PCF8574_IO_ADDR);
    init_ui();
    
    MQTTSetConnectCallback(mqtt_on_connect);
    MQTTSetReceiveCallback(mqtt_on_receive);
    mqtt_init();
    
    while (1) {
        
        StackTask();
        StackApplications();
        UART_RX_STR_EVENT(buffer);
        //GenericTCPServer();
        
        USBTasks();
        if ((uint32_t)(millis()-disk_timer) >= 10) {
            disk_timer = millis();
            disk_timerproc();
        }
        
        if ((uint32_t)(millis()-wdt_timer) >= 300) {
            wdt_timer = millis();
            ClearWDT();
//            io = i2c_rcv_byte(PCF8574_IO_ADDR);
//            io ^= 0x60;
//            i2c_send_byte(io, PCF8574_IO_ADDR);
        }        
        
        handle_bme_read();
        handle_ui();
        lcd_handle();
        handle_usb_log();
        handle_mqtt_log();
    }

    return (EXIT_SUCCESS);
}


void handle_bme_read (void) {
    static uint32_t bme_timer = 0;
    
    if ( (uint32_t)(millis()-bme_timer) > 20000 ) {
        bme_read_temp_press_and_hum();
        bme_temperature = bme_get_temperature();
        bme_pressure = bme_get_pressure(); //value in hPa
        bme_humidity = bme_get_humidity() * 100; //value in percents
        bme_timestamp = rtccGetTimestamp();
        bme_timer = millis();
    }
}


void find_latest_file (char *path) {
    FRESULT res;
    DIR dir;
    static FILINFO fno;
    uint16_t i;
    uint32_t file_id = 0;
    uint32_t max_file_id= 0;
    
    res = f_opendir(&dir, path);
    if (res == FR_OK) {
        for (;;) {
            res = f_readdir(&dir, &fno);
            if (res != FR_OK || fno.fname[0] == 0) break;
            if (!(fno.fattrib & AM_DIR)) { /* It is not a directory */
                if (sscanf(fno.fname, "geiger%lu.csv", &file_id) != 1) break;
                if (file_id > max_file_id) max_file_id = file_id;
                printf("%s/%s\n", path, fno.fname);
            }                    
        }
        f_closedir(&dir);
    }
}


void handle_usb_log (void) {
    
    static uint32_t timer = 0;
    FRESULT res;
    FIL file;
    time_t tm;
	uint16_t countspm;
    double siv;
    char temp[100];
    
    if ( (config.usbLogInterval != 0) && ((uint32_t)(uptime()-timer) >= config.usbLogInterval) ) {
        timer = uptime();
        
        if ( (uptime() > 60) && rtccIsSet() ) {
            res = f_open(&file, "1:/geiger.csv", (FA_OPEN_ALWAYS | FA_WRITE));
            if (res != FR_OK) {
                printf("f_open error code: %i\r\n", res);
                return;
            }
            if (f_size(&file) == 0) {
                f_puts("Time (UTC);CPM;uSv/h\r\n", &file);
            }
            else {
                res = f_lseek(&file, f_size(&file));
                if (res != FR_OK) {
                    printf("f_lseek error code: %i\r\n", res); 
                    f_close(&file);
                    return;
                }
            }
            countspm = cpm();
            siv = cpm2sievert(countspm);
            tm = rtccGetTimestamp();
            strncpy(temp, asctime(gmtime(&tm)), sizeof(temp)-1);
            strtok(temp, "\n");
            f_puts(temp, &file);
            f_putc(';', &file);
            sprintf(temp, "%d", countspm);
            f_puts(temp, &file);
            f_putc(';', &file);
            sprintf(temp, "%.4f\r\n", siv);
            f_puts(temp, &file);
            f_close(&file);            
        }
    }   
}

void mqtt_init (void) {
    if(MQTTBeginUsage()) {
        printf("Starting MQTT\r\n");
        MQTTClient.Server.szRAM = config.mqtt_server;	// MQTT server address
        MQTTClient.ServerPort = 1883;
        MQTTClient.ConnectId.szRAM = "d:atlantis:ethergeiger:1";
        MQTTClient.Topic.szRAM = config.mqtt_topic;
        MQTTClient.Username.szRAM = config.mqtt_username;
        MQTTClient.Password.szRAM = config.mqtt_password;                
        MQTTClient.bSecure=FALSE;
        MQTTClient.QOS=1;
        MQTTClient.KeepAlive=MQTT_KEEPALIVE_LONG;   
    }
}

void mqtt_on_connect(void) {
    printf("MQTT connected\r\n");
    MQTTSubscribe("testTopic", mqtt_on_subscribe);
    //MQTTSendStr("testTopic", "Hellord!", NULL);
}

void mqtt_on_publish(void) {
    printf("MQTT published\r\n");
    mqtt_last_publish = uptime();  //TODO
}

void mqtt_on_subscribe(void) {
    printf("MQTT subscribed\r\n");
}

void mqtt_on_receive(const char *topic, const WORD topicLength, const BYTE *payload, const WORD payloadLength) {
    char tmp[512];
    memcpy(tmp, topic, topicLength);
    tmp[topicLength] = '\0';
    printf("Received topic: %s\r\n", tmp);
    memcpy(tmp, payload, payloadLength);
    tmp[payloadLength] = '\0';
    printf("Received payload:\r\n%s\r\n", tmp);
    printf("Payload len: %d\r\n", payloadLength);
}

void handle_mqtt_log(void) {
    static uint32_t timer = 0;
    static char JSONBuffer[512];
    
    if ( ((uint32_t)(uptime()-timer) >= 30) && (uptime() > 60) ) {
        constructJSON(JSONBuffer, sizeof(JSONBuffer)-2);
        MQTTSendStr(config.mqtt_topic, JSONBuffer, mqtt_on_publish);
        MQTTSendStr(config.mqtt_topic, "Druga wiadomosc", mqtt_on_publish);
        MQTTSendStr(config.mqtt_topic, "Trzecia wiadomosc", mqtt_on_publish);
        timer = uptime();
    }
}


static enum {
      EXCEP_IRQ = 0,            // interrupt
      EXCEP_AdEL = 4,            // address error exception (load or ifetch)
      EXCEP_AdES,                // address error exception (store)
      EXCEP_IBE,                // bus error (ifetch)
      EXCEP_DBE,                // bus error (load/store)
      EXCEP_Sys,                // syscall
      EXCEP_Bp,                // breakpoint
      EXCEP_RI,                // reserved instruction
      EXCEP_CpU,                // coprocessor unusable
      EXCEP_Overflow,            // arithmetic overflow
      EXCEP_Trap,                // trap (possible divide by zero)
      EXCEP_IS1 = 16,            // implementation specfic 1
      EXCEP_CEU,                // CorExtend Unuseable
      EXCEP_C2E                // coprocessor 2
  } _excep_code;


static unsigned int _epc_code;
static unsigned int _excep_addr;



void _general_exception_handler(void) {
    int i=0;
    asm volatile("mfc0 %0,$13" : "=r" (_excep_code));
    asm volatile("mfc0 %0,$14" : "=r" (_excep_addr));
  
    _excep_code = (_excep_code & 0x0000007C) >> 2;
 

	 printf("\r\n\r\n GE at %x ",_excep_addr);
	 switch(_excep_code){
        case EXCEP_IRQ: printf("interrupt");break;
        case EXCEP_AdEL: printf("address error exception (load or ifetch)");break;
        case EXCEP_AdES: printf("address error exception (store)");break;
        case EXCEP_IBE: printf("(ifetch)");break; //bus error
        case EXCEP_DBE: printf("(load/store)");break; //bus error
        case EXCEP_Sys: printf("syscall");break;
        case EXCEP_Bp: printf("breakpoint");break;
        case EXCEP_RI: printf("reserved instruction");break;
        case EXCEP_CpU: printf("coprocessor unusable");break;
        case EXCEP_Overflow: printf("arithmetic overflow");break;
        case EXCEP_Trap: printf("trap (possible divide by zero)");break;
        case EXCEP_IS1: printf("implementation specfic 1");break;
        case EXCEP_CEU: printf("CorExtend Unuseable");break;
        case EXCEP_C2E: printf("coprocessor 2");break;
      }
	  printf("\r\nExecution halted.\r\n");
      while (1) {
		printf("Waiting for WTD reset %lu\r\n",i++);
		delay_ms(1000);
      }
}

