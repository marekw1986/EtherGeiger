/*********************************************************************
 *
 *	MQTT Internet Of Things (MQTT) Client
 *	Module for Microchip TCP/IP Stack
 *   -Provides ability to receive Emails
 *	 -Reference: RFC 2821
 *
 *********************************************************************
 * FileName:        MQTT.c
 * Dependencies:    TCP, ARP, DNS, Tick
 * Processor:       PIC18, PIC24F, PIC24H, dsPIC30F, dsPIC33F, PIC32
 * Compiler:        Microchip C32 v1.05 or higher
 *					Microchip C30 v3.12 or higher
 *					Microchip C18 v3.30 or higher
 *					HI-TECH PICC-18 PRO 9.63PL2 or higher
 * Company:         Microchip Technology, Inc.
 *
 * Software License Agreement
 *
 * Copyright (C) 2002-2009 Microchip Technology Inc.  All rights reserved.
 * Copyright (C) 2013,2014 Cyberdyne.  All rights reserved.
 *
 * Microchip licenses to you the right to use, modify, copy, and
 * distribute:
 * (i)  the Software when embedded on a Microchip microcontroller or
 *      digital signal controller product ("Device") which is
 *      integrated into Licensee's product; or
 * (ii) ONLY the Software driver source files ENC28J60.c, ENC28J60.h,
 *		ENCX24J600.c and ENCX24J600.h ported to a non-Microchip device
 *		used in conjunction with a Microchip ethernet controller for
 *		the sole purpose of interfacing with the ethernet controller.
 *
 * You should refer to the license agreement accompanying this
 * Software for additional information regarding your rights and
 * obligations.

 *	https://developer.ibm.com/iot/recipes/improvise/
 *	https://internetofthings.ibmcloud.com/dashboard/#/organizations/mkxk7/devices
 *	https://developer.ibm.com/iot/recipes/improvise-registered-devices/
 *
 * Author               Date    Comment
 *~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 * Howard Schlunder     3/03/06	Original
 * Howard Schlunder			11/2/06	Vastly improved for release
 * Dario Greggio				30/9/14	client MQTT (IoT), inizio
 * - A simple client for MQTT.  Original Code - Nicholas O'Leary  http://knolleary.net
 * - Adapted for Spark Core by Chris Howard - chris@kitard.com  (Based on PubSubClient 1.9.1)
 *  D. Guz                           20/01/15  Fix, cleanup, testing
 ********************************************************************/
#define __MQTT_C

#include <xc.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <p32xxxx.h>
#include "../TCPIPConfig.h"
#include "MQTT.h"

#if defined(STACK_USE_MQTT_CLIENT)

#include "TCPIP.h"

#include "../GenericTypeDefs.h"

/****************************************************************************
  Section:
	MQTT Client Configuration Parameters
  ***************************************************************************/
#define MQTT_PORT           1883					// Default port to use when unspecified
#define MQTT_PORT_SECURE	8883					// Default port to use when unspecified
#define MQTT_SERVER_REPLY_TIMEOUT	(TICK_SECOND*8)		// How long to wait before assuming the connection has been dropped (default 8 seconds)

#define ISPUBLISH   ((MQTTBuffer[0] & 0xF0) == MQTTPUBLISH)
#define ISCONNACK   ((MQTTBuffer[0] & 0xF0) == MQTTCONNACK)
#define ISSUBACK   ((MQTTBuffer[0] & 0xF0) == MQTTSUBACK)
#define ISPUBACK   ((MQTTBuffer[0] & 0xF0) == MQTTPUBACK)

#define MQTT_TX_RING_BUFFER_SIZE 16
#define MQTT_TX_RING_BUFFER_MASK (MQTT_TX_RING_BUFFER_SIZE-1)

typedef enum {MQTT_MESSAGE_PUBLISH, MQTT_MESSAGE_SUBSCRIBE, MQTT_MESSAGE_UNSUBSCRIBE} MQTTMessageType_t;

typedef struct {
    MQTTMessageType_t type;
    const char* topic;
    const char* payload;
    WORD payloadlen;
    void (*on_action)(void);
} MQTTMessage_t;

static MQTTMessage_t MQTTTxRingBuffer[MQTT_TX_RING_BUFFER_SIZE];
static uint8_t MQTTTxRingBufferHead = 0;
static uint8_t MQTTTxRingBufferTail = 0;

void (*connect_Callback)(void) = NULL;
void (*subscribe_Callback)(void) = NULL;
void (*unsubscribe_Callback)(void) = NULL;
void (*receive_Callback)(const char *, const WORD, const BYTE *, const WORD) = NULL;
void (*publish_Callback)(void) = NULL;


static BOOL MQTTReadPacket(WORD *retlen, BYTE *retll);  //BYTE *
static void MQTTPrepareBuffer(void);
static void MQTTPutMessageInRingBuffer(MQTTMessageType_t type, const char* topic, const char* payload, WORD payloadlen, void(*cb)(void));
static BOOL MQTTWrite(BYTE , BYTE *, WORD );
static WORD MQTTWriteString(const char *, BYTE *, WORD );
static BOOL MQTTReadByte(BYTE *ch);
static BOOL MQTTPing(void);
static BOOL MQTTPubACK(WORD);

/****************************************************************************
  Section:
	MQTT Client Public Variables
  ***************************************************************************/
// The global set of MQTT_POINTERS.
// Set these parameters after calling MQTTBeginUsage successfully.
MQTT_POINTERS MQTTClient;

/****************************************************************************
  Section:
	MQTT Client Internal Variables
  ***************************************************************************/
static IP_ADDR MQTTServer;						// IP address of the remote MQTT server
static TCP_SOCKET MySocket = INVALID_SOCKET;	// Socket currently in use by the MQTT client

