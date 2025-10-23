#include <stdio.h>
#include "hamqtt.h"
#include "../geiger/geiger.h"
#include "../config/config.h"
#include "../net/MQTT.h"
#include "../common.h"

#define DISCOVERY_MSG_NUMBER 4

typedef struct {
    const char* name;
    const char* state_topic;
    const char* unit_of_measurement;
    const char* device_class;
    const char* value_template;
    const char* unique_id;
    const uint8_t update_interval;
} disco_message_t;

const disco_message_t discoveryMessagesConst[DISCOVERY_MSG_NUMBER] = {
    {
        "Promieniowanie",
        "radiation",
        "uSiv/h",
        NULL,
        "{{ value | float }}",
        "rad",
        10
    },
    {
        "Temperatura",
        "temperature",
        "\u00B0C", //"\\xC2\\xB0C",
        "temperature",
        "{{ value | float }}",
        "temp",
        10
    },
    {
        "Wilgotnosc powietrza",
        "humidity",
        "%",
        "humidity",
        "{{ value | float }}",
        "hum",
        10
    },
    {
        "Cisnienie atmosferyczne",
        "pressure",
        "hPa",
        "pressure",
        "{{ value | float }}",
        "press",
        10
    }
};

uint32_t message_timers[DISCOVERY_MSG_NUMBER];

char MQTTTopicBuffer[128];
char MQTTMessageBuffer[512];
uint8_t mqttMessageSessionActive = 0;
uint8_t mqttMessageNumber = 0;
uint8_t discoveryMessagesSent = 0;

extern uint16_t egeigerId;

typedef enum {HA_IDLE, HA_SEND_DISCOVERY, HA_SEND_MESSAGES} hamqtt_state_t;
hamqtt_state_t hamqtt_state = HA_IDLE;

enum {MQTT_RADIATION, MQTT_TEMPERATURE, MQTT_HUMIDITY, MQTT_PRESSURE};

static void mqtt_log_next_value(void);
static void handle_mqtt_log(void);
static void handle_send_discovery_message(void);
static void next_discovery_message(void);

void mqtt_init (void) {
    if(MQTTBeginUsage()) {
        printf("Starting MQTT\r\n");
        MQTTClient.Server.szRAM = config.mqtt_server;	// MQTT server address
        MQTTClient.ServerPort = 1883;
        MQTTClient.ConnectId.szRAM = "d:atlantis:ethergeiger:1";
        MQTTClient.Topic.szRAM = config.mqtt_topic;
        MQTTClient.Username.szRAM = config.mqtt_username;
        MQTTClient.Password.szRAM = config.mqtt_password;                
        MQTTClient.bSecure=FALSE;
        MQTTClient.QOS=1;
        MQTTClient.KeepAlive=MQTT_KEEPALIVE_LONG;   
    }
    discoveryMessagesSent = 0;
    memset(message_timers, 0x00, sizeof(message_timers));
}

void mqtt_on_connect(void) {
    printf("MQTT connected\r\n");
    hamqtt_state = discoveryMessagesSent ? HA_SEND_MESSAGES : HA_SEND_DISCOVERY;
    mqttMessageNumber = 0;
    //MQTTSubscribe("testTopic", mqtt_on_subscribe);
}

void mqtt_on_publish(void) {
    printf("MQTT published\r\n");
    mqtt_last_publish = uptime();  //TODO
}

void mqtt_on_subscribe(void) {
    printf("MQTT subscribed\r\n");
}

void mqtt_on_disconnect(void) {
    printf("MQTT disconnected - callback\r\n");
    hamqtt_state = HA_IDLE;
}

void mqtt_on_receive(const char *topic, const WORD topicLength, const BYTE *payload, const WORD payloadLength) {
    char tmp[512];
    memcpy(tmp, topic, topicLength);
    tmp[topicLength] = '\0';
    printf("Received topic: %s\r\n", tmp);
    memcpy(tmp, payload, payloadLength);
    tmp[payloadLength] = '\0';
    printf("Received payload:\r\n%s\r\n", tmp);
    printf("Payload len: %d\r\n", payloadLength);
}

