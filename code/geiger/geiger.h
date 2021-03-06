/*
 * geiger.h
 *
 * Created: 2014-04-20 12:01:23
 *  Author: Marek
 */ 


#ifndef GEIGER_H_
#define GEIGER_H_

#include <xc.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <p32xxxx.h>

// Deklaracje zmiennych zewnętrznych
extern volatile uint16_t geiger_pulses[];



//Deklaracje funkcji
void geiger_init (void);
uint16_t cpm (void);
double cpm2sievert (uint16_t cpm);



#endif /* GEIGER_H_ */