WORD MQTTResponseCode;

BYTE MQTTBuffer[MQTT_MAX_PACKET_SIZE];
static WORD MQTTBufferIdx = 0;
typedef enum {RPSM_INIT, RPSM_READ_LEN, RPSM_READ_DATA, RPSM_FINALIZE} RPSM_t;
static BYTE RPSMState = RPSM_INIT;

static WORD lastInActivity=0,lastOutActivity=0;

static DWORD LastPingTick = 0;
static DWORD AckTimer = 0;
static DWORD PingTimer = 0;

// Message state machine for the MQTT Client
static enum {
    /*
	MQTT_HOME = 0,					// Idle start state for MQTT client 
	MQTT_BEGIN,							// Preparing to make connection
	MQTT_NAME_RESOLVE,			// Resolving the MQTT server address
	MQTT_OBTAIN_SOCKET,			// Obtaining a socket for the MQTT connection
	MQTT_SOCKET_OBTAINED,		// MQTT connection successful
	//MQTT_CLOSE,							// MQTT socket is closed
	MQTT_CONNECT,						// connection
	MQTT_CONNECT_ACK,				// connected
	MQTT_PUBLISH,						// Publish
	MQTT_PUBLISH_ACK,				// Publish command accepted (if QOS)
	MQTT_PUBACK,						// PublishACK
	MQTT_SUBSCRIBE,					// Subscribe
	MQTT_SUBSCRIBE_ACK,			// Subscribe command accepted (if QOS)
	MQTT_UNSUBSCRIBE,					// Subscribe
	MQTT_UNSUBSCRIBE_ACK,			// Subscribe command accepted (if QOS)
	MQTT_PING,							// Ping
	MQTT_PING_ACK,					// Pingback
	MQTT_LOOP,							// Idle Loop for receiving messages
	MQTT_IDLE=MQTT_LOOP,		// Idle Loop for receiving messages
	MQTT_DISCONNECT_INIT,		// Sending Disconnect
	MQTT_DISCONNECT,				// Disconnect accepted, and...
	MQTT_QUIT								// ...connection closing
	} MQTTState;
    */

        MQTT_HOME = 0,
        MQTT_BEGIN,
        MQTT_NAME_RESOLVE,
        MQTT_OBTAIN_SOCKET,
        MQTT_SOCKET_OBTAINED,
        MQTT_CONNECT,
        MQTT_CONNECT_ACK,
        MQTT_PING,
        MQTT_PING_ACK,
        MQTT_PUBLISH,
        MQTT_SUBSCRIBE,
        MQTT_PUBACK,
        MQTT_UNSUBSCRIBE,
        MQTT_DISCONNECT_INIT,
        MQTT_DISCONNECT,
        MQTT_CLOSE,
        MQTT_QUIT,
        MQTT_RECONNECT,
        MQTT_RECONNECT_WAIT,
        MQTT_IDLE
    } MQTTState;

// Internal flags used by the MQTT Client
static union {
	WORD Val;
	struct {
		unsigned char MQTTInUse:1;
		unsigned char ReceivedSuccessfully:1;
		unsigned char ConnectedOnce:1;
		unsigned char PingOutstanding:1;
        unsigned char WaitingAck:1;
		unsigned char filler:5;
		} bits;
	} MQTTFlags = {0x0000};
	

/****************************************************************************
  Section:
	MQTT Client Internal Function Prototypes
  ***************************************************************************/


/****************************************************************************
  Section:
	MQTT Function Implementations
  ***************************************************************************/
    
void MQTTSendData(const char* topic, const char* payload, WORD payloadlen, void(*cb)(void)) {
    if ( (!topic) || (!payload) ) return;
    MQTTPutMessageInRingBuffer(MQTT_MESSAGE_PUBLISH, topic, payload, payloadlen, cb);
}

void MQTTSendStr(const char* topic, const char* payload, void(*cb)(void)) {
    MQTTSendData(topic, payload, strlen(payload), cb);
}

void MQTTSubscribe(const char* topic, void(*cb)(void)) {
    MQTTPutMessageInRingBuffer(MQTT_MESSAGE_SUBSCRIBE, topic, NULL, 0, cb);
}

void MQTTUnscribe_(const char* topic, void(*cb)(void)) {
    MQTTPutMessageInRingBuffer(MQTT_MESSAGE_UNSUBSCRIBE, topic, NULL, 0, cb);
}

void MQTTPutMessageInRingBuffer(MQTTMessageType_t type, const char* topic, const char* payload, WORD payloadlen, void(*cb)(void)) {
    MQTTMessage_t data;
    uint8_t tmp_head;
    
    if (!MQTTClient.bConnected) return;
    
    data.type = type;
    data.topic = topic;
    data.payload = payload;
    data.payloadlen = payloadlen;
    data.on_action = cb;
    
    tmp_head = ( MQTTTxRingBufferHead + 1) & MQTT_TX_RING_BUFFER_MASK;
    if (tmp_head == MQTTTxRingBufferTail) {
        MQTTTxRingBufferHead = MQTTTxRingBufferTail;
    }
    else {
        MQTTTxRingBufferHead = tmp_head;
        MQTTTxRingBuffer[tmp_head] = data;
    }    
}    

void MQTTSetConnectCallback(void(*callback)(void)) {
    if (callback) {
        connect_Callback = callback;
    }
}

void MQTTSetReceiveCallback(void(*callback)(const char *, const WORD, const BYTE *, const WORD)) {
    if (callback) {
        receive_Callback = callback;
    }
}

