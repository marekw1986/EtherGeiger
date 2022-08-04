#ifndef CONFIG_H
#define	CONFIG_H

#include <xc.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <p32xxxx.h>
#include <plib.h>

#include "../common.h"
#include "../net/TCPIP.h"
#include "../nvram/nvram.h"

typedef struct __attribute__((__packed__)) {
    char devname[34];
    SHORT timeZone;
    BYTE usbLogInterval;
    BYTE password[34];
    char mqtt_server[64];
    uint16_t mqtt_port;
    char mqtt_topic[64];
    char mqtt_login[64];
    char mqtt_password[64];
    APP_CONFIG AppConfig;
} config_t;

config_t config;

void loadDefaultSettings(void);
void CheckAndLoadDefaults( void );

#endif	/* CONFIG_H */

