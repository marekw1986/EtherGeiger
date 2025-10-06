#ifndef _HAMQTT_H_
#define _HAMQTT_H_

#include <xc.h>
#include <stdint.h>
#include "GenericTypeDefs.h"

#ifdef	__cplusplus
extern "C" {
#endif

void mqtt_init (void);
void mqtt_on_connect(void);
void mqtt_on_publish(void);
void mqtt_on_subscribe(void);
void mqtt_on_receive(const char *topic, const WORD topicLength, const BYTE *payload, const WORD payloadLength);
void mqtt_on_disconnect(void);
void handle_hamqtt(void);
    
#ifdef	__cplusplus
}
#endif

#endif // _HAMQTT_H_