/*****************************************************************************
  Function:
	BOOL MQTTBeginUsage(void)

  Summary:
	Requests control of the MQTT client module.

  Description:
	Call this function before calling any other MQTT Client APIs.  This 
	function obtains a lock on the MQTT Client, which can only be used by
	one stack application at a time.  Once the application is finished
	with the MQTT client, it must call MQTTEndUsage to release control
	of the module to any other waiting applications.
	
	This function initializes all the MQTT state machines and variables
	back to their default state.

  Precondition:
	None

  Parameters:
	None

  Return Values:
	TRUE - The application has successfully obtained control of the module
	FALSE - The MQTT module is in use by another application.  Call 
		MQTTBeginUsage again later, after returning to the main program loop
  ***************************************************************************/
BOOL MQTTBeginUsage(void) {

	if(MQTTFlags.bits.MQTTInUse) return FALSE;

    PingTimer = TickGet();   //Delay first ping
	MQTTFlags.Val = 0x0000;
	MQTTFlags.bits.MQTTInUse = TRUE;
	MQTTState = MQTT_BEGIN;
	memset((void*)&MQTTClient, 0x00, sizeof(MQTTClient));
	MQTTClient.Ver=MQTTPROTOCOLVERSION;
	MQTTClient.KeepAlive=MQTT_KEEPALIVE_LONG;
	MQTTClient.MsgId=1;
    MQTTTxRingBufferHead = 0;
    MQTTResponseCode = 0;
	
	return TRUE;
	}

/*****************************************************************************
  Function:
	WORD MQTTEndUsage(void)

  Summary:
	Releases control of the MQTT client module.

  Description:
	Call this function to release control of the MQTT client module once
	an application is finished using it.  This function releases the lock
	obtained by MQTTBeginUsage, and frees the MQTT client to be used by 
	another application.

  Precondition:
	MQTTBeginUsage returned TRUE on a previous call.

  Parameters:
	None

  Return Values:
	MQTT_SUCCESS - A message was successfully sent
	MQTT_RESOLVE_ERROR - The MQTT server could not be resolved
	MQTT_CONNECT_ERROR - The connection to the MQTT server failed or was prematurely terminated
	1-199 and 300-399 - The last MQTT server response code BOH!
  ***************************************************************************/
WORD MQTTEndUsage(void) {
	if(!MQTTFlags.bits.MQTTInUse) return MQTT_FAIL;
    
	// Release the DNS module, if in use
	if(MQTTState == MQTT_NAME_RESOLVE) {
		DNSEndUsage();
    }
	
	if(MQTTClient.bConnected) {
		MQTTDisconnect();
    }
    else {
        // Release the TCP socket, if in use
        if(MySocket != INVALID_SOCKET) {
            TCPDisconnect(MySocket);
            MySocket = INVALID_SOCKET;
        } 
        // Release the MQTT module
        MQTTFlags.bits.MQTTInUse = FALSE;
        MQTTClient.bConnected = FALSE;
        MQTTState = MQTT_HOME;
    }

	if(MQTTFlags.bits.ReceivedSuccessfully)	{
		return MQTT_SUCCESS;
    }
    
    return MQTT_FAIL;
}

/*****************************************************************************
  Function:
	void MQTTTask(void)

  Summary:
	Performs any pending MQTT client tasks

  Description:
	This function handles periodic tasks associated with the MQTT client,
	such as processing initial connections and command sequences.

  Precondition:
	None

  Parameters:
	None

  Returns:
	None

  Remarks:
	This function acts as a task (similar to one in an RTOS).  It
	performs its task in a co-operative manner, and the main application
	must call this function repeatedly to ensure that all open or new
	connections are served in a timely fashion.
  ***************************************************************************/
