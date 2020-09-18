/* 
 * File:   time.h
 * Author: Marek
 *
 * Created on 6 grudnia 2015, 16:01
 */

#ifndef TIME_H
#define	TIME_H

#include <stdint.h>
#include <time.h>

#ifdef	__cplusplus
extern "C" {
#endif

void time_init (void);
time_t rtccGetTimestamp (void);
struct tm rtccGetTm (void);
uint32_t millis (void);
uint32_t uptime (void);



#ifdef	__cplusplus
}
#endif

#endif	/* TIME_H */

