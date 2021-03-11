/* 
 * File:   display.h
 * Author: marek
 *
 * Created on 17 maja 2019, 11:42
 */

#include <stdint.h>

#ifndef DISPLAY_H
#define	DISPLAY_H

typedef enum {DISP_TIME, DISP_MEASUREMENTS, DISP_CONFIG} disp_state_t;

#ifdef	__cplusplus
extern "C" {
#endif

void init_ui (void);
void handle_ui (void);


#ifdef	__cplusplus
}
#endif

#endif	/* DISPLAY_H */