void MQTTTask(void) {
	WORD			i;
	WORD			w;
	static DWORD	Timer;
	static WORD nextMsgId;
	static ROM BYTE *ROMStrPtr;
	static BYTE 	*RAMStrPtr;

	switch(MQTTState)	{
		case MQTT_HOME:
			// MQTTBeginUsage() is the only function which will kick 
			// the state machine into the next state
			break;

		case MQTT_BEGIN:
            MQTTTxRingBufferHead = MQTTTxRingBufferTail;    //Clean message buffer
			// Obtain ownership of the DNS resolution module
			if(!DNSBeginUsage())
				break;

			// Obtain the IP address associated with the MQTT mail server
			if(MQTTClient.Server.szRAM) {
#if defined(__18CXX)
				if(MQTTClient.ROMPointers.Server)
					DNSResolveROM(MQTTClient.Server.szROM, DNS_TYPE_A);
				else
#endif
				DNSResolve(MQTTClient.Server.szRAM, DNS_TYPE_A);
            }
			else {
				MQTTState=MQTT_HOME;		// can't do anything
				break;
            }
			
			Timer = TickGet();
			MQTTState = MQTT_NAME_RESOLVE;
			break;

		case MQTT_NAME_RESOLVE:
			// Wait for the DNS server to return the requested IP address
			if(!DNSIsResolved(&MQTTServer))	{
				// Timeout after 6 seconds of unsuccessful DNS resolution
				if(TickGet() - Timer > 6*TICK_SECOND)	{
					MQTTResponseCode = MQTT_RESOLVE_ERROR;
					MQTTState = MQTT_RECONNECT;  //was MQTT_HOME
					DNSEndUsage();
                }
				break;
            }

			// Release the DNS module, we no longer need it
			if(!DNSEndUsage()) {
				// An invalid IP address was returned from the DNS 
				// server.  Quit and fail permanantly if host is not valid.
				MQTTResponseCode = MQTT_RESOLVE_ERROR;
				MQTTState = MQTT_RECONNECT;  //was MQTT_HOME
				break;
            }

			MQTTState = MQTT_OBTAIN_SOCKET;
			// No need to break here

		case MQTT_OBTAIN_SOCKET:
			// Connect a TCP socket to the remote MQTT server
			MySocket = TCPOpen(MQTTServer.Val, TCP_OPEN_IP_ADDRESS, MQTTClient.ServerPort, TCP_PURPOSE_DEFAULT);
			
			// Abort operation if no TCP sockets are available
			// If this ever happens, add some more 
			// TCP_PURPOSE_DEFAULT sockets in TCPIPConfig.h
			if(MySocket == INVALID_SOCKET) {
				break;
            }

			MQTTState = MQTT_SOCKET_OBTAINED;
			Timer = TickGet();
			// No break; fall into MQTT_SOCKET_OBTAINED
			
		
		case MQTT_SOCKET_OBTAINED:
			if(!TCPIsConnected(MySocket)) {
				// Don't stick around in the wrong state if the
				// server was connected, but then disconnected us.
				// Also time out if we can't establish the connection to the MQTT server
				if(MQTTFlags.bits.ConnectedOnce || ((LONG)(TickGet()-Timer) > (LONG)(MQTT_SERVER_REPLY_TIMEOUT)))	{
					MQTTResponseCode = MQTT_CONNECT_ERROR;
					MQTTState = MQTT_CLOSE;
                }

				break;
            }
			MQTTFlags.bits.ConnectedOnce = TRUE;
            MQTTState = MQTT_CONNECT;
            break;

		case MQTT_CONNECT:
			if(!MQTTConnected()) {

				if(MQTTFlags.bits.ConnectedOnce) {
					nextMsgId = 1;
					BYTE d[9] = {0x00,0x06,'M','Q','I','s','d','p',MQTTPROTOCOLVERSION};
					// Leave room in the buffer for header and variable length field
					WORD length = 5;
					unsigned int j;

					for(j=0; j<9; j++) MQTTBuffer[length++] = d[j];

					BYTE v;
					if(MQTTClient.WillTopic.szRAM) {
						MQTTClient.QOS=MQTTClient.WillQOS;
						v = 0x06 | (MQTTClient.WillQOS<<3) | (MQTTClient.WillRetain<<5);
                    }
					else { 
						v = 0x02;
                    }

					if(MQTTClient.Username.szRAM) {
						v |= 0x80;
						if(MQTTClient.Password.szRAM) 
							v = v | (0x80>>1);
                    }

					MQTTBuffer[length++] = v;

					MQTTBuffer[length++] = HIBYTE(MQTTClient.KeepAlive);
					MQTTBuffer[length++] = LOBYTE(MQTTClient.KeepAlive);

#if defined(__18CXX)
					if(MQTTClient.ROMPointers.ConnectId) 
						length = MQTTWriteROMString(MQTTClient.ConnectId.szROM,MQTTBuffer,length);
					else
#endif
						length = MQTTWriteString(MQTTClient.ConnectId.szRAM,MQTTBuffer,length);
					if(MQTTClient.WillTopic.szRAM) {
#if defined(__18CXX)
						if(MQTTClient.ROMPointers.WillTopic) 
							length = MQTTWriteString(MQTTClient.WillTopic.szROM,MQTTBuffer,length);
						else
#endif
							length = MQTTWriteString(MQTTClient.WillTopic.szRAM,MQTTBuffer,length);
#if defined(__18CXX)
						if(MQTTClient.ROMPointers.WillMessage) 
							length = MQTTWriteROMString(MQTTClient.WillMessage.szROM,MQTTBuffer,length);
						else
#endif
							length = MQTTWriteString(MQTTClient.WillMessage.szRAM,MQTTBuffer,length);
                    }

					if(MQTTClient.Username.szRAM) {		// il check su union � ok!
#if defined(__18CXX)
						if(MQTTClient.ROMPointers.Username) {
							length = MQTTWriteROMString(MQTTClient.Username.szROM,MQTTBuffer,length);
							if(MQTTClient.Password.szRAM) {
								if(MQTTClient.ROMPointers.Password) {
									length = MQTTWriteROMString(MQTTClient.Password.szROM,MQTTBuffer,length);
                                }	
								else {
									length = MQTTWriteString(MQTTClient.Password.szRAM,MQTTBuffer,length);
                                }	
                            }
                        }	
						else {
#endif
							length = MQTTWriteString(MQTTClient.Username.szRAM,MQTTBuffer,length);
							if(MQTTClient.Password.szRAM) {
#if defined(__18CXX)
								if(MQTTClient.ROMPointers.Password)
									length = MQTTWriteROMString(MQTTClient.Password.szROM,MQTTBuffer,length);
								else
#endif
									length = MQTTWriteString(MQTTClient.Password.szRAM,MQTTBuffer,length);
                            }
#if defined(__18CXX)
                        }
#endif
                    }
                    MQTTWrite(MQTTCONNECT,MQTTBuffer,length-5);
                    MQTTPrepareBuffer();
                    MQTTState=MQTT_CONNECT_ACK;
                    MQTTResponseCode=MQTT_SUCCESS;
                }
                //lastInActivity =TickGet();
            }
			break;
		case MQTT_CONNECT_ACK:
            PingTimer = TickGet();   //Delay ping check
			lastInActivity =TickGet(); 
			WORD len = 0;
            if(!MQTTReadPacket(&len, NULL)) {
                break;
            }

			if(len >= 4 && ISCONNACK) {
 				switch(MQTTBuffer[3]) {
					case 0:
						lastInActivity = TickGet();
						MQTTFlags.bits.PingOutstanding = FALSE;
						MQTTClient.bConnected=TRUE;
                        //printf("authorization OK!\r\n");
						break;
					case 1:		// unacceptable protocol version
						MQTTClient.bConnected=FALSE;		// 
						MQTTResponseCode=MQTT_BAD_PROTOCOL;
                        //printf("bad protocol!\r\n");
						break;
					case 2:		// identifier rejected
						MQTTClient.bConnected=FALSE;		// 
						MQTTResponseCode=MQTT_IDENT_REJECTED;
                        //printf("identifier rejected!\r\n");
						break;
					case 3:		// server unavailable
						MQTTClient.bConnected=FALSE;		// 
						MQTTResponseCode=MQTT_SERVER_UNAVAILABLE;
                        //printf("server unavailable!\r\n");
						break;
					case 4:		// bad user o password
						MQTTClient.bConnected=FALSE;		// 
						MQTTResponseCode=MQTT_BAD_USER_PASW;
                        //printf("bad user or password!\r\n");
						break;
					case 5:		// unauthorized
						MQTTClient.bConnected=FALSE;		// 
						MQTTResponseCode=MQTT_UNAUTHORIZED;
                        //printf("unauthorized!\r\n");
						break;
                }
                MQTTPrepareBuffer();
                MQTTState=MQTT_IDLE;    //go to idle now
                TCPWasReset(MySocket);  //This is needed to prevent false reset later
                if (connect_Callback) {
                    connect_Callback();
                }
            }
			break;

		case MQTT_PING:
			MQTTBuffer[0]=MQTTPINGREQ;
			MQTTBuffer[1]=0;
			if(TCPIsPutReady(MySocket) >= 2) {
				MQTTPutArray(MQTTBuffer,2);
				lastOutActivity = TickGet();
                //MQTTPrepareBuffer();
				MQTTState=MQTT_IDLE;			//
            }
            else {
                //printf("Not able to send PING. Closing\r\n");
                MQTTState = MQTT_CLOSE;
            }
			break;

		case MQTT_PING_ACK:					// Pingback, 
			MQTTBuffer[0]=MQTTPINGRESP;
			MQTTBuffer[1]=0;
			if(TCPIsPutReady(MySocket)>=2) {
				MQTTPutArray(MQTTBuffer,2);
				lastOutActivity = TickGet();
                //MQTTPrepareBuffer();
				MQTTState=MQTT_IDLE;			// 
            }
			break;

		case MQTT_PUBLISH:	
			//publish				
			if(MQTTConnected()) {
				// Leave room in the buffer for header and variable length field
				WORD length = 5;
#if defined(__18CXX)
				if(MQTTClient.ROMPointers.Topic)
					length = MQTTWriteString(MQTTClient.Topic.szROM, MQTTBuffer,length);
				else
#endif
                length = MQTTWriteString(MQTTClient.Topic.szRAM, MQTTBuffer,length);
                
                if (MQTTClient.QOS) {
                    MQTTBuffer[length++] = HIBYTE(MQTTClient.MsgId);
                    MQTTBuffer[length++] = LOBYTE(MQTTClient.MsgId);
                }
				WORD i;
				for(i=0;i<MQTTClient.Plength;i++)
					MQTTBuffer[length++] = MQTTClient.Payload.szRAM[i];		// idem ROM/RAM ..
				BYTE header = MQTTPUBLISH | (MQTTClient.QOS ? (MQTTClient.QOS==2 ? MQTTQOS2 : MQTTQOS1) : MQTTQOS0);
				if(MQTTClient.Retained) header |= 1;

				//if(MQTTWrite(header,MQTTBuffer,length-5))		// si potrebbe spezzare in 2 per non rifare tutto il "prepare" qua sopra...
				MQTTWrite(header,MQTTBuffer,length-5);
                if (!MQTTClient.QOS) {  //No QoS, so we do not wait with executing callback
                    if (publish_Callback) { publish_Callback(); }
                }
                //MQTTPrepareBuffer();
                MQTTState=MQTT_IDLE;
                //printf("MQTT_PUBLISH -> MQTT_IDLE\r\n");
				MQTTResponseCode=MQTT_SUCCESS;

            }
			else {
				MQTTResponseCode=MQTT_OPERATION_FAILED;
                MQTTState = MQTT_CLOSE;
            }
			break;

		case MQTT_SUBSCRIBE:	
		//			subscribe(const char *topic, BYTE qos

		// mmm no	m_QOS=qos;
		// ma cmq usiamo lo stesso, per praticit�...
			if(/*MQTTClient.QOS < 0 || boh */ MQTTClient.QOS > 1) {
				break;
            }

			if(MQTTConnected()) {
				// Leave room in the buffer for header and variable length field
				WORD length = 5;
				nextMsgId++;
				if(nextMsgId == 0) nextMsgId = 1;

				MQTTBuffer[length++] = HIBYTE(nextMsgId);
				MQTTBuffer[length++] = LOBYTE(nextMsgId);
#if defined(__18CXX)
				if(MQTTClient.ROMPointers.Topic)
					length = MQTTWriteString(MQTTClient.Topic.szROM, MQTTBuffer,length);
				else
#endif
					length = MQTTWriteString(MQTTClient.Topic.szRAM, MQTTBuffer,length);
				MQTTBuffer[length++] = MQTTClient.QOS;

				if(MQTTWrite(MQTTSUBSCRIBE | (MQTTClient.QOS ? (MQTTClient.QOS==2 ? MQTTQOS2 : MQTTQOS1) : MQTTQOS0),MQTTBuffer,length-5)) {		// si potrebbe spezzare in 2 per non rifare tutto il "prepare" qua sopra...
					if (!MQTTClient.QOS) {  //QoS disabled, so execute callback here
                        if (subscribe_Callback) { subscribe_Callback(); }
                    }
                    MQTTState=MQTT_IDLE;   //was MQTT_SUBSCRIBE_ACK
                    //MQTTPrepareBuffer();
                }
				MQTTResponseCode=MQTT_SUCCESS;
            }
			else {
				MQTTResponseCode=MQTT_OPERATION_FAILED;
            }
			break;

		case MQTT_PUBACK:	
			if(MQTTConnected()) {
				// Leave room in the buffer for header and variable length field
				WORD length = 5;
				MQTTBuffer[length++] = HIBYTE(MQTTClient.MsgId);
				MQTTBuffer[length++] = LOBYTE(MQTTClient.MsgId);
				if(MQTTWrite(MQTTPUBACK,MQTTBuffer,length-5)) {
                    //MQTTPrepareBuffer();
					MQTTState=MQTT_IDLE;
                }
            }
			break;

		case MQTT_UNSUBSCRIBE:	 
			if(MQTTConnected()) {
				WORD length = 5;
				nextMsgId++;
				if(nextMsgId == 0) {
					 nextMsgId = 1;
                }
				MQTTBuffer[length++] = HIBYTE(nextMsgId);
				MQTTBuffer[length++] = LOBYTE(nextMsgId);
#if defined(__18CXX)
				if(MQTTClient.ROMPointers.Topic)
					length = MQTTWriteString(MQTTClient.Topic.szROM, MQTTBuffer,length);
				else
#endif
					length = MQTTWriteString(MQTTClient.Topic.szRAM, MQTTBuffer,length);
				if(MQTTWrite(MQTTUNSUBSCRIBE | MQTTQOS1,MQTTBuffer,length-5)) {
					MQTTState = MQTT_IDLE;   //was MQTT_UNSUBSCRIBE_ACK
                    //MQTTPrepareBuffer();
                }
				MQTTResponseCode=MQTT_SUCCESS;
            }
			else {
				MQTTResponseCode=MQTT_OPERATION_FAILED;
            }
			break;

		case MQTT_DISCONNECT_INIT:
			MQTTState = MQTT_DISCONNECT;
			break;

		case MQTT_DISCONNECT:	 
			MQTTBuffer[0] = MQTTDISCONNECT;
			MQTTBuffer[1] = 0;
			if(TCPIsPutReady(MySocket) >= 2) {
				MQTTPutArray(MQTTBuffer,2);
				lastOutActivity = TickGet();
				MQTTState=MQTT_CLOSE;
            }
			break;

		case MQTT_CLOSE:
			// Close the socket so it can be used by other modules
			TCPDisconnect(MySocket);
			MySocket = INVALID_SOCKET;
			MQTTFlags.bits.ConnectedOnce = FALSE;

			// Go back to doing nothing
			MQTTState = MQTT_QUIT;
			break;

		case MQTT_QUIT:	
			if(MySocket != INVALID_SOCKET) {
				TCPClose(MySocket);
            }
			MQTTState = MQTT_RECONNECT;  //MQTT_HOME
            MQTTFlags.bits.MQTTInUse = FALSE;
            MQTTClient.bConnected = FALSE;
			break;
        
        case MQTT_RECONNECT:
            MQTTState = MQTT_RECONNECT_WAIT;
            Timer = TickGet();
            break;
            
        case MQTT_RECONNECT_WAIT:
            if((DWORD)(TickGet()-Timer) > (5*TICK_SECOND)) {
                MQTTState = MQTT_BEGIN;
                printf("MQTT Reconnecting\r\n");
            }
            break;
            
		case MQTT_IDLE:	
            if(TCPWasReset(MySocket)) {
                printf("MQTT TCP disconnected, reseting\r\n");
                MQTTState = MQTT_CLOSE;
                break;
            }
            
			if(MQTTConnected()) {
                if (MQTTFlags.bits.PingOutstanding) {
                    if ( (DWORD)(TickGet()-PingTimer) > (5*TICK_SECOND) ) {
                        MQTTState = MQTT_CLOSE;
                        MQTTFlags.bits.PingOutstanding = FALSE;
                        printf("No ping response in 5 seconds. Closing connection.\r\n");
                        PingTimer = TickGet();
                        break;
                    }
                }
                else {
                    if( (DWORD)(TickGet()-PingTimer) > (60*TICK_SECOND) ) {
                        printf("Sending PING!\r\n");
                        MQTTState=MQTT_PING;
                        MQTTFlags.bits.PingOutstanding = TRUE;
                        PingTimer = TickGet();
                        break;
                    }
                }
                
                if ( MQTTFlags.bits.WaitingAck && ((DWORD)(TickGet()-AckTimer) > (5*TICK_SECOND)) ) {
                    MQTTFlags.bits.WaitingAck = FALSE;
                    MQTTState = MQTT_CLOSE;
                    break;
                }
                
                if( !MQTTFlags.bits.PingOutstanding && !MQTTFlags.bits.WaitingAck ) { //TODO
                    if (MQTTTxRingBufferHead != MQTTTxRingBufferTail) {
                        MQTTTxRingBufferTail = (MQTTTxRingBufferTail + 1) & MQTT_TX_RING_BUFFER_MASK;
                        MQTTMessage_t data = MQTTTxRingBuffer[MQTTTxRingBufferTail];
                        if (data.type == MQTT_MESSAGE_PUBLISH) {
                            MQTTClient.Topic.szRAM = (char*)data.topic;
                            MQTTClient.Payload.szRAM = (char*)data.payload;
                            MQTTClient.Plength = data.payloadlen;
                            MQTTClient.Retained = 0;
                            if (data.on_action) {
                                publish_Callback = data.on_action;
                            }
                            if (MQTTClient.QOS) {
                                MQTTFlags.bits.WaitingAck = TRUE;
                                AckTimer = TickGet();
                            }
                            MQTTState = MQTT_PUBLISH;
                            //printf("Publishing\r\n");
                            break;   //To send right away
                        }
                        else if (data.type == MQTT_MESSAGE_SUBSCRIBE) {
                            MQTTClient.Topic.szRAM = (char*)data.topic;
                            //printf("Subscribing\r\n");
                            if (data.on_action) {
                                subscribe_Callback = data.on_action;
                            }
                            MQTTState = MQTT_SUBSCRIBE;
                            break;
                        }
                        else if (data.type == MQTT_MESSAGE_UNSUBSCRIBE) {
                            MQTTClient.Topic.szRAM = (char*)data.topic;
                            if (data.on_action) {
                                unsubscribe_Callback = data.on_action;
                            }
                            MQTTState = MQTT_UNSUBSCRIBE;
                            break;
                        }
                    }
                }
                
                WORD len = 0;
                BYTE ll = 0;
                if(!MQTTReadPacket(&len, &ll)) {
                    break;
                }
                lastInActivity = TickGet();
                BYTE type = MQTTBuffer[0] & 0xF0;
                switch(type) {
                    case MQTTPUBLISH: ;
                        //printf("Received message is MQTTPUBLISH\r\n");
                        #define TOPIC_LEN_INDEX ll+1
                        WORD topicLen = MAKEWORD(MQTTBuffer[TOPIC_LEN_INDEX+1], MQTTBuffer[TOPIC_LEN_INDEX]);
                        BYTE *topic = MQTTBuffer+TOPIC_LEN_INDEX+2;
                        BYTE *payload = topic+topicLen;
                        WORD payloadLen = len-TOPIC_LEN_INDEX-4-topicLen;
                        WORD msgId = 0;
                        if ( (MQTTBuffer[0] & 0x06) == MQTTQOS1) {
                            msgId = MAKEWORD(*(payload+1), *payload);
                            payload += 2;
                            //printf("Received MsgId=%d\r\n", msgId);
                            MQTTPubACK(msgId);
                        }
                        payloadLen = (MQTTBuffer+len)-payload;
                        if(receive_Callback) {
                            receive_Callback(topic, topicLen, payload, payloadLen);
                        }
                        break;
                    case MQTTPINGREQ:
                        //printf("Received message is MQTTPINGREQ\r\n");
                        MQTTState=MQTT_PING_ACK;
                        break;
                    case MQTTPINGRESP:
                        printf("Received message is MQTTPINGRESP\r\n");
                        MQTTFlags.bits.PingOutstanding = FALSE;
                        PingTimer = TickGet();
                        break;
                    case MQTTPUBACK:
                        //printf("Received message is MQTTPUBACK\r\n");
                        MQTTFlags.bits.WaitingAck = FALSE;
                        if (MQTTClient.QOS) {   //QoS active, so we execute callback after receiving ACK
                            if(publish_Callback) { publish_Callback(); }
                        }
                        break;
                    case MQTTSUBACK:
                        printf("Received message is MQTTSUBACK\r\n");
                        MQTTFlags.bits.WaitingAck = FALSE;
                        if (MQTTClient.QOS) {
                            if (subscribe_Callback) { subscribe_Callback(); }   //QoS active, so we execute callback after receiving ACK
                        }
                        break;
                    case MQTTUNSUBACK:
                        printf("Received message is MQTTUNSUBACK\r\n");
                        MQTTFlags.bits.WaitingAck = FALSE;
                        if (unsubscribe_Callback) { unsubscribe_Callback(); }
                        break;
                    default:
                        //printf("Received message is different: %d\r\n", MQTTBuffer[0]);
                        break;
                }
                MQTTPrepareBuffer();
            }
			break;
	
		}
	}

