/* 
 * File:   lcd.h
 * Author: marek
 *
 * Created on 12 maja 2019, 07:49
 */

#ifndef LCD_H
#define	LCD_H

#include <stdint.h>
#include <plib.h>
#include "../HardwareProfile.h"

#define PBCLK  (SYSCLK)
#define Fsck	400000
#define BRG_VAL 	((PBCLK/2/Fsck)-2)

#ifdef	__cplusplus
extern "C" {
#endif

void i2c_init (void);
uint8_t i2c_rcv_byte (uint8_t address);
void i2c_send_byte (uint8_t data, uint8_t address);


#ifdef	__cplusplus
}
#endif

#endif	/* LCD_H */