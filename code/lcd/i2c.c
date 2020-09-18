#include "i2c.h"


void i2c_init (void) {
    TRISBbits.TRISB8 = 0; //SCL
    TRISBbits.TRISB9 = 0; //SDA
    OpenI2C1( I2C_EN, BRG_VAL );
}

uint8_t i2c_rcv_byte (uint8_t address) {
    int rcv = 0;
    
	StartI2C1();				//Send line start condition
	IdleI2C1();			        //Wait to complete
	MasterWriteI2C1((address << 1) | 1);	//Write out slave address OR 1 (read command)
	IdleI2C1();				//Wait to complete
	rcv = MasterReadI2C1();		//Read in a value
	StopI2C1();				//Send line stop condition
	IdleI2C1();				//Wait co complete
	return rcv;				//Return read value
}

void i2c_send_byte (uint8_t data, uint8_t address) {
	StartI2C1();	        //Send the Start Bit
	IdleI2C1();		//Wait to complete

	MasterWriteI2C1((address << 1) | 0);  //Sends the slave address over the I2C line.  This must happen first so the 
                                             //proper slave is selected to receive data.
	IdleI2C1();	        //Wait to complete

	MasterWriteI2C1(data);  //Sends data byte over I2C line
	IdleI2C1();		//Wait to complete

	StopI2C1();	        //Send the Stop condition
	IdleI2C1();	        //Wait to complete

}