/*****************************************************************************
  Function:
	WORD MQTTPutArray(BYTE* Data, WORD Len)

  Description:
	Writes a series of bytes to the MQTT client.

  Precondition:
	MQTTBeginUsage returned TRUE on a previous call.

  Parameters:
	Data - The data to be written
	Len - How many bytes should be written

  Returns:
	The number of bytes written.  If less than Len, then the TX FIFO became
	full before all bytes could be written.
	
  Remarks:
	This function should only be called externally when the MQTT client is
	generating an on-the-fly message.  (That is, MQTTSendMail was called
	with MQTTClient.Body set to NULL.)
	
  Internal:
  ***************************************************************************/
WORD MQTTPutArray(BYTE* Data, WORD Len) {
	WORD result = 0;

    result = TCPPutArray(MySocket, Data, Len);
    TCPFlush(MySocket);

	return result;
}

/*****************************************************************************
  Function:
	WORD MQTTPutROMArray(ROM BYTE* Data, WORD Len)

  Description:
	Writes a series of bytes from ROM to the MQTT client.

  Precondition:
	MQTTBeginUsage returned TRUE on a previous call.

  Parameters:
	Data - The data to be written
	Len - How many bytes should be written

  Returns:
	The number of bytes written.  If less than Len, then the TX FIFO became
	full before all bytes could be written.
	
  Remarks:
	This function should only be called externally when the MQTT client is
	generating an on-the-fly message.  (That is, MQTTSendMail was called
	with MQTTClient.Body set to NULL.)
	
  	This function is aliased to MQTTPutArray on non-PIC18 platforms.
	
  Internal:
	MQTTPut must be used instead of TCPPutArray because "\r\n." must be
	transparently replaced by "\r\n..".
  ***************************************************************************/
