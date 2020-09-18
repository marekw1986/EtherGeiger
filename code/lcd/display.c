#include <time.h>
#include "display.h"
#include "hd44780.h"
#include "../delay/delay.h"
#include "../time/time.h"
#include "../common.h"
#include "../geiger/geiger.h"
#include "../config/config.h"

#define KEY_1 3
#define KEY_2 2
#define KEY_3 1
#define KEY_4 0

disp_state_t disp_state = DISP_MEASUREMENTS;
uint32_t backlight_timer = 0;


static void disp_time_process (uint8_t now);
static void disp_measurements_process (uint8_t now);
static void disp_config_process (uint8_t now);
static void backlight_on (void);

void handle_io (void) {
    uint8_t keys;
    static uint32_t keys_timer = 0; 
    
    switch(disp_state) {
        case DISP_TIME:
        disp_time_process(0);
        break;
        
        case DISP_MEASUREMENTS:
        disp_measurements_process(0);
        break;
        
        case DISP_CONFIG:
        disp_config_process(0);
        break;
        
        default:
        break;
    }
    
    if ( (uint32_t)(millis()-keys_timer) > 50 ) {
        keys = i2c_rcv_byte(PCF8574_IO_ADDR);
        keys_timer = millis();
        if (!(keys & (1 << KEY_1))) {
            backlight_on();
            disp_state = DISP_TIME;
            disp_time_process(1);
        }
        if (!(keys & (1 << KEY_2))) {
            backlight_on();
            disp_state = DISP_MEASUREMENTS;
            disp_measurements_process(1);
        }
        if (!(keys & (1 << KEY_3))) {
            backlight_on();
            disp_state = DISP_CONFIG;
            disp_config_process(1);
        }        
        if (!(keys & (1 << KEY_4))) {
            backlight_on();
        }
        
    }
    
    //turn off backlight automatically
    if (backlight_timer && ((uint32_t)(millis()-backlight_timer) > 5000 ) ) {
        i2c_send_byte(0xFF, PCF8574_IO_ADDR);
        backlight_timer = 0;
    }    
}

void disp_time_process (uint8_t now) {
    time_t rawtime;
    struct tm * timeinfo;
    static uint32_t timer = 0;
    char buff[32];
    
    if (now || (uint32_t)(millis()-timer) > 1000 ) {
        rawtime = rtccGetTimestamp();
        timeinfo = localtime(&rawtime);
        sprintf(buff, "%02d:%02d:%02d", timeinfo->tm_hour, timeinfo->tm_min, timeinfo->tm_sec);
        lcd_cls();
        lcd_locate(0, 0);
        lcd_str(buff);
        lcd_locate(1,0);
        sprintf(buff, "%02d-%02d-%04d", timeinfo->tm_mday, timeinfo->tm_mon, (timeinfo->tm_year + 1900));
        lcd_str(buff);
        timer = millis();
    }
}

void disp_measurements_process (uint8_t now) {
    typedef enum {DISP_MEAS_RAD, DISP_MEAS_TEMP, DISP_MEAS_HUM, DISP_MEAS_PRESS} disp_mesurements_stage_t;
    static disp_mesurements_stage_t disp_mesurements_stage = DISP_MEAS_RAD;
    static uint32_t timer = 0;
    double siv; 
    char buff[32];
    
    if (now || (uint32_t)(millis()-timer) > 5000 ) {
        lcd_cls();
        lcd_locate(0,0);
        switch(disp_mesurements_stage) {
            case DISP_MEAS_RAD:
            lcd_str("Promieniowanie:");
            lcd_locate(1,0);
            siv = cpm2sievert(cpm());
            sprintf(buff, "%.4f uS/h", siv);
            break;
            
            case DISP_MEAS_TEMP:
            lcd_str("Temperatura:");
            lcd_locate(1,0);
            sprintf(buff, "%.2f st. C", bme_temperature);            
            break;
            
            case DISP_MEAS_HUM:
            lcd_str("Wilgotnosc:");
            lcd_locate(1,0);
            sprintf(buff, "%.2f%%", bme_humidity);             
            break;
            
            case DISP_MEAS_PRESS:
            lcd_str("Cisnienie:");
            lcd_locate(1,0);
            sprintf(buff, "%.2f hPa", bme_pressure);             
            break;
            
            default:
            break;
        }
        lcd_str(buff);
        
        disp_mesurements_stage++;
        if (disp_mesurements_stage > DISP_MEAS_PRESS) disp_mesurements_stage = DISP_MEAS_RAD;        
        timer = millis();
    }    
}

void disp_config_process (uint8_t now) {
    typedef enum {DISP_CONFIG_IP, DISP_CONFIG_NETMASK, DISP_CONFIG_GW, DISP_CONFIG_DNS1, DISP_CONFIG_DNS2} disp_config_stage_t;
    static disp_config_stage_t disp_config_stage = DISP_CONFIG_IP;
    static uint32_t timer = 0;
    char buff[32];
    
    if (now || (uint32_t)(millis()-timer) > 5000 ) {
        lcd_cls();
        lcd_locate(0,0);
        switch(disp_config_stage) {
            case DISP_CONFIG_IP:
            lcd_str("IP:");
            lcd_locate(1,0);
            sprintf(buff, "%d.%d.%d.%d", AppConfig.MyIPAddr.v[0], AppConfig.MyIPAddr.v[1], AppConfig.MyIPAddr.v[2], AppConfig.MyIPAddr.v[3]);
            break;
            
            case DISP_CONFIG_NETMASK:
            lcd_str("Maska podsieci:");
            lcd_locate(1,0);
            sprintf(buff, "%d.%d.%d.%d", AppConfig.MyMask.v[0], AppConfig.MyMask.v[1], AppConfig.MyMask.v[2], AppConfig.MyMask.v[3]);                        
            break;
            
            case DISP_CONFIG_GW:
            lcd_str("Brama domyslna:");
            lcd_locate(1,0);
            sprintf(buff, "%d.%d.%d.%d", AppConfig.MyGateway.v[0], AppConfig.MyGateway.v[1], AppConfig.MyGateway.v[2], AppConfig.MyGateway.v[3]);                        
            break;
            
            case DISP_CONFIG_DNS1:
            lcd_str("DNS1:");
            lcd_locate(1,0);
            sprintf(buff, "%d.%d.%d.%d", AppConfig.PrimaryDNSServer.v[0], AppConfig.PrimaryDNSServer.v[1], AppConfig.PrimaryDNSServer.v[2], AppConfig.PrimaryDNSServer.v[3]);                                                 
            break;
            
            case DISP_CONFIG_DNS2:
            lcd_str("DNS2:");
            lcd_locate(1,0);
            sprintf(buff, "%d.%d.%d.%d", AppConfig.SecondaryDNSServer.v[0], AppConfig.SecondaryDNSServer.v[1], AppConfig.SecondaryDNSServer.v[2], AppConfig.SecondaryDNSServer.v[3]);                         
            break;            
            
            default:
            break;
        }
        lcd_str(buff);        
        disp_config_stage++;
        if (disp_config_stage > DISP_CONFIG_DNS2) disp_config_stage = DISP_CONFIG_IP;
        timer = millis();
    }    
}

void backlight_on (void) {
    i2c_send_byte(0xEF, PCF8574_IO_ADDR);
    backlight_timer = millis();
}