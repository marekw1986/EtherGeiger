#include "../lcd/i2c.h"

#define BME280_ADDR 0xEC

void bme_init(void);
uint8_t bme_read_data(uint8_t reg);
void bme_write_data(uint8_t reg, uint8_t value);
uint8_t bme_setup(void);
void bme_read_compensation_data(void);
void bme_set_sampling(void);
void bme_read_temp_press_and_hum(void);
double bme_get_temperature(void);
double bme_get_pressure(void);
double bme_get_humidity(void);
double bme_get_altitude(double p, double p0);