#if defined(__18CXX)
WORD MQTTPutROMArray(ROM BYTE* Data, WORD Len) {
	WORD result = 0;

	while(Len--) {
		if(TCPPut(*Data++)) {
			result++;
			}
		else {
			Data--;
			break;
			}
		}

	return result;
	}
#endif


static BOOL MQTTWrite(BYTE header, BYTE *buf, WORD length) {
	BYTE lenBuf[4];
	BYTE llen = 0;
	BYTE digit;
	BYTE pos = 0;
	BYTE rc;
	BYTE len = length;
	int i;

    do {
        digit = len % 128;
        len = len / 128;
        if(len > 0) {
            digit |= 0x80;
        }
        lenBuf[pos++] = digit;
        llen++;
    } while(len>0);

	buf[4-llen] = header;
	for(i=0;i<llen;i++) {
        buf[5-llen+i] = lenBuf[i];
    }
    WORD txlen = length+1+llen;
	if(TCPIsPutReady(MySocket) >= txlen) {   //length+1+llen
        rc = MQTTPutArray(buf+(4-llen),txlen);
        lastOutActivity = TickGet();
        return (rc==txlen);
    }
	else {
		return 0;
    }
}

static WORD MQTTWriteString(const char *string, BYTE *buf, WORD pos) {
    const char *idp = string;
    WORD i=0;

    pos += 2;
    while (*idp) {
        buf[pos++] = *idp++;
        i++;
    }
    buf[pos-i-2] = HIBYTE(i);
    buf[pos-i-1] = LOBYTE(i);
    return pos;
}

