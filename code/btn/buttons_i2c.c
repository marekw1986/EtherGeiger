#include "buttons_i2c.h"
#include "../time/time.h"
#include "../lcd/i2c.h"
#include "buttons_i2c.h"

void button_init(button_t *btn, uint8_t *port, uint8_t pin_bm, void (*push_proc)(void), void (*long_proc)(void)) {
    btn->port = port;
    btn->pin_bm = pin_bm;
    btn->push_proc = push_proc;
    btn->long_proc = long_proc;
    btn->timer = 0;
    btn->state = 0;
}


void button_handle(button_t *btn) {
    uint8_t pressed;
    enum {IDLE, DEBOUNCE, WAIT_LONG, WAIT_RELEASE};
    
    pressed = !(*(btn->port) & (btn->pin_bm));
    if(pressed && !(btn->state)) {
        btn->state = DEBOUNCE;
        btn->timer = millis();
    }
    else if (btn->state) {
        if(pressed && (btn->state)==DEBOUNCE && ((uint32_t)(millis()-(btn->timer)) >= 20)) {
            btn->state = WAIT_LONG;
            btn->timer = millis();
        }
        else if (!pressed && (btn->state)==WAIT_LONG) {
            if (btn->push_proc) (btn->push_proc)();
            btn->state = IDLE;
        }
        else if (pressed && (btn->state)==WAIT_LONG && ((uint32_t)(millis()-(btn->timer)) >= 2000)) {
            if (btn->long_proc) (btn->long_proc)();
            btn->state = WAIT_RELEASE;
            btn->timer = 0;
        }
    }
    if ((btn->state)==WAIT_RELEASE && !pressed) btn->state = IDLE;
}