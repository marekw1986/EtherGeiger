/* 
 * File:   common.h
 * Author: Marek
 *
 * Created on 20 grudnia 2015, 22:10
 */

#ifndef COMMON_H
#define	COMMON_H

#include <stdint.h>
#include "fatfs/ff.h"

typedef struct {
	uint16_t year;	/* 2000..2099 */
	uint8_t month;	/* 1..12 */
	uint8_t	mday;	/* 1.. 31 */
	uint8_t	wday;	/* 1..7 */
	uint8_t	hour;	/* 0..23 */
	uint8_t	min;	/* 0..59 */
	uint8_t	sec;	/* 0..59 */
} RTC;

double bme_temperature;
double bme_pressure;
double bme_humidity;
uint32_t bme_timestamp;

int16_t dht_temperature;
uint16_t dht_humidity;
uint32_t dht_timestamp;

#ifdef	__cplusplus
extern "C" {
#endif

FRESULT FormatSpiFlashDisk (void);
unsigned char BcdToByte(unsigned char bcd);
unsigned char ByteToBcd(unsigned char i);

#ifdef	__cplusplus
}
#endif

#endif	/* COMMON_H */