#if defined(__18CXX)
static WORD MQTTWriteROMString(const ROMchar *string, BYTE *buf, WORD pos) {
  const char *idp = string;
  WORD i=0;

  pos += 2;
  while (*idp) {
    buf[pos++] = *idp++;
    i++;
		}
	buf[pos-i-2] = HIBYTE(i);
	buf[pos-i-1] = LOBYTE(i);
	return pos;
	}
#endif

BOOL MQTTConnected(void) {
    BOOL rc;

    rc = MQTTClient.bConnected;
    return rc;
}

static inline BOOL MQTTReadByte(BYTE *ch) {		// ottimizzare, evitare..?
	if (TCPGet(MySocket, ch)) return TRUE;
	return FALSE;
}

static void MQTTPrepareBuffer(void) {
    MQTTBufferIdx = 0;
    RPSMState=RPSM_INIT;
}

static BOOL MQTTReadPacket(WORD *retlen, BYTE* retll) {
	BYTE digit = 0;
	static WORD i;
    static BYTE lengthLength;
    static DWORD Multiplier = 1;
    static WORD Length = 0;
    
	switch(RPSMState) {
		case RPSM_INIT:
            if (MQTTReadByte(&digit)) {
                MQTTBuffer[MQTTBufferIdx++] = digit;
                Multiplier = 1;
                Length = 0;
                RPSMState=RPSM_READ_LEN;
            }
			break;
            
		case RPSM_READ_LEN:  
            if (MQTTReadByte(&digit)) {
                MQTTBuffer[MQTTBufferIdx++] = digit;
                Length += (digit & 0x7F) * Multiplier;
                Multiplier *= 0x80;
                
                if (digit & 0x80) {
                    break;
                }
                
                lengthLength = MQTTBufferIdx-1;
                RPSMState=RPSM_READ_DATA;
                i = 0;
            }           
            break;

		case RPSM_READ_DATA:
            while(i < Length) {
                if (MQTTReadByte(&digit)) {
                    if(MQTTBufferIdx < MQTT_MAX_PACKET_SIZE) {
                        MQTTBuffer[MQTTBufferIdx]=digit;
                        MQTTBufferIdx++;
                    }
                    i++;
                }
                else {
                    break;
                }
            }
            if (i >= Length) {
                RPSMState=RPSM_FINALIZE;
            }
			break;

		case RPSM_FINALIZE:
			RPSMState=RPSM_INIT;
			MQTTFlags.bits.ReceivedSuccessfully=MQTTBufferIdx>0;		// boh tanto per...

            if (retlen) {
                *retlen = MQTTBufferIdx;
            }
            if (retll) {
                *retll = lengthLength;
            }
			return TRUE;
			break;
    }
    
	return FALSE;
}