static void handle_mqtt_log(void) {
    if ( uptime() <= 60 ) {
        return;
    }
    const disco_message_t* currDiscoConst = &discoveryMessagesConst[mqttMessageNumber];
    if ( (uint32_t)(uptime()-message_timers[mqttMessageNumber]) < currDiscoConst->update_interval ) {
        return;
    }
    snprintf(MQTTTopicBuffer, sizeof(MQTTTopicBuffer), "%s/%s", config.mqtt_topic, currDiscoConst->state_topic);
    switch (mqttMessageNumber) {
        case MQTT_RADIATION:
        snprintf(MQTTMessageBuffer, sizeof(MQTTMessageBuffer), "%.4f", cpm2sievert(cpm()));
        break;

        case MQTT_TEMPERATURE:
        snprintf(MQTTMessageBuffer, sizeof(MQTTMessageBuffer), "%.2f", bme_temperature);
        break;

        case MQTT_HUMIDITY:
        snprintf(MQTTMessageBuffer, sizeof(MQTTMessageBuffer), "%.2f", bme_humidity);
        break;

        case MQTT_PRESSURE:
        snprintf(MQTTMessageBuffer, sizeof(MQTTMessageBuffer), "%.2f", bme_pressure);
        break;

        default:
        return;
    }
    printf("Sending %s to topic %s\n", MQTTMessageBuffer, MQTTTopicBuffer);
    MQTTSendStr(MQTTTopicBuffer, MQTTMessageBuffer, mqtt_log_next_value);
    mqttMessageSessionActive = 1;
    message_timers[mqttMessageNumber] = uptime();
}

static void mqtt_log_next_value(void) {
    mqttMessageNumber++;
    mqttMessageSessionActive = 0;
    if (mqttMessageNumber >= DISCOVERY_MSG_NUMBER) {
        mqttMessageNumber = 0;
    }
    mqtt_last_publish = uptime();
}

void handle_hamqtt(void) {
    if (mqttMessageSessionActive) {
        return;
    }
    
    switch (hamqtt_state) {
        case HA_IDLE:
        break;
        
        case HA_SEND_DISCOVERY:
        handle_send_discovery_message();
        break;
        
        case HA_SEND_MESSAGES:
        handle_mqtt_log();
        break;
    }
}

static void handle_send_discovery_message(void) {
    if (mqttMessageNumber >= DISCOVERY_MSG_NUMBER) {
        printf("Error: trying to report discovery message with id (%d) >= %d", mqttMessageNumber, DISCOVERY_MSG_NUMBER);
        mqttMessageNumber = 0;
        return;
    }

    const disco_message_t* currDiscoConst = &discoveryMessagesConst[mqttMessageNumber];
//    const char* valueName = discoveryMessagesConst[mqttMessageNumber].state_topic; 
    snprintf(MQTTTopicBuffer, sizeof(MQTTTopicBuffer), "homeassistant/sensor/eg%04lX%s/config", egeigerId, currDiscoConst->unique_id);
    printf("Prepared topic for discovery message: %s\n", MQTTTopicBuffer);
    
    char class[128];
    if (currDiscoConst->device_class != NULL) {
        snprintf(class, sizeof(class), "\"device_class\":\"%s\",", currDiscoConst->device_class);
    }
    else {
        class[0] = '\0';
    }
    
    char unique_id[64];
    snprintf(unique_id, sizeof(unique_id), "eg%04lX%s", egeigerId, currDiscoConst->unique_id);
    
    int siz = snprintf(MQTTMessageBuffer, sizeof(MQTTMessageBuffer), "{\"name\":\"%s\",\"stat_t\":\"%s/%s\",\"unit_of_meas\":\"%s\",%s\"uniq_id\":\"%s\",\"dev\":{\"ids\":[\"EG%04lX\"],\"name\":\"EtherGeiger\"}}", currDiscoConst->name, config.mqtt_topic, currDiscoConst->state_topic, currDiscoConst->unit_of_measurement, class, unique_id, egeigerId);
    printf("Prepared content of discovery message: %s\n", MQTTMessageBuffer);
    printf("Size: %d\n", siz);
    
    MQTTSendStrRetained(MQTTTopicBuffer, MQTTMessageBuffer, next_discovery_message);
    mqttMessageSessionActive = 1;
}

static void next_discovery_message(void) {
    mqttMessageSessionActive = 0;
    mqttMessageNumber++;
    if (mqttMessageNumber >= DISCOVERY_MSG_NUMBER) {
        mqttMessageNumber = 0;
        discoveryMessagesSent = 1;
        hamqtt_state = HA_SEND_MESSAGES;
        return;
    }
}