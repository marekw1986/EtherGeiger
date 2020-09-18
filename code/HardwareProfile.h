/* 
 * File:   HardwareProfile.h
 * Author: Marek
 *
 * Created on 7 stycznia 2016, 18:25
 */

#ifndef HARDWAREPROFILE_H
#define	HARDWAREPROFILE_H

#ifdef	__cplusplus
extern "C" {
#endif
    
#define SystemClock             (40000000ul)

#define GetSystemClock()        SystemClock
#define GetInstructionClock()   SystemClock
#define GetPeripheralClock()    (SystemClock/(1<<OSCCONbits.PBDIV))

#define CP0_TICK_HZ             (SystemClock / 2)
    
    
#define ENC_IN_SPI1
//#define ENC_REVERSE_LED
// ENC28J60 I/O pins SPI MAX 10 Mhz !!
#if defined ENC_IN_SPI1
        #define ENC_CS_TRIS                     (TRISBbits.TRISB15)
        #define ENC_CS_IO                       (LATBbits.LATB15)
        //#define ENC_RST_TRIS          (TRISDbits.TRISD15)     // Not connected by default.  It is okay to leave this pin completely unconnected, in which case this macro should simply be left undefined.
        //#define ENC_RST_IO            (PORTDbits.RD15)

        // SPI SCK, SDI, SDO pins are automatically controlled by the
        #define ENC_SPI_IF                      (IFS0bits.SPI1RXIF)
        #define ENC_SSPBUF                      (SPI1BUF)
        #define ENC_SPICON1                     (SPI1CON)
        #define ENC_SPICON1bits         (SPI1CONbits)
        #define ENC_SPIBRG                      (SPI1BRG)
        #define ENC_SPISTATbits         (SPI1STATbits)
#elif defined ENC_IN_SPI2
        #define ENC_CS_TRIS                     (TRISAbits.TRISA0)
        #define ENC_CS_IO                       (LATAbits.LATA0)
        //#define ENC_RST_TRIS          (TRISFbits.TRISF13)     // Not connected by default.  It is okay to leave this pin completely unconnected, in which case this macro should simply be left undefined.
        //#define ENC_RST_IO            (PORTFbits.RF13)

        // SPI SCK, SDI, SDO pins are automatically controlled by the
        // PIC32 SPI module
        #define ENC_SPI_IF                      (IFS1bits.SPI2RXIF)
        #define ENC_SSPBUF                      (SPI2BUF)
        #define ENC_SPICON1                     (SPI2CON)
        #define ENC_SPISTATbits         (SPI2STATbits)
        #define ENC_SPICON1bits         (SPI2CONbits)
        #define ENC_SPIBRG                      (SPI2BRG)
#endif

#define SPIFLASH_CS_TRIS		(TRISBbits.TRISB13)
#define SPIFLASH_CS_IO			(LATBbits.LATB13)
#define SPIFLASH_SCK_TRIS		(TRISBbits.TRISB14)
#define SPIFLASH_SDI_TRIS		(TRISAbits.TRISA1)
#define SPIFLASH_SDI_IO			(PORTAbits.RA1)
#define SPIFLASH_SDO_TRIS		(TRISBbits.TRISB5)
#define SPIFLASH_SPI_IF			(IFS1bits.SPI1RXIF)
#define SPIFLASH_SSPBUF			(SPI1BUF)
#define SPIFLASH_SPICON1		(SPI1CON)
#define SPIFLASH_SPICON1bits	(SPI1CONbits)
#define SPIFLASH_SPISTATbits	(SPI1STATbits)
#define SPIFLASH_SPIBRG			(SPI1BRG)




#ifdef	__cplusplus
}
#endif

#endif	/* HARDWAREPROFILE_H */