/*****************************************************************************
  Function:
	void MQTTPing(void)

  Summary:
	Sends a PING message

  Description:
	This function starts the state machine that performs the actual
	transmission of the message.  Call this function after all the fields
	in MQTTClient have been set.

  Precondition:
	MQTTBeginUsage returned TRUE on a previous call.

  Parameters:
	None

  Returns:
	None
  ***************************************************************************/
static BOOL MQTTPing(void) {

	if(MQTTState==MQTT_IDLE) {
		if(MQTTClient.bConnected) {
			MQTTState=MQTT_PING;
			return 1;
        }
    }
	return 0;
}


/*****************************************************************************
  Function:
	void MQTTPubACK(WORD id)

  Summary:
	Replies to Publish if needed

  Description:
	This function starts the state machine that performs the actual
	transmission of the message.  Call this function after all the fields
	in MQTTClient have been set.

  Precondition:
	MQTTBeginUsage returned TRUE on a previous call.

  Parameters:
	None

  Returns:
	None
  ***************************************************************************/
static BOOL MQTTPubACK(WORD id) {

	if(MQTTState==MQTT_IDLE) {
		if(MQTTClient.bConnected) {
			MQTTClient.MsgId=id;			// uso questo, anche per loop()... (v.)
			MQTTState=MQTT_PUBACK;
			return 1;
        }
    }
	return 0;
}

/*****************************************************************************
  Function:
	void MQTTDisconnect()

  Summary:
	Disconnects gracefully (already done in Close anyway)

  Description:

  Precondition:
	MQTTBeginUsage returned TRUE on a previous call.

  Parameters:
	None

  Returns:
	None
  ***************************************************************************/
BOOL MQTTDisconnect(void) {

	if(MQTTState==MQTT_IDLE) {
        //printf("MQTTDisconnect: MQTT is IDLE\r\n");
		if(MQTTClient.bConnected) {
			MQTTState=MQTT_DISCONNECT;
            //printf("MQTTDisconnect: state changed to MQTT_DISCONNECT\r\n");
			return 1;
        }
    }
	return 0;
}

#endif //#if defined(STACK_USE_MQTT_CLIENT)

