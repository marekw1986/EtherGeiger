#include <stdio.h>

#include "common.h"
#include "config/config.h"
#include "net/TCPIP.h"
#include "time/time.h"

double bme_temperature;
double bme_pressure;
double bme_humidity;
uint32_t bmp_timestamp = 0;

int16_t dht_temperature;
uint16_t dht_humidity;
uint32_t dht_timestamp = 0;

uint32_t mqtt_last_publish = 0;


FRESULT FormatSpiFlashDisk (void) {
    FRESULT res;
    char buffer[4096];
    res = f_mkfs("0:", 0, buffer, sizeof(buffer));
    if (res != FR_OK) {printf("f_mmkfs error code: %i\r\n", res);}
    else {printf("f_mkfs OK\r\n");}
    return res;
}

unsigned char BcdToByte(unsigned char bcd) {
    return ((bcd & 0xF0) >> 4) * 10 + (bcd & 0x0F);
}

unsigned char ByteToBcd(unsigned char i) {
    return ((i / 10) << 4) + (i % 10);
}

unsigned char StringToMACAddress(BYTE* str, MAC_ADDR* MACAddress) {
    int values[6];
    unsigned char i;
    for (i=0; i<17; i++) {
        if (i % 3 != 2 && !isxdigit(str[i])) {
            return 0;
        }
        if (i % 3 == 2 && str[i] != ':') {
            return 0;
        }
    }
    if (str[17] != '\0') return 0;
    
    if (sscanf(str, "%x:%x:%x:%x:%x:%x", &values[0], &values[1], &values[2], &values[3], &values[4], &values[5]) == 6) {
        for (i=0; i<6; i++) {
            MACAddress->v[i] = (uint8_t)values[i];
        }
        return 1;
    }
    return 0;
}

char* constructJSON (char* buf, uint16_t len) {
    char tmp[128];
    snprintf(buf, len, "{\n\t\"id\":\t\"%s\",\n\t\"class\":\t\"EtherGeiger\"", config.devname);
    if (uptime() > 60 && rtccIsSet()) {
        snprintf(tmp, sizeof(tmp)-1, ",\n\t\"geiger\":\t{\n\t\t\"timestamp\":\t%lu,\n\t\t\"radiation\":\t%.4f\n\t}", rtccGetTimestamp(), cpm2sievert(cpm()));
        strncat(buf, tmp, len-strlen(buf));
    }
    if (bme_timestamp) {
        snprintf(tmp, sizeof(tmp)-1, ",\n\t\"bme280\":\t{\n\t\t\"timestamp\":\t%lu,\n\t\t\"temperature\":\t%.2f,\n\t\t\"humidity\":\t%.2f,\n\t\t\"pressure\":\t%.2f\n\t}", bme_timestamp, bme_temperature, bme_humidity, bme_pressure);
        strncat(buf, tmp, len-strlen(buf));
    }
    strncat(buf, "\n}", len-strlen(buf));
    //snprintf(buf, len, "{\n\t\"id\":\t\"%s\",\n\t\"class\":\t\"EtherGeiger\",\n\t\"geiger\":\t{\n\t\t\"timestamp\":\t%lu,\n\t\t\"radiation\":\t%.4f\n\t}\n\t\"bme280\":\t{\n\t\t\"timestamp\":\t%lu,\n\t\t\"temperature\":\t%.2f,\n\t\t\"humidity\":\t%.2f\n\t\t\"pressure\":\t%.2f,\n\t},\n}", config.devname, rtccGetTimestamp(), cpm2sievert(cpm()), bme_timestamp, bme_temperature, bme_humidity, bme_pressure);
    return buf;
}

uint8_t contain_space(const char* str) {
	while(*str) {
		if (isspace(*str)) return 1;
		str++;
	}
	return 0;
}