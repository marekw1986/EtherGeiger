#
# Generated Makefile - do not edit!
#
# Edit the Makefile in the project folder instead (../Makefile). Each target
# has a -pre and a -post target defined where you can add customized code.
#
# This makefile implements configuration specific macros and targets.


# Include project Makefile
ifeq "${IGNORE_LOCAL}" "TRUE"
# do not include local makefile. User is passing all local related variables already
else
include Makefile
# Include makefile containing local settings
ifeq "$(wildcard nbproject/Makefile-local-default.mk)" "nbproject/Makefile-local-default.mk"
include nbproject/Makefile-local-default.mk
endif
endif

# Environment
MKDIR=mkdir -p
RM=rm -f 
MV=mv 
CP=cp 

# Macros
CND_CONF=default
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
IMAGE_TYPE=debug
OUTPUT_SUFFIX=elf
DEBUGGABLE_SUFFIX=elf
FINAL_IMAGE=${DISTDIR}/code.${IMAGE_TYPE}.${OUTPUT_SUFFIX}
else
IMAGE_TYPE=production
OUTPUT_SUFFIX=hex
DEBUGGABLE_SUFFIX=elf
FINAL_IMAGE=${DISTDIR}/code.${IMAGE_TYPE}.${OUTPUT_SUFFIX}
endif

ifeq ($(COMPARE_BUILD), true)
COMPARISON_BUILD=-mafrlcsj
else
COMPARISON_BUILD=
endif

# Object Directory
OBJECTDIR=build/${CND_CONF}/${IMAGE_TYPE}

# Distribution Directory
DISTDIR=dist/${CND_CONF}/${IMAGE_TYPE}

# Source Files Quoted if spaced
SOURCEFILES_QUOTED_IF_SPACED=bme280/bme280.c btn/buttons_i2c.c config/config.c delay/delay.c fatfs/ff.c fatfs/ffsystem.c fatfs/ffunicode.c fatfs/SPIFlash.c fatfs/diskio.c geiger/geiger.c lcd/i2c.c lcd/hd44780.c lcd/display.c MPFSImg2.c net/NBNS.c net/MPFS2.c net/IP.c net/ICMP.c net/HTTP2.c net/Helpers.c net/Hashes.c net/GenericTCPServer.c net/FTP.c net/ENC28J60.c net/DNS.c net/DHCP.c CustomHTTPApp.c net/BerkeleyAPI.c net/BigInt.c net/AutoIP.c net/ARP.c net/ARCFOUR.c net/Announce.c net/Random.c net/Reboot.c net/RSA.c net/SNTP.c net/SMTP.c net/SSL.c net/StackTsk.c net/TCP.c net/Telnet.c net/Tick.c net/UDP.c net/ZeroconfHelper.c net/ZeroconfLinkLocal.c net/ZeroconfMulticastDNS.c net/MQTT.c nvram/nvram.c time/time.c uart/uart.c usb_host_msd/usb_config.c usb_host_msd/usb_host.c usb_host_msd/usb_host_msd.c usb_host_msd/usb_host_msd_scsi.c usb_host_msd/event.c main.c common.c

# Object Files Quoted if spaced
OBJECTFILES_QUOTED_IF_SPACED=${OBJECTDIR}/bme280/bme280.o ${OBJECTDIR}/btn/buttons_i2c.o ${OBJECTDIR}/config/config.o ${OBJECTDIR}/delay/delay.o ${OBJECTDIR}/fatfs/ff.o ${OBJECTDIR}/fatfs/ffsystem.o ${OBJECTDIR}/fatfs/ffunicode.o ${OBJECTDIR}/fatfs/SPIFlash.o ${OBJECTDIR}/fatfs/diskio.o ${OBJECTDIR}/geiger/geiger.o ${OBJECTDIR}/lcd/i2c.o ${OBJECTDIR}/lcd/hd44780.o ${OBJECTDIR}/lcd/display.o ${OBJECTDIR}/MPFSImg2.o ${OBJECTDIR}/net/NBNS.o ${OBJECTDIR}/net/MPFS2.o ${OBJECTDIR}/net/IP.o ${OBJECTDIR}/net/ICMP.o ${OBJECTDIR}/net/HTTP2.o ${OBJECTDIR}/net/Helpers.o ${OBJECTDIR}/net/Hashes.o ${OBJECTDIR}/net/GenericTCPServer.o ${OBJECTDIR}/net/FTP.o ${OBJECTDIR}/net/ENC28J60.o ${OBJECTDIR}/net/DNS.o ${OBJECTDIR}/net/DHCP.o ${OBJECTDIR}/CustomHTTPApp.o ${OBJECTDIR}/net/BerkeleyAPI.o ${OBJECTDIR}/net/BigInt.o ${OBJECTDIR}/net/AutoIP.o ${OBJECTDIR}/net/ARP.o ${OBJECTDIR}/net/ARCFOUR.o ${OBJECTDIR}/net/Announce.o ${OBJECTDIR}/net/Random.o ${OBJECTDIR}/net/Reboot.o ${OBJECTDIR}/net/RSA.o ${OBJECTDIR}/net/SNTP.o ${OBJECTDIR}/net/SMTP.o ${OBJECTDIR}/net/SSL.o ${OBJECTDIR}/net/StackTsk.o ${OBJECTDIR}/net/TCP.o ${OBJECTDIR}/net/Telnet.o ${OBJECTDIR}/net/Tick.o ${OBJECTDIR}/net/UDP.o ${OBJECTDIR}/net/ZeroconfHelper.o ${OBJECTDIR}/net/ZeroconfLinkLocal.o ${OBJECTDIR}/net/ZeroconfMulticastDNS.o ${OBJECTDIR}/net/MQTT.o ${OBJECTDIR}/nvram/nvram.o ${OBJECTDIR}/time/time.o ${OBJECTDIR}/uart/uart.o ${OBJECTDIR}/usb_host_msd/usb_config.o ${OBJECTDIR}/usb_host_msd/usb_host.o ${OBJECTDIR}/usb_host_msd/usb_host_msd.o ${OBJECTDIR}/usb_host_msd/usb_host_msd_scsi.o ${OBJECTDIR}/usb_host_msd/event.o ${OBJECTDIR}/main.o ${OBJECTDIR}/common.o
POSSIBLE_DEPFILES=${OBJECTDIR}/bme280/bme280.o.d ${OBJECTDIR}/btn/buttons_i2c.o.d ${OBJECTDIR}/config/config.o.d ${OBJECTDIR}/delay/delay.o.d ${OBJECTDIR}/fatfs/ff.o.d ${OBJECTDIR}/fatfs/ffsystem.o.d ${OBJECTDIR}/fatfs/ffunicode.o.d ${OBJECTDIR}/fatfs/SPIFlash.o.d ${OBJECTDIR}/fatfs/diskio.o.d ${OBJECTDIR}/geiger/geiger.o.d ${OBJECTDIR}/lcd/i2c.o.d ${OBJECTDIR}/lcd/hd44780.o.d ${OBJECTDIR}/lcd/display.o.d ${OBJECTDIR}/MPFSImg2.o.d ${OBJECTDIR}/net/NBNS.o.d ${OBJECTDIR}/net/MPFS2.o.d ${OBJECTDIR}/net/IP.o.d ${OBJECTDIR}/net/ICMP.o.d ${OBJECTDIR}/net/HTTP2.o.d ${OBJECTDIR}/net/Helpers.o.d ${OBJECTDIR}/net/Hashes.o.d ${OBJECTDIR}/net/GenericTCPServer.o.d ${OBJECTDIR}/net/FTP.o.d ${OBJECTDIR}/net/ENC28J60.o.d ${OBJECTDIR}/net/DNS.o.d ${OBJECTDIR}/net/DHCP.o.d ${OBJECTDIR}/CustomHTTPApp.o.d ${OBJECTDIR}/net/BerkeleyAPI.o.d ${OBJECTDIR}/net/BigInt.o.d ${OBJECTDIR}/net/AutoIP.o.d ${OBJECTDIR}/net/ARP.o.d ${OBJECTDIR}/net/ARCFOUR.o.d ${OBJECTDIR}/net/Announce.o.d ${OBJECTDIR}/net/Random.o.d ${OBJECTDIR}/net/Reboot.o.d ${OBJECTDIR}/net/RSA.o.d ${OBJECTDIR}/net/SNTP.o.d ${OBJECTDIR}/net/SMTP.o.d ${OBJECTDIR}/net/SSL.o.d ${OBJECTDIR}/net/StackTsk.o.d ${OBJECTDIR}/net/TCP.o.d ${OBJECTDIR}/net/Telnet.o.d ${OBJECTDIR}/net/Tick.o.d ${OBJECTDIR}/net/UDP.o.d ${OBJECTDIR}/net/ZeroconfHelper.o.d ${OBJECTDIR}/net/ZeroconfLinkLocal.o.d ${OBJECTDIR}/net/ZeroconfMulticastDNS.o.d ${OBJECTDIR}/net/MQTT.o.d ${OBJECTDIR}/nvram/nvram.o.d ${OBJECTDIR}/time/time.o.d ${OBJECTDIR}/uart/uart.o.d ${OBJECTDIR}/usb_host_msd/usb_config.o.d ${OBJECTDIR}/usb_host_msd/usb_host.o.d ${OBJECTDIR}/usb_host_msd/usb_host_msd.o.d ${OBJECTDIR}/usb_host_msd/usb_host_msd_scsi.o.d ${OBJECTDIR}/usb_host_msd/event.o.d ${OBJECTDIR}/main.o.d ${OBJECTDIR}/common.o.d

# Object Files
OBJECTFILES=${OBJECTDIR}/bme280/bme280.o ${OBJECTDIR}/btn/buttons_i2c.o ${OBJECTDIR}/config/config.o ${OBJECTDIR}/delay/delay.o ${OBJECTDIR}/fatfs/ff.o ${OBJECTDIR}/fatfs/ffsystem.o ${OBJECTDIR}/fatfs/ffunicode.o ${OBJECTDIR}/fatfs/SPIFlash.o ${OBJECTDIR}/fatfs/diskio.o ${OBJECTDIR}/geiger/geiger.o ${OBJECTDIR}/lcd/i2c.o ${OBJECTDIR}/lcd/hd44780.o ${OBJECTDIR}/lcd/display.o ${OBJECTDIR}/MPFSImg2.o ${OBJECTDIR}/net/NBNS.o ${OBJECTDIR}/net/MPFS2.o ${OBJECTDIR}/net/IP.o ${OBJECTDIR}/net/ICMP.o ${OBJECTDIR}/net/HTTP2.o ${OBJECTDIR}/net/Helpers.o ${OBJECTDIR}/net/Hashes.o ${OBJECTDIR}/net/GenericTCPServer.o ${OBJECTDIR}/net/FTP.o ${OBJECTDIR}/net/ENC28J60.o ${OBJECTDIR}/net/DNS.o ${OBJECTDIR}/net/DHCP.o ${OBJECTDIR}/CustomHTTPApp.o ${OBJECTDIR}/net/BerkeleyAPI.o ${OBJECTDIR}/net/BigInt.o ${OBJECTDIR}/net/AutoIP.o ${OBJECTDIR}/net/ARP.o ${OBJECTDIR}/net/ARCFOUR.o ${OBJECTDIR}/net/Announce.o ${OBJECTDIR}/net/Random.o ${OBJECTDIR}/net/Reboot.o ${OBJECTDIR}/net/RSA.o ${OBJECTDIR}/net/SNTP.o ${OBJECTDIR}/net/SMTP.o ${OBJECTDIR}/net/SSL.o ${OBJECTDIR}/net/StackTsk.o ${OBJECTDIR}/net/TCP.o ${OBJECTDIR}/net/Telnet.o ${OBJECTDIR}/net/Tick.o ${OBJECTDIR}/net/UDP.o ${OBJECTDIR}/net/ZeroconfHelper.o ${OBJECTDIR}/net/ZeroconfLinkLocal.o ${OBJECTDIR}/net/ZeroconfMulticastDNS.o ${OBJECTDIR}/net/MQTT.o ${OBJECTDIR}/nvram/nvram.o ${OBJECTDIR}/time/time.o ${OBJECTDIR}/uart/uart.o ${OBJECTDIR}/usb_host_msd/usb_config.o ${OBJECTDIR}/usb_host_msd/usb_host.o ${OBJECTDIR}/usb_host_msd/usb_host_msd.o ${OBJECTDIR}/usb_host_msd/usb_host_msd_scsi.o ${OBJECTDIR}/usb_host_msd/event.o ${OBJECTDIR}/main.o ${OBJECTDIR}/common.o

# Source Files
SOURCEFILES=bme280/bme280.c btn/buttons_i2c.c config/config.c delay/delay.c fatfs/ff.c fatfs/ffsystem.c fatfs/ffunicode.c fatfs/SPIFlash.c fatfs/diskio.c geiger/geiger.c lcd/i2c.c lcd/hd44780.c lcd/display.c MPFSImg2.c net/NBNS.c net/MPFS2.c net/IP.c net/ICMP.c net/HTTP2.c net/Helpers.c net/Hashes.c net/GenericTCPServer.c net/FTP.c net/ENC28J60.c net/DNS.c net/DHCP.c CustomHTTPApp.c net/BerkeleyAPI.c net/BigInt.c net/AutoIP.c net/ARP.c net/ARCFOUR.c net/Announce.c net/Random.c net/Reboot.c net/RSA.c net/SNTP.c net/SMTP.c net/SSL.c net/StackTsk.c net/TCP.c net/Telnet.c net/Tick.c net/UDP.c net/ZeroconfHelper.c net/ZeroconfLinkLocal.c net/ZeroconfMulticastDNS.c net/MQTT.c nvram/nvram.c time/time.c uart/uart.c usb_host_msd/usb_config.c usb_host_msd/usb_host.c usb_host_msd/usb_host_msd.c usb_host_msd/usb_host_msd_scsi.c usb_host_msd/event.c main.c common.c



CFLAGS=
ASFLAGS=
LDLIBSOPTIONS=

############# Tool locations ##########################################
# If you copy a project from one host to another, the path where the  #
# compiler is installed may be different.                             #
# If you open this project with MPLAB X in the new host, this         #
# makefile will be regenerated and the paths will be corrected.       #
#######################################################################
# fixDeps replaces a bunch of sed/cat/printf statements that slow down the build
FIXDEPS=fixDeps

.build-conf:  ${BUILD_SUBPROJECTS}
ifneq ($(INFORMATION_MESSAGE), )
	@echo $(INFORMATION_MESSAGE)
endif
	${MAKE}  -f nbproject/Makefile-default.mk ${DISTDIR}/code.${IMAGE_TYPE}.${OUTPUT_SUFFIX}

MP_PROCESSOR_OPTION=32MX270F256B
MP_LINKER_FILE_OPTION=
# ------------------------------------------------------------------------------------
# Rules for buildStep: assemble
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
else
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: assembleWithPreprocess
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
else
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: compile
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
${OBJECTDIR}/bme280/bme280.o: bme280/bme280.c  .generated_files/flags/default/7414366ec610ea5f9a8371e3c57c507dbb45c2e5 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/bme280" 
	@${RM} ${OBJECTDIR}/bme280/bme280.o.d 
	@${RM} ${OBJECTDIR}/bme280/bme280.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O1 -D_SUPPRESS_PLIB_WARNING -DSYSCLK=40000000L -D_DISABLE_OPENADC10_CONFIGPORT_WARNING -MP -MMD -MF "${OBJECTDIR}/bme280/bme280.o.d" -o ${OBJECTDIR}/bme280/bme280.o bme280/bme280.c    -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/btn/buttons_i2c.o: btn/buttons_i2c.c  .generated_files/flags/default/543da62dc3e21cb86d499dd68f16487808e1a37d .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/btn" 
	@${RM} ${OBJECTDIR}/btn/buttons_i2c.o.d 
	@${RM} ${OBJECTDIR}/btn/buttons_i2c.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O1 -D_SUPPRESS_PLIB_WARNING -DSYSCLK=40000000L -D_DISABLE_OPENADC10_CONFIGPORT_WARNING -MP -MMD -MF "${OBJECTDIR}/btn/buttons_i2c.o.d" -o ${OBJECTDIR}/btn/buttons_i2c.o btn/buttons_i2c.c    -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/config/config.o: config/config.c  .generated_files/flags/default/9927dd9f7c73d4e9fb7bd3d95b4f1985499100a5 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/config" 
	@${RM} ${OBJECTDIR}/config/config.o.d 
	@${RM} ${OBJECTDIR}/config/config.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O1 -D_SUPPRESS_PLIB_WARNING -DSYSCLK=40000000L -D_DISABLE_OPENADC10_CONFIGPORT_WARNING -MP -MMD -MF "${OBJECTDIR}/config/config.o.d" -o ${OBJECTDIR}/config/config.o config/config.c    -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/delay/delay.o: delay/delay.c  .generated_files/flags/default/d14d8f4022be528c2d8838120f27616f8913e004 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/delay" 
	@${RM} ${OBJECTDIR}/delay/delay.o.d 
	@${RM} ${OBJECTDIR}/delay/delay.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O1 -D_SUPPRESS_PLIB_WARNING -DSYSCLK=40000000L -D_DISABLE_OPENADC10_CONFIGPORT_WARNING -MP -MMD -MF "${OBJECTDIR}/delay/delay.o.d" -o ${OBJECTDIR}/delay/delay.o delay/delay.c    -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/fatfs/ff.o: fatfs/ff.c  .generated_files/flags/default/c640bbd51c4329156f6f8a2c956ed01e9dee4216 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/fatfs" 
	@${RM} ${OBJECTDIR}/fatfs/ff.o.d 
	@${RM} ${OBJECTDIR}/fatfs/ff.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O1 -D_SUPPRESS_PLIB_WARNING -DSYSCLK=40000000L -D_DISABLE_OPENADC10_CONFIGPORT_WARNING -MP -MMD -MF "${OBJECTDIR}/fatfs/ff.o.d" -o ${OBJECTDIR}/fatfs/ff.o fatfs/ff.c    -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/fatfs/ffsystem.o: fatfs/ffsystem.c  .generated_files/flags/default/3710d06c0e7a960e9383c9015bec8d1ebdcbe842 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/fatfs" 
	@${RM} ${OBJECTDIR}/fatfs/ffsystem.o.d 
	@${RM} ${OBJECTDIR}/fatfs/ffsystem.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O1 -D_SUPPRESS_PLIB_WARNING -DSYSCLK=40000000L -D_DISABLE_OPENADC10_CONFIGPORT_WARNING -MP -MMD -MF "${OBJECTDIR}/fatfs/ffsystem.o.d" -o ${OBJECTDIR}/fatfs/ffsystem.o fatfs/ffsystem.c    -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/fatfs/ffunicode.o: fatfs/ffunicode.c  .generated_files/flags/default/91645028c7ddb5459b8b14f7bf4a6ebc03384dbd .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/fatfs" 
	@${RM} ${OBJECTDIR}/fatfs/ffunicode.o.d 
	@${RM} ${OBJECTDIR}/fatfs/ffunicode.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O1 -D_SUPPRESS_PLIB_WARNING -DSYSCLK=40000000L -D_DISABLE_OPENADC10_CONFIGPORT_WARNING -MP -MMD -MF "${OBJECTDIR}/fatfs/ffunicode.o.d" -o ${OBJECTDIR}/fatfs/ffunicode.o fatfs/ffunicode.c    -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/fatfs/SPIFlash.o: fatfs/SPIFlash.c  .generated_files/flags/default/63a3a735b10802dcefaed38bf75a22c2d5fcecb3 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/fatfs" 
	@${RM} ${OBJECTDIR}/fatfs/SPIFlash.o.d 
	@${RM} ${OBJECTDIR}/fatfs/SPIFlash.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O1 -D_SUPPRESS_PLIB_WARNING -DSYSCLK=40000000L -D_DISABLE_OPENADC10_CONFIGPORT_WARNING -MP -MMD -MF "${OBJECTDIR}/fatfs/SPIFlash.o.d" -o ${OBJECTDIR}/fatfs/SPIFlash.o fatfs/SPIFlash.c    -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/fatfs/diskio.o: fatfs/diskio.c  .generated_files/flags/default/68bc3112ce77668ac1f1ce8a3211e8e19a1887a4 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/fatfs" 
	@${RM} ${OBJECTDIR}/fatfs/diskio.o.d 
	@${RM} ${OBJECTDIR}/fatfs/diskio.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O1 -D_SUPPRESS_PLIB_WARNING -DSYSCLK=40000000L -D_DISABLE_OPENADC10_CONFIGPORT_WARNING -MP -MMD -MF "${OBJECTDIR}/fatfs/diskio.o.d" -o ${OBJECTDIR}/fatfs/diskio.o fatfs/diskio.c    -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/geiger/geiger.o: geiger/geiger.c  .generated_files/flags/default/29c7eae51cb5bc65d088357c87b447641997501c .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/geiger" 
	@${RM} ${OBJECTDIR}/geiger/geiger.o.d 
	@${RM} ${OBJECTDIR}/geiger/geiger.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O1 -D_SUPPRESS_PLIB_WARNING -DSYSCLK=40000000L -D_DISABLE_OPENADC10_CONFIGPORT_WARNING -MP -MMD -MF "${OBJECTDIR}/geiger/geiger.o.d" -o ${OBJECTDIR}/geiger/geiger.o geiger/geiger.c    -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/lcd/i2c.o: lcd/i2c.c  .generated_files/flags/default/724de68b9bec7738c9ed134599a2fa48d47ff139 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/lcd" 
	@${RM} ${OBJECTDIR}/lcd/i2c.o.d 
	@${RM} ${OBJECTDIR}/lcd/i2c.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O1 -D_SUPPRESS_PLIB_WARNING -DSYSCLK=40000000L -D_DISABLE_OPENADC10_CONFIGPORT_WARNING -MP -MMD -MF "${OBJECTDIR}/lcd/i2c.o.d" -o ${OBJECTDIR}/lcd/i2c.o lcd/i2c.c    -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/lcd/hd44780.o: lcd/hd44780.c  .generated_files/flags/default/207693338bb799b42c87dd24b62f1c40ffffdacd .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/lcd" 
	@${RM} ${OBJECTDIR}/lcd/hd44780.o.d 
	@${RM} ${OBJECTDIR}/lcd/hd44780.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O1 -D_SUPPRESS_PLIB_WARNING -DSYSCLK=40000000L -D_DISABLE_OPENADC10_CONFIGPORT_WARNING -MP -MMD -MF "${OBJECTDIR}/lcd/hd44780.o.d" -o ${OBJECTDIR}/lcd/hd44780.o lcd/hd44780.c    -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/lcd/display.o: lcd/display.c  .generated_files/flags/default/77267532087092924ec50147f7dff1cf294056fc .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/lcd" 
	@${RM} ${OBJECTDIR}/lcd/display.o.d 
	@${RM} ${OBJECTDIR}/lcd/display.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O1 -D_SUPPRESS_PLIB_WARNING -DSYSCLK=40000000L -D_DISABLE_OPENADC10_CONFIGPORT_WARNING -MP -MMD -MF "${OBJECTDIR}/lcd/display.o.d" -o ${OBJECTDIR}/lcd/display.o lcd/display.c    -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/MPFSImg2.o: MPFSImg2.c  .generated_files/flags/default/eceb054a8239e84af6ab89da52f3052579095bc0 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/MPFSImg2.o.d 
	@${RM} ${OBJECTDIR}/MPFSImg2.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O1 -D_SUPPRESS_PLIB_WARNING -DSYSCLK=40000000L -D_DISABLE_OPENADC10_CONFIGPORT_WARNING -MP -MMD -MF "${OBJECTDIR}/MPFSImg2.o.d" -o ${OBJECTDIR}/MPFSImg2.o MPFSImg2.c    -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/net/NBNS.o: net/NBNS.c  .generated_files/flags/default/733518546bce9dd9f842806399da208ffa67b827 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/net" 
	@${RM} ${OBJECTDIR}/net/NBNS.o.d 
	@${RM} ${OBJECTDIR}/net/NBNS.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O1 -D_SUPPRESS_PLIB_WARNING -DSYSCLK=40000000L -D_DISABLE_OPENADC10_CONFIGPORT_WARNING -MP -MMD -MF "${OBJECTDIR}/net/NBNS.o.d" -o ${OBJECTDIR}/net/NBNS.o net/NBNS.c    -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/net/MPFS2.o: net/MPFS2.c  .generated_files/flags/default/1682513630c696c73ae53b89ca51cf36c29e8e9a .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/net" 
	@${RM} ${OBJECTDIR}/net/MPFS2.o.d 
	@${RM} ${OBJECTDIR}/net/MPFS2.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O1 -D_SUPPRESS_PLIB_WARNING -DSYSCLK=40000000L -D_DISABLE_OPENADC10_CONFIGPORT_WARNING -MP -MMD -MF "${OBJECTDIR}/net/MPFS2.o.d" -o ${OBJECTDIR}/net/MPFS2.o net/MPFS2.c    -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/net/IP.o: net/IP.c  .generated_files/flags/default/b30f871462ce1f75d79a6e1df83587d5e96cfde8 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/net" 
	@${RM} ${OBJECTDIR}/net/IP.o.d 
	@${RM} ${OBJECTDIR}/net/IP.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O1 -D_SUPPRESS_PLIB_WARNING -DSYSCLK=40000000L -D_DISABLE_OPENADC10_CONFIGPORT_WARNING -MP -MMD -MF "${OBJECTDIR}/net/IP.o.d" -o ${OBJECTDIR}/net/IP.o net/IP.c    -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/net/ICMP.o: net/ICMP.c  .generated_files/flags/default/f9e97a30991c270d964afeab758db4b30d0d3ee .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/net" 
	@${RM} ${OBJECTDIR}/net/ICMP.o.d 
	@${RM} ${OBJECTDIR}/net/ICMP.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O1 -D_SUPPRESS_PLIB_WARNING -DSYSCLK=40000000L -D_DISABLE_OPENADC10_CONFIGPORT_WARNING -MP -MMD -MF "${OBJECTDIR}/net/ICMP.o.d" -o ${OBJECTDIR}/net/ICMP.o net/ICMP.c    -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/net/HTTP2.o: net/HTTP2.c  .generated_files/flags/default/461fe6600fa05bf8c2deb1f91a93d8f2e747c0fe .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/net" 
	@${RM} ${OBJECTDIR}/net/HTTP2.o.d 
	@${RM} ${OBJECTDIR}/net/HTTP2.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O1 -D_SUPPRESS_PLIB_WARNING -DSYSCLK=40000000L -D_DISABLE_OPENADC10_CONFIGPORT_WARNING -MP -MMD -MF "${OBJECTDIR}/net/HTTP2.o.d" -o ${OBJECTDIR}/net/HTTP2.o net/HTTP2.c    -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/net/Helpers.o: net/Helpers.c  .generated_files/flags/default/7d2f3eceabd33266303d99471409ba9c1cff6bf8 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/net" 
	@${RM} ${OBJECTDIR}/net/Helpers.o.d 
	@${RM} ${OBJECTDIR}/net/Helpers.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O1 -D_SUPPRESS_PLIB_WARNING -DSYSCLK=40000000L -D_DISABLE_OPENADC10_CONFIGPORT_WARNING -MP -MMD -MF "${OBJECTDIR}/net/Helpers.o.d" -o ${OBJECTDIR}/net/Helpers.o net/Helpers.c    -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/net/Hashes.o: net/Hashes.c  .generated_files/flags/default/4ff5fe0528cdc1b648daa309b829d260184220ec .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/net" 
	@${RM} ${OBJECTDIR}/net/Hashes.o.d 
	@${RM} ${OBJECTDIR}/net/Hashes.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O1 -D_SUPPRESS_PLIB_WARNING -DSYSCLK=40000000L -D_DISABLE_OPENADC10_CONFIGPORT_WARNING -MP -MMD -MF "${OBJECTDIR}/net/Hashes.o.d" -o ${OBJECTDIR}/net/Hashes.o net/Hashes.c    -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/net/GenericTCPServer.o: net/GenericTCPServer.c  .generated_files/flags/default/b34d62774f322313f489c4feaacbd405e66d1d5c .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/net" 
	@${RM} ${OBJECTDIR}/net/GenericTCPServer.o.d 
	@${RM} ${OBJECTDIR}/net/GenericTCPServer.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O1 -D_SUPPRESS_PLIB_WARNING -DSYSCLK=40000000L -D_DISABLE_OPENADC10_CONFIGPORT_WARNING -MP -MMD -MF "${OBJECTDIR}/net/GenericTCPServer.o.d" -o ${OBJECTDIR}/net/GenericTCPServer.o net/GenericTCPServer.c    -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/net/FTP.o: net/FTP.c  .generated_files/flags/default/75d6571532524815bc3bfa75a5908c3f688a8e02 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/net" 
	@${RM} ${OBJECTDIR}/net/FTP.o.d 
	@${RM} ${OBJECTDIR}/net/FTP.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O1 -D_SUPPRESS_PLIB_WARNING -DSYSCLK=40000000L -D_DISABLE_OPENADC10_CONFIGPORT_WARNING -MP -MMD -MF "${OBJECTDIR}/net/FTP.o.d" -o ${OBJECTDIR}/net/FTP.o net/FTP.c    -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/net/ENC28J60.o: net/ENC28J60.c  .generated_files/flags/default/9f665d9398fee41abde98fbcbeeca91fe8917316 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/net" 
	@${RM} ${OBJECTDIR}/net/ENC28J60.o.d 
	@${RM} ${OBJECTDIR}/net/ENC28J60.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O1 -D_SUPPRESS_PLIB_WARNING -DSYSCLK=40000000L -D_DISABLE_OPENADC10_CONFIGPORT_WARNING -MP -MMD -MF "${OBJECTDIR}/net/ENC28J60.o.d" -o ${OBJECTDIR}/net/ENC28J60.o net/ENC28J60.c    -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/net/DNS.o: net/DNS.c  .generated_files/flags/default/172f35e1120e5a3ff4643d39021035a102f6854c .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/net" 
	@${RM} ${OBJECTDIR}/net/DNS.o.d 
	@${RM} ${OBJECTDIR}/net/DNS.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O1 -D_SUPPRESS_PLIB_WARNING -DSYSCLK=40000000L -D_DISABLE_OPENADC10_CONFIGPORT_WARNING -MP -MMD -MF "${OBJECTDIR}/net/DNS.o.d" -o ${OBJECTDIR}/net/DNS.o net/DNS.c    -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/net/DHCP.o: net/DHCP.c  .generated_files/flags/default/315fb5a909e969b2ddd2d3c4e08cbb62f797706f .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/net" 
	@${RM} ${OBJECTDIR}/net/DHCP.o.d 
	@${RM} ${OBJECTDIR}/net/DHCP.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O1 -D_SUPPRESS_PLIB_WARNING -DSYSCLK=40000000L -D_DISABLE_OPENADC10_CONFIGPORT_WARNING -MP -MMD -MF "${OBJECTDIR}/net/DHCP.o.d" -o ${OBJECTDIR}/net/DHCP.o net/DHCP.c    -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/CustomHTTPApp.o: CustomHTTPApp.c  .generated_files/flags/default/d84a7156be6bb02cbb22e52d3da59382d46cce15 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/CustomHTTPApp.o.d 
	@${RM} ${OBJECTDIR}/CustomHTTPApp.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O1 -D_SUPPRESS_PLIB_WARNING -DSYSCLK=40000000L -D_DISABLE_OPENADC10_CONFIGPORT_WARNING -MP -MMD -MF "${OBJECTDIR}/CustomHTTPApp.o.d" -o ${OBJECTDIR}/CustomHTTPApp.o CustomHTTPApp.c    -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/net/BerkeleyAPI.o: net/BerkeleyAPI.c  .generated_files/flags/default/55345e51e8cec6b42038248a4aa7fc176e2041fe .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/net" 
	@${RM} ${OBJECTDIR}/net/BerkeleyAPI.o.d 
	@${RM} ${OBJECTDIR}/net/BerkeleyAPI.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O1 -D_SUPPRESS_PLIB_WARNING -DSYSCLK=40000000L -D_DISABLE_OPENADC10_CONFIGPORT_WARNING -MP -MMD -MF "${OBJECTDIR}/net/BerkeleyAPI.o.d" -o ${OBJECTDIR}/net/BerkeleyAPI.o net/BerkeleyAPI.c    -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/net/BigInt.o: net/BigInt.c  .generated_files/flags/default/bbcd1e9a7d5f0370422898999d3783519fa7c2a8 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/net" 
	@${RM} ${OBJECTDIR}/net/BigInt.o.d 
	@${RM} ${OBJECTDIR}/net/BigInt.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O1 -D_SUPPRESS_PLIB_WARNING -DSYSCLK=40000000L -D_DISABLE_OPENADC10_CONFIGPORT_WARNING -MP -MMD -MF "${OBJECTDIR}/net/BigInt.o.d" -o ${OBJECTDIR}/net/BigInt.o net/BigInt.c    -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/net/AutoIP.o: net/AutoIP.c  .generated_files/flags/default/3fba90d9bc6459a59880630f4383f9ef23c1085 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/net" 
	@${RM} ${OBJECTDIR}/net/AutoIP.o.d 
	@${RM} ${OBJECTDIR}/net/AutoIP.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O1 -D_SUPPRESS_PLIB_WARNING -DSYSCLK=40000000L -D_DISABLE_OPENADC10_CONFIGPORT_WARNING -MP -MMD -MF "${OBJECTDIR}/net/AutoIP.o.d" -o ${OBJECTDIR}/net/AutoIP.o net/AutoIP.c    -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/net/ARP.o: net/ARP.c  .generated_files/flags/default/db9b0439d53818e88a04232d1f751754f8c7fbca .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/net" 
	@${RM} ${OBJECTDIR}/net/ARP.o.d 
	@${RM} ${OBJECTDIR}/net/ARP.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O1 -D_SUPPRESS_PLIB_WARNING -DSYSCLK=40000000L -D_DISABLE_OPENADC10_CONFIGPORT_WARNING -MP -MMD -MF "${OBJECTDIR}/net/ARP.o.d" -o ${OBJECTDIR}/net/ARP.o net/ARP.c    -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/net/ARCFOUR.o: net/ARCFOUR.c  .generated_files/flags/default/1c1b3c96dd1041868a7d2be6aa8d5529796b9f92 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/net" 
	@${RM} ${OBJECTDIR}/net/ARCFOUR.o.d 
	@${RM} ${OBJECTDIR}/net/ARCFOUR.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O1 -D_SUPPRESS_PLIB_WARNING -DSYSCLK=40000000L -D_DISABLE_OPENADC10_CONFIGPORT_WARNING -MP -MMD -MF "${OBJECTDIR}/net/ARCFOUR.o.d" -o ${OBJECTDIR}/net/ARCFOUR.o net/ARCFOUR.c    -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/net/Announce.o: net/Announce.c  .generated_files/flags/default/d8a5ee98326e13444f5fa115f34671a0820375fc .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/net" 
	@${RM} ${OBJECTDIR}/net/Announce.o.d 
	@${RM} ${OBJECTDIR}/net/Announce.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O1 -D_SUPPRESS_PLIB_WARNING -DSYSCLK=40000000L -D_DISABLE_OPENADC10_CONFIGPORT_WARNING -MP -MMD -MF "${OBJECTDIR}/net/Announce.o.d" -o ${OBJECTDIR}/net/Announce.o net/Announce.c    -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/net/Random.o: net/Random.c  .generated_files/flags/default/79ab31252eb3a82f11dc73d387ceeedff4155156 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/net" 
	@${RM} ${OBJECTDIR}/net/Random.o.d 
	@${RM} ${OBJECTDIR}/net/Random.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O1 -D_SUPPRESS_PLIB_WARNING -DSYSCLK=40000000L -D_DISABLE_OPENADC10_CONFIGPORT_WARNING -MP -MMD -MF "${OBJECTDIR}/net/Random.o.d" -o ${OBJECTDIR}/net/Random.o net/Random.c    -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/net/Reboot.o: net/Reboot.c  .generated_files/flags/default/26f5458f5a7e0076e68325e5852be02e22772a6a .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/net" 
	@${RM} ${OBJECTDIR}/net/Reboot.o.d 
	@${RM} ${OBJECTDIR}/net/Reboot.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O1 -D_SUPPRESS_PLIB_WARNING -DSYSCLK=40000000L -D_DISABLE_OPENADC10_CONFIGPORT_WARNING -MP -MMD -MF "${OBJECTDIR}/net/Reboot.o.d" -o ${OBJECTDIR}/net/Reboot.o net/Reboot.c    -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/net/RSA.o: net/RSA.c  .generated_files/flags/default/1ba24b7d0863c7df629458777344e7f3f80a554c .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/net" 
	@${RM} ${OBJECTDIR}/net/RSA.o.d 
	@${RM} ${OBJECTDIR}/net/RSA.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O1 -D_SUPPRESS_PLIB_WARNING -DSYSCLK=40000000L -D_DISABLE_OPENADC10_CONFIGPORT_WARNING -MP -MMD -MF "${OBJECTDIR}/net/RSA.o.d" -o ${OBJECTDIR}/net/RSA.o net/RSA.c    -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/net/SNTP.o: net/SNTP.c  .generated_files/flags/default/fb1a92070a5dcca31db18232e7d1d0d93edfc4e2 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/net" 
	@${RM} ${OBJECTDIR}/net/SNTP.o.d 
	@${RM} ${OBJECTDIR}/net/SNTP.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O1 -D_SUPPRESS_PLIB_WARNING -DSYSCLK=40000000L -D_DISABLE_OPENADC10_CONFIGPORT_WARNING -MP -MMD -MF "${OBJECTDIR}/net/SNTP.o.d" -o ${OBJECTDIR}/net/SNTP.o net/SNTP.c    -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/net/SMTP.o: net/SMTP.c  .generated_files/flags/default/dbc658f88f6b67c39b05ffac43c46f647bb2c407 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/net" 
	@${RM} ${OBJECTDIR}/net/SMTP.o.d 
	@${RM} ${OBJECTDIR}/net/SMTP.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O1 -D_SUPPRESS_PLIB_WARNING -DSYSCLK=40000000L -D_DISABLE_OPENADC10_CONFIGPORT_WARNING -MP -MMD -MF "${OBJECTDIR}/net/SMTP.o.d" -o ${OBJECTDIR}/net/SMTP.o net/SMTP.c    -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/net/SSL.o: net/SSL.c  .generated_files/flags/default/cdbbd9ae88e814e442e7bd26a330f0d2700728a3 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/net" 
	@${RM} ${OBJECTDIR}/net/SSL.o.d 
	@${RM} ${OBJECTDIR}/net/SSL.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O1 -D_SUPPRESS_PLIB_WARNING -DSYSCLK=40000000L -D_DISABLE_OPENADC10_CONFIGPORT_WARNING -MP -MMD -MF "${OBJECTDIR}/net/SSL.o.d" -o ${OBJECTDIR}/net/SSL.o net/SSL.c    -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/net/StackTsk.o: net/StackTsk.c  .generated_files/flags/default/534e373caa6b35d86a6b5c99e1f674c5041496e1 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/net" 
	@${RM} ${OBJECTDIR}/net/StackTsk.o.d 
	@${RM} ${OBJECTDIR}/net/StackTsk.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O1 -D_SUPPRESS_PLIB_WARNING -DSYSCLK=40000000L -D_DISABLE_OPENADC10_CONFIGPORT_WARNING -MP -MMD -MF "${OBJECTDIR}/net/StackTsk.o.d" -o ${OBJECTDIR}/net/StackTsk.o net/StackTsk.c    -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/net/TCP.o: net/TCP.c  .generated_files/flags/default/f79b4306223d804fee3ac2d872e7e99f295a71fe .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/net" 
	@${RM} ${OBJECTDIR}/net/TCP.o.d 
	@${RM} ${OBJECTDIR}/net/TCP.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O1 -D_SUPPRESS_PLIB_WARNING -DSYSCLK=40000000L -D_DISABLE_OPENADC10_CONFIGPORT_WARNING -MP -MMD -MF "${OBJECTDIR}/net/TCP.o.d" -o ${OBJECTDIR}/net/TCP.o net/TCP.c    -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/net/Telnet.o: net/Telnet.c  .generated_files/flags/default/5c950153430c85388ad3de3460741b4c82dc466e .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/net" 
	@${RM} ${OBJECTDIR}/net/Telnet.o.d 
	@${RM} ${OBJECTDIR}/net/Telnet.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O1 -D_SUPPRESS_PLIB_WARNING -DSYSCLK=40000000L -D_DISABLE_OPENADC10_CONFIGPORT_WARNING -MP -MMD -MF "${OBJECTDIR}/net/Telnet.o.d" -o ${OBJECTDIR}/net/Telnet.o net/Telnet.c    -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/net/Tick.o: net/Tick.c  .generated_files/flags/default/ffff8b75d60883c87cec10b832bba4a7e6f4db72 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/net" 
	@${RM} ${OBJECTDIR}/net/Tick.o.d 
	@${RM} ${OBJECTDIR}/net/Tick.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O1 -D_SUPPRESS_PLIB_WARNING -DSYSCLK=40000000L -D_DISABLE_OPENADC10_CONFIGPORT_WARNING -MP -MMD -MF "${OBJECTDIR}/net/Tick.o.d" -o ${OBJECTDIR}/net/Tick.o net/Tick.c    -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/net/UDP.o: net/UDP.c  .generated_files/flags/default/4bf29ee481f72adeae0a87cad318bc7f8db07b95 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/net" 
	@${RM} ${OBJECTDIR}/net/UDP.o.d 
	@${RM} ${OBJECTDIR}/net/UDP.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O1 -D_SUPPRESS_PLIB_WARNING -DSYSCLK=40000000L -D_DISABLE_OPENADC10_CONFIGPORT_WARNING -MP -MMD -MF "${OBJECTDIR}/net/UDP.o.d" -o ${OBJECTDIR}/net/UDP.o net/UDP.c    -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/net/ZeroconfHelper.o: net/ZeroconfHelper.c  .generated_files/flags/default/25dcd75bcf9363329ec95b9754028983f812df8a .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/net" 
	@${RM} ${OBJECTDIR}/net/ZeroconfHelper.o.d 
	@${RM} ${OBJECTDIR}/net/ZeroconfHelper.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O1 -D_SUPPRESS_PLIB_WARNING -DSYSCLK=40000000L -D_DISABLE_OPENADC10_CONFIGPORT_WARNING -MP -MMD -MF "${OBJECTDIR}/net/ZeroconfHelper.o.d" -o ${OBJECTDIR}/net/ZeroconfHelper.o net/ZeroconfHelper.c    -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/net/ZeroconfLinkLocal.o: net/ZeroconfLinkLocal.c  .generated_files/flags/default/3d5ad9a10b427c1a7f2c99c2ec13d03f620692d .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/net" 
	@${RM} ${OBJECTDIR}/net/ZeroconfLinkLocal.o.d 
	@${RM} ${OBJECTDIR}/net/ZeroconfLinkLocal.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O1 -D_SUPPRESS_PLIB_WARNING -DSYSCLK=40000000L -D_DISABLE_OPENADC10_CONFIGPORT_WARNING -MP -MMD -MF "${OBJECTDIR}/net/ZeroconfLinkLocal.o.d" -o ${OBJECTDIR}/net/ZeroconfLinkLocal.o net/ZeroconfLinkLocal.c    -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/net/ZeroconfMulticastDNS.o: net/ZeroconfMulticastDNS.c  .generated_files/flags/default/f2390d23c92ee7583f7577d379e57c7e3ea850eb .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/net" 
	@${RM} ${OBJECTDIR}/net/ZeroconfMulticastDNS.o.d 
	@${RM} ${OBJECTDIR}/net/ZeroconfMulticastDNS.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O1 -D_SUPPRESS_PLIB_WARNING -DSYSCLK=40000000L -D_DISABLE_OPENADC10_CONFIGPORT_WARNING -MP -MMD -MF "${OBJECTDIR}/net/ZeroconfMulticastDNS.o.d" -o ${OBJECTDIR}/net/ZeroconfMulticastDNS.o net/ZeroconfMulticastDNS.c    -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/net/MQTT.o: net/MQTT.c  .generated_files/flags/default/41cdc0c0aa7139a2837958367aa520517a1c61fc .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/net" 
	@${RM} ${OBJECTDIR}/net/MQTT.o.d 
	@${RM} ${OBJECTDIR}/net/MQTT.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O1 -D_SUPPRESS_PLIB_WARNING -DSYSCLK=40000000L -D_DISABLE_OPENADC10_CONFIGPORT_WARNING -MP -MMD -MF "${OBJECTDIR}/net/MQTT.o.d" -o ${OBJECTDIR}/net/MQTT.o net/MQTT.c    -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/nvram/nvram.o: nvram/nvram.c  .generated_files/flags/default/1a41e879ffbf3ce53157557db5ac41fa249b0cf1 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/nvram" 
	@${RM} ${OBJECTDIR}/nvram/nvram.o.d 
	@${RM} ${OBJECTDIR}/nvram/nvram.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O1 -D_SUPPRESS_PLIB_WARNING -DSYSCLK=40000000L -D_DISABLE_OPENADC10_CONFIGPORT_WARNING -MP -MMD -MF "${OBJECTDIR}/nvram/nvram.o.d" -o ${OBJECTDIR}/nvram/nvram.o nvram/nvram.c    -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/time/time.o: time/time.c  .generated_files/flags/default/61ba1481ad3ac18aaf6163f314a7ed08193c8deb .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/time" 
	@${RM} ${OBJECTDIR}/time/time.o.d 
	@${RM} ${OBJECTDIR}/time/time.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O1 -D_SUPPRESS_PLIB_WARNING -DSYSCLK=40000000L -D_DISABLE_OPENADC10_CONFIGPORT_WARNING -MP -MMD -MF "${OBJECTDIR}/time/time.o.d" -o ${OBJECTDIR}/time/time.o time/time.c    -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/uart/uart.o: uart/uart.c  .generated_files/flags/default/79a8b70435175bea6587cbedc4db0ddca08af40b .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/uart" 
	@${RM} ${OBJECTDIR}/uart/uart.o.d 
	@${RM} ${OBJECTDIR}/uart/uart.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O1 -D_SUPPRESS_PLIB_WARNING -DSYSCLK=40000000L -D_DISABLE_OPENADC10_CONFIGPORT_WARNING -MP -MMD -MF "${OBJECTDIR}/uart/uart.o.d" -o ${OBJECTDIR}/uart/uart.o uart/uart.c    -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/usb_host_msd/usb_config.o: usb_host_msd/usb_config.c  .generated_files/flags/default/7daebbff4de4c92d47df0e2958923078fd9937d9 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/usb_host_msd" 
	@${RM} ${OBJECTDIR}/usb_host_msd/usb_config.o.d 
	@${RM} ${OBJECTDIR}/usb_host_msd/usb_config.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O1 -D_SUPPRESS_PLIB_WARNING -DSYSCLK=40000000L -D_DISABLE_OPENADC10_CONFIGPORT_WARNING -MP -MMD -MF "${OBJECTDIR}/usb_host_msd/usb_config.o.d" -o ${OBJECTDIR}/usb_host_msd/usb_config.o usb_host_msd/usb_config.c    -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/usb_host_msd/usb_host.o: usb_host_msd/usb_host.c  .generated_files/flags/default/4e89c52edc9de731caea1f29c995f9209ccd886b .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/usb_host_msd" 
	@${RM} ${OBJECTDIR}/usb_host_msd/usb_host.o.d 
	@${RM} ${OBJECTDIR}/usb_host_msd/usb_host.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O1 -D_SUPPRESS_PLIB_WARNING -DSYSCLK=40000000L -D_DISABLE_OPENADC10_CONFIGPORT_WARNING -MP -MMD -MF "${OBJECTDIR}/usb_host_msd/usb_host.o.d" -o ${OBJECTDIR}/usb_host_msd/usb_host.o usb_host_msd/usb_host.c    -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/usb_host_msd/usb_host_msd.o: usb_host_msd/usb_host_msd.c  .generated_files/flags/default/f0a5b53edea343560670709d8c4cca3d1a672bc6 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/usb_host_msd" 
	@${RM} ${OBJECTDIR}/usb_host_msd/usb_host_msd.o.d 
	@${RM} ${OBJECTDIR}/usb_host_msd/usb_host_msd.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O1 -D_SUPPRESS_PLIB_WARNING -DSYSCLK=40000000L -D_DISABLE_OPENADC10_CONFIGPORT_WARNING -MP -MMD -MF "${OBJECTDIR}/usb_host_msd/usb_host_msd.o.d" -o ${OBJECTDIR}/usb_host_msd/usb_host_msd.o usb_host_msd/usb_host_msd.c    -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/usb_host_msd/usb_host_msd_scsi.o: usb_host_msd/usb_host_msd_scsi.c  .generated_files/flags/default/6140892e8643bf29b66863ab913dc228839e7fed .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/usb_host_msd" 
	@${RM} ${OBJECTDIR}/usb_host_msd/usb_host_msd_scsi.o.d 
	@${RM} ${OBJECTDIR}/usb_host_msd/usb_host_msd_scsi.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O1 -D_SUPPRESS_PLIB_WARNING -DSYSCLK=40000000L -D_DISABLE_OPENADC10_CONFIGPORT_WARNING -MP -MMD -MF "${OBJECTDIR}/usb_host_msd/usb_host_msd_scsi.o.d" -o ${OBJECTDIR}/usb_host_msd/usb_host_msd_scsi.o usb_host_msd/usb_host_msd_scsi.c    -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/usb_host_msd/event.o: usb_host_msd/event.c  .generated_files/flags/default/b8180184ae916d69cc6af39fae2f6c26379935ef .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/usb_host_msd" 
	@${RM} ${OBJECTDIR}/usb_host_msd/event.o.d 
	@${RM} ${OBJECTDIR}/usb_host_msd/event.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O1 -D_SUPPRESS_PLIB_WARNING -DSYSCLK=40000000L -D_DISABLE_OPENADC10_CONFIGPORT_WARNING -MP -MMD -MF "${OBJECTDIR}/usb_host_msd/event.o.d" -o ${OBJECTDIR}/usb_host_msd/event.o usb_host_msd/event.c    -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/main.o: main.c  .generated_files/flags/default/9281359e6f341f9aa4c6ee3b86dcec0f5b315faa .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/main.o.d 
	@${RM} ${OBJECTDIR}/main.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O1 -D_SUPPRESS_PLIB_WARNING -DSYSCLK=40000000L -D_DISABLE_OPENADC10_CONFIGPORT_WARNING -MP -MMD -MF "${OBJECTDIR}/main.o.d" -o ${OBJECTDIR}/main.o main.c    -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/common.o: common.c  .generated_files/flags/default/5e5e75f0862ebfc66bc0d6f25e532fce0f06015c .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/common.o.d 
	@${RM} ${OBJECTDIR}/common.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O1 -D_SUPPRESS_PLIB_WARNING -DSYSCLK=40000000L -D_DISABLE_OPENADC10_CONFIGPORT_WARNING -MP -MMD -MF "${OBJECTDIR}/common.o.d" -o ${OBJECTDIR}/common.o common.c    -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
else
${OBJECTDIR}/bme280/bme280.o: bme280/bme280.c  .generated_files/flags/default/383064c7ce9573b5cbc4d79a2058b19a836890ab .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/bme280" 
	@${RM} ${OBJECTDIR}/bme280/bme280.o.d 
	@${RM} ${OBJECTDIR}/bme280/bme280.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O1 -D_SUPPRESS_PLIB_WARNING -DSYSCLK=40000000L -D_DISABLE_OPENADC10_CONFIGPORT_WARNING -MP -MMD -MF "${OBJECTDIR}/bme280/bme280.o.d" -o ${OBJECTDIR}/bme280/bme280.o bme280/bme280.c    -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/btn/buttons_i2c.o: btn/buttons_i2c.c  .generated_files/flags/default/854be2cc7847b83817d11c15fb3bdfc484c8b78e .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/btn" 
	@${RM} ${OBJECTDIR}/btn/buttons_i2c.o.d 
	@${RM} ${OBJECTDIR}/btn/buttons_i2c.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O1 -D_SUPPRESS_PLIB_WARNING -DSYSCLK=40000000L -D_DISABLE_OPENADC10_CONFIGPORT_WARNING -MP -MMD -MF "${OBJECTDIR}/btn/buttons_i2c.o.d" -o ${OBJECTDIR}/btn/buttons_i2c.o btn/buttons_i2c.c    -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/config/config.o: config/config.c  .generated_files/flags/default/cfe8f9f279b8dec82d32ec47b9b9c2d611fb0676 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/config" 
	@${RM} ${OBJECTDIR}/config/config.o.d 
	@${RM} ${OBJECTDIR}/config/config.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O1 -D_SUPPRESS_PLIB_WARNING -DSYSCLK=40000000L -D_DISABLE_OPENADC10_CONFIGPORT_WARNING -MP -MMD -MF "${OBJECTDIR}/config/config.o.d" -o ${OBJECTDIR}/config/config.o config/config.c    -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/delay/delay.o: delay/delay.c  .generated_files/flags/default/37e23f46201da5881449373745b003b52329a6fb .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/delay" 
	@${RM} ${OBJECTDIR}/delay/delay.o.d 
	@${RM} ${OBJECTDIR}/delay/delay.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O1 -D_SUPPRESS_PLIB_WARNING -DSYSCLK=40000000L -D_DISABLE_OPENADC10_CONFIGPORT_WARNING -MP -MMD -MF "${OBJECTDIR}/delay/delay.o.d" -o ${OBJECTDIR}/delay/delay.o delay/delay.c    -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/fatfs/ff.o: fatfs/ff.c  .generated_files/flags/default/431d749687024e59c3fee431f983f63e19bec258 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/fatfs" 
	@${RM} ${OBJECTDIR}/fatfs/ff.o.d 
	@${RM} ${OBJECTDIR}/fatfs/ff.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O1 -D_SUPPRESS_PLIB_WARNING -DSYSCLK=40000000L -D_DISABLE_OPENADC10_CONFIGPORT_WARNING -MP -MMD -MF "${OBJECTDIR}/fatfs/ff.o.d" -o ${OBJECTDIR}/fatfs/ff.o fatfs/ff.c    -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/fatfs/ffsystem.o: fatfs/ffsystem.c  .generated_files/flags/default/c8dcba30f6db3a6afda298449aff8e8ebf95d7dd .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/fatfs" 
	@${RM} ${OBJECTDIR}/fatfs/ffsystem.o.d 
	@${RM} ${OBJECTDIR}/fatfs/ffsystem.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O1 -D_SUPPRESS_PLIB_WARNING -DSYSCLK=40000000L -D_DISABLE_OPENADC10_CONFIGPORT_WARNING -MP -MMD -MF "${OBJECTDIR}/fatfs/ffsystem.o.d" -o ${OBJECTDIR}/fatfs/ffsystem.o fatfs/ffsystem.c    -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/fatfs/ffunicode.o: fatfs/ffunicode.c  .generated_files/flags/default/f0b4e924c1aad4c4c18c2b8635ef5fe4684c5cf7 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/fatfs" 
	@${RM} ${OBJECTDIR}/fatfs/ffunicode.o.d 
	@${RM} ${OBJECTDIR}/fatfs/ffunicode.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O1 -D_SUPPRESS_PLIB_WARNING -DSYSCLK=40000000L -D_DISABLE_OPENADC10_CONFIGPORT_WARNING -MP -MMD -MF "${OBJECTDIR}/fatfs/ffunicode.o.d" -o ${OBJECTDIR}/fatfs/ffunicode.o fatfs/ffunicode.c    -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/fatfs/SPIFlash.o: fatfs/SPIFlash.c  .generated_files/flags/default/9df515c7cb6c46b85dba8946f15c6df07ff49149 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/fatfs" 
	@${RM} ${OBJECTDIR}/fatfs/SPIFlash.o.d 
	@${RM} ${OBJECTDIR}/fatfs/SPIFlash.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O1 -D_SUPPRESS_PLIB_WARNING -DSYSCLK=40000000L -D_DISABLE_OPENADC10_CONFIGPORT_WARNING -MP -MMD -MF "${OBJECTDIR}/fatfs/SPIFlash.o.d" -o ${OBJECTDIR}/fatfs/SPIFlash.o fatfs/SPIFlash.c    -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/fatfs/diskio.o: fatfs/diskio.c  .generated_files/flags/default/1e67d55d897b2f6ae8fe3f0fb8805dd34b065df0 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/fatfs" 
	@${RM} ${OBJECTDIR}/fatfs/diskio.o.d 
	@${RM} ${OBJECTDIR}/fatfs/diskio.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O1 -D_SUPPRESS_PLIB_WARNING -DSYSCLK=40000000L -D_DISABLE_OPENADC10_CONFIGPORT_WARNING -MP -MMD -MF "${OBJECTDIR}/fatfs/diskio.o.d" -o ${OBJECTDIR}/fatfs/diskio.o fatfs/diskio.c    -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/geiger/geiger.o: geiger/geiger.c  .generated_files/flags/default/56c042d3ce6dd11d97e1bfb4ebfe7b03136efc07 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/geiger" 
	@${RM} ${OBJECTDIR}/geiger/geiger.o.d 
	@${RM} ${OBJECTDIR}/geiger/geiger.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O1 -D_SUPPRESS_PLIB_WARNING -DSYSCLK=40000000L -D_DISABLE_OPENADC10_CONFIGPORT_WARNING -MP -MMD -MF "${OBJECTDIR}/geiger/geiger.o.d" -o ${OBJECTDIR}/geiger/geiger.o geiger/geiger.c    -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/lcd/i2c.o: lcd/i2c.c  .generated_files/flags/default/2a9671d089a7b7ee6f718f26215e8174d68cf1c6 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/lcd" 
	@${RM} ${OBJECTDIR}/lcd/i2c.o.d 
	@${RM} ${OBJECTDIR}/lcd/i2c.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O1 -D_SUPPRESS_PLIB_WARNING -DSYSCLK=40000000L -D_DISABLE_OPENADC10_CONFIGPORT_WARNING -MP -MMD -MF "${OBJECTDIR}/lcd/i2c.o.d" -o ${OBJECTDIR}/lcd/i2c.o lcd/i2c.c    -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/lcd/hd44780.o: lcd/hd44780.c  .generated_files/flags/default/270d2de27a0920a7435c7e8ce9d4467e4230915 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/lcd" 
	@${RM} ${OBJECTDIR}/lcd/hd44780.o.d 
	@${RM} ${OBJECTDIR}/lcd/hd44780.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O1 -D_SUPPRESS_PLIB_WARNING -DSYSCLK=40000000L -D_DISABLE_OPENADC10_CONFIGPORT_WARNING -MP -MMD -MF "${OBJECTDIR}/lcd/hd44780.o.d" -o ${OBJECTDIR}/lcd/hd44780.o lcd/hd44780.c    -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/lcd/display.o: lcd/display.c  .generated_files/flags/default/2156a1829541401e37d1c73f789e4bb3c18a68be .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/lcd" 
	@${RM} ${OBJECTDIR}/lcd/display.o.d 
	@${RM} ${OBJECTDIR}/lcd/display.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O1 -D_SUPPRESS_PLIB_WARNING -DSYSCLK=40000000L -D_DISABLE_OPENADC10_CONFIGPORT_WARNING -MP -MMD -MF "${OBJECTDIR}/lcd/display.o.d" -o ${OBJECTDIR}/lcd/display.o lcd/display.c    -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/MPFSImg2.o: MPFSImg2.c  .generated_files/flags/default/f25b56d828b6492a5d18c2361a2e8c9ae9003bcf .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/MPFSImg2.o.d 
	@${RM} ${OBJECTDIR}/MPFSImg2.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O1 -D_SUPPRESS_PLIB_WARNING -DSYSCLK=40000000L -D_DISABLE_OPENADC10_CONFIGPORT_WARNING -MP -MMD -MF "${OBJECTDIR}/MPFSImg2.o.d" -o ${OBJECTDIR}/MPFSImg2.o MPFSImg2.c    -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/net/NBNS.o: net/NBNS.c  .generated_files/flags/default/8648d1473762da2c8449f51055f4ae859a30f15 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/net" 
	@${RM} ${OBJECTDIR}/net/NBNS.o.d 
	@${RM} ${OBJECTDIR}/net/NBNS.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O1 -D_SUPPRESS_PLIB_WARNING -DSYSCLK=40000000L -D_DISABLE_OPENADC10_CONFIGPORT_WARNING -MP -MMD -MF "${OBJECTDIR}/net/NBNS.o.d" -o ${OBJECTDIR}/net/NBNS.o net/NBNS.c    -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/net/MPFS2.o: net/MPFS2.c  .generated_files/flags/default/9cac10ef88f9f2fc515a2872c23599929a0e4fb .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/net" 
	@${RM} ${OBJECTDIR}/net/MPFS2.o.d 
	@${RM} ${OBJECTDIR}/net/MPFS2.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O1 -D_SUPPRESS_PLIB_WARNING -DSYSCLK=40000000L -D_DISABLE_OPENADC10_CONFIGPORT_WARNING -MP -MMD -MF "${OBJECTDIR}/net/MPFS2.o.d" -o ${OBJECTDIR}/net/MPFS2.o net/MPFS2.c    -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/net/IP.o: net/IP.c  .generated_files/flags/default/807d3e743eeb72b019b225ea95aa351cff3c3fee .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/net" 
	@${RM} ${OBJECTDIR}/net/IP.o.d 
	@${RM} ${OBJECTDIR}/net/IP.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O1 -D_SUPPRESS_PLIB_WARNING -DSYSCLK=40000000L -D_DISABLE_OPENADC10_CONFIGPORT_WARNING -MP -MMD -MF "${OBJECTDIR}/net/IP.o.d" -o ${OBJECTDIR}/net/IP.o net/IP.c    -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/net/ICMP.o: net/ICMP.c  .generated_files/flags/default/54c377472ef3f0d5f14192c68e6aa23661228d14 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/net" 
	@${RM} ${OBJECTDIR}/net/ICMP.o.d 
	@${RM} ${OBJECTDIR}/net/ICMP.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O1 -D_SUPPRESS_PLIB_WARNING -DSYSCLK=40000000L -D_DISABLE_OPENADC10_CONFIGPORT_WARNING -MP -MMD -MF "${OBJECTDIR}/net/ICMP.o.d" -o ${OBJECTDIR}/net/ICMP.o net/ICMP.c    -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/net/HTTP2.o: net/HTTP2.c  .generated_files/flags/default/3bb75c5673d11aaf9610837d7255ba17644808f7 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/net" 
	@${RM} ${OBJECTDIR}/net/HTTP2.o.d 
	@${RM} ${OBJECTDIR}/net/HTTP2.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O1 -D_SUPPRESS_PLIB_WARNING -DSYSCLK=40000000L -D_DISABLE_OPENADC10_CONFIGPORT_WARNING -MP -MMD -MF "${OBJECTDIR}/net/HTTP2.o.d" -o ${OBJECTDIR}/net/HTTP2.o net/HTTP2.c    -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/net/Helpers.o: net/Helpers.c  .generated_files/flags/default/a5c3af5012bd13f02030853c87da2d65c9b59911 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/net" 
	@${RM} ${OBJECTDIR}/net/Helpers.o.d 
	@${RM} ${OBJECTDIR}/net/Helpers.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O1 -D_SUPPRESS_PLIB_WARNING -DSYSCLK=40000000L -D_DISABLE_OPENADC10_CONFIGPORT_WARNING -MP -MMD -MF "${OBJECTDIR}/net/Helpers.o.d" -o ${OBJECTDIR}/net/Helpers.o net/Helpers.c    -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/net/Hashes.o: net/Hashes.c  .generated_files/flags/default/2295c0bd6b951725ad8736324de6075fd02ac8e7 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/net" 
	@${RM} ${OBJECTDIR}/net/Hashes.o.d 
	@${RM} ${OBJECTDIR}/net/Hashes.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O1 -D_SUPPRESS_PLIB_WARNING -DSYSCLK=40000000L -D_DISABLE_OPENADC10_CONFIGPORT_WARNING -MP -MMD -MF "${OBJECTDIR}/net/Hashes.o.d" -o ${OBJECTDIR}/net/Hashes.o net/Hashes.c    -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/net/GenericTCPServer.o: net/GenericTCPServer.c  .generated_files/flags/default/413a9c2c7d26c30d23b3aa48050ccd57ba26ce3 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/net" 
	@${RM} ${OBJECTDIR}/net/GenericTCPServer.o.d 
	@${RM} ${OBJECTDIR}/net/GenericTCPServer.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O1 -D_SUPPRESS_PLIB_WARNING -DSYSCLK=40000000L -D_DISABLE_OPENADC10_CONFIGPORT_WARNING -MP -MMD -MF "${OBJECTDIR}/net/GenericTCPServer.o.d" -o ${OBJECTDIR}/net/GenericTCPServer.o net/GenericTCPServer.c    -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/net/FTP.o: net/FTP.c  .generated_files/flags/default/187f003bbfa7c7176f41238c65fb9077d1c4d316 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/net" 
	@${RM} ${OBJECTDIR}/net/FTP.o.d 
	@${RM} ${OBJECTDIR}/net/FTP.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O1 -D_SUPPRESS_PLIB_WARNING -DSYSCLK=40000000L -D_DISABLE_OPENADC10_CONFIGPORT_WARNING -MP -MMD -MF "${OBJECTDIR}/net/FTP.o.d" -o ${OBJECTDIR}/net/FTP.o net/FTP.c    -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/net/ENC28J60.o: net/ENC28J60.c  .generated_files/flags/default/c91c7acb57eaf8ad4bdab2b8b0c4abb465a20ba3 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/net" 
	@${RM} ${OBJECTDIR}/net/ENC28J60.o.d 
	@${RM} ${OBJECTDIR}/net/ENC28J60.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O1 -D_SUPPRESS_PLIB_WARNING -DSYSCLK=40000000L -D_DISABLE_OPENADC10_CONFIGPORT_WARNING -MP -MMD -MF "${OBJECTDIR}/net/ENC28J60.o.d" -o ${OBJECTDIR}/net/ENC28J60.o net/ENC28J60.c    -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/net/DNS.o: net/DNS.c  .generated_files/flags/default/df14e2554fbbef83ecf43a71ed8796b1828eabf2 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/net" 
	@${RM} ${OBJECTDIR}/net/DNS.o.d 
	@${RM} ${OBJECTDIR}/net/DNS.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O1 -D_SUPPRESS_PLIB_WARNING -DSYSCLK=40000000L -D_DISABLE_OPENADC10_CONFIGPORT_WARNING -MP -MMD -MF "${OBJECTDIR}/net/DNS.o.d" -o ${OBJECTDIR}/net/DNS.o net/DNS.c    -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/net/DHCP.o: net/DHCP.c  .generated_files/flags/default/8615a9d81844d490e2efd1445329123c317ea6dd .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/net" 
	@${RM} ${OBJECTDIR}/net/DHCP.o.d 
	@${RM} ${OBJECTDIR}/net/DHCP.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O1 -D_SUPPRESS_PLIB_WARNING -DSYSCLK=40000000L -D_DISABLE_OPENADC10_CONFIGPORT_WARNING -MP -MMD -MF "${OBJECTDIR}/net/DHCP.o.d" -o ${OBJECTDIR}/net/DHCP.o net/DHCP.c    -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/CustomHTTPApp.o: CustomHTTPApp.c  .generated_files/flags/default/1ba2941e09f1f82bf2568d9ec6ac354016c349c4 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/CustomHTTPApp.o.d 
	@${RM} ${OBJECTDIR}/CustomHTTPApp.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O1 -D_SUPPRESS_PLIB_WARNING -DSYSCLK=40000000L -D_DISABLE_OPENADC10_CONFIGPORT_WARNING -MP -MMD -MF "${OBJECTDIR}/CustomHTTPApp.o.d" -o ${OBJECTDIR}/CustomHTTPApp.o CustomHTTPApp.c    -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/net/BerkeleyAPI.o: net/BerkeleyAPI.c  .generated_files/flags/default/658fa035c04390098d46a22cb8785f5b5ea32315 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/net" 
	@${RM} ${OBJECTDIR}/net/BerkeleyAPI.o.d 
	@${RM} ${OBJECTDIR}/net/BerkeleyAPI.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O1 -D_SUPPRESS_PLIB_WARNING -DSYSCLK=40000000L -D_DISABLE_OPENADC10_CONFIGPORT_WARNING -MP -MMD -MF "${OBJECTDIR}/net/BerkeleyAPI.o.d" -o ${OBJECTDIR}/net/BerkeleyAPI.o net/BerkeleyAPI.c    -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/net/BigInt.o: net/BigInt.c  .generated_files/flags/default/89ef72b6234a0fb9d37e965a1d130b9208a4acfa .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/net" 
	@${RM} ${OBJECTDIR}/net/BigInt.o.d 
	@${RM} ${OBJECTDIR}/net/BigInt.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O1 -D_SUPPRESS_PLIB_WARNING -DSYSCLK=40000000L -D_DISABLE_OPENADC10_CONFIGPORT_WARNING -MP -MMD -MF "${OBJECTDIR}/net/BigInt.o.d" -o ${OBJECTDIR}/net/BigInt.o net/BigInt.c    -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/net/AutoIP.o: net/AutoIP.c  .generated_files/flags/default/6a6cf95ea5056b572afdecdd530c0a86f6d3b992 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/net" 
	@${RM} ${OBJECTDIR}/net/AutoIP.o.d 
	@${RM} ${OBJECTDIR}/net/AutoIP.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O1 -D_SUPPRESS_PLIB_WARNING -DSYSCLK=40000000L -D_DISABLE_OPENADC10_CONFIGPORT_WARNING -MP -MMD -MF "${OBJECTDIR}/net/AutoIP.o.d" -o ${OBJECTDIR}/net/AutoIP.o net/AutoIP.c    -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/net/ARP.o: net/ARP.c  .generated_files/flags/default/1bb2e2e0b82fae05bb521e3977ee468ce413e127 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/net" 
	@${RM} ${OBJECTDIR}/net/ARP.o.d 
	@${RM} ${OBJECTDIR}/net/ARP.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O1 -D_SUPPRESS_PLIB_WARNING -DSYSCLK=40000000L -D_DISABLE_OPENADC10_CONFIGPORT_WARNING -MP -MMD -MF "${OBJECTDIR}/net/ARP.o.d" -o ${OBJECTDIR}/net/ARP.o net/ARP.c    -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/net/ARCFOUR.o: net/ARCFOUR.c  .generated_files/flags/default/591a0689ba65642098be5fa905f4b7a99ccf66c7 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/net" 
	@${RM} ${OBJECTDIR}/net/ARCFOUR.o.d 
	@${RM} ${OBJECTDIR}/net/ARCFOUR.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O1 -D_SUPPRESS_PLIB_WARNING -DSYSCLK=40000000L -D_DISABLE_OPENADC10_CONFIGPORT_WARNING -MP -MMD -MF "${OBJECTDIR}/net/ARCFOUR.o.d" -o ${OBJECTDIR}/net/ARCFOUR.o net/ARCFOUR.c    -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/net/Announce.o: net/Announce.c  .generated_files/flags/default/2fb97cedd7308ba86ca6240150419d63100cded5 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/net" 
	@${RM} ${OBJECTDIR}/net/Announce.o.d 
	@${RM} ${OBJECTDIR}/net/Announce.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O1 -D_SUPPRESS_PLIB_WARNING -DSYSCLK=40000000L -D_DISABLE_OPENADC10_CONFIGPORT_WARNING -MP -MMD -MF "${OBJECTDIR}/net/Announce.o.d" -o ${OBJECTDIR}/net/Announce.o net/Announce.c    -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/net/Random.o: net/Random.c  .generated_files/flags/default/f94adec794ddaeb02a1e62f908debb31ae15f605 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/net" 
	@${RM} ${OBJECTDIR}/net/Random.o.d 
	@${RM} ${OBJECTDIR}/net/Random.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O1 -D_SUPPRESS_PLIB_WARNING -DSYSCLK=40000000L -D_DISABLE_OPENADC10_CONFIGPORT_WARNING -MP -MMD -MF "${OBJECTDIR}/net/Random.o.d" -o ${OBJECTDIR}/net/Random.o net/Random.c    -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/net/Reboot.o: net/Reboot.c  .generated_files/flags/default/8165889ef2be3a5ae45c85667a3822aa248b592e .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/net" 
	@${RM} ${OBJECTDIR}/net/Reboot.o.d 
	@${RM} ${OBJECTDIR}/net/Reboot.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O1 -D_SUPPRESS_PLIB_WARNING -DSYSCLK=40000000L -D_DISABLE_OPENADC10_CONFIGPORT_WARNING -MP -MMD -MF "${OBJECTDIR}/net/Reboot.o.d" -o ${OBJECTDIR}/net/Reboot.o net/Reboot.c    -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/net/RSA.o: net/RSA.c  .generated_files/flags/default/a8e8ce9aad038614e6536ede006a1638833ee810 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/net" 
	@${RM} ${OBJECTDIR}/net/RSA.o.d 
	@${RM} ${OBJECTDIR}/net/RSA.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O1 -D_SUPPRESS_PLIB_WARNING -DSYSCLK=40000000L -D_DISABLE_OPENADC10_CONFIGPORT_WARNING -MP -MMD -MF "${OBJECTDIR}/net/RSA.o.d" -o ${OBJECTDIR}/net/RSA.o net/RSA.c    -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/net/SNTP.o: net/SNTP.c  .generated_files/flags/default/27924e31cc03086ace2e4a52c8515884634c04ab .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/net" 
	@${RM} ${OBJECTDIR}/net/SNTP.o.d 
	@${RM} ${OBJECTDIR}/net/SNTP.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O1 -D_SUPPRESS_PLIB_WARNING -DSYSCLK=40000000L -D_DISABLE_OPENADC10_CONFIGPORT_WARNING -MP -MMD -MF "${OBJECTDIR}/net/SNTP.o.d" -o ${OBJECTDIR}/net/SNTP.o net/SNTP.c    -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/net/SMTP.o: net/SMTP.c  .generated_files/flags/default/27ba3b0cf1903c8068fa3b326054ae6c63e46d22 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/net" 
	@${RM} ${OBJECTDIR}/net/SMTP.o.d 
	@${RM} ${OBJECTDIR}/net/SMTP.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O1 -D_SUPPRESS_PLIB_WARNING -DSYSCLK=40000000L -D_DISABLE_OPENADC10_CONFIGPORT_WARNING -MP -MMD -MF "${OBJECTDIR}/net/SMTP.o.d" -o ${OBJECTDIR}/net/SMTP.o net/SMTP.c    -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/net/SSL.o: net/SSL.c  .generated_files/flags/default/8a742c4366f8b01be86990cdd5d0ea2a9615f43f .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/net" 
	@${RM} ${OBJECTDIR}/net/SSL.o.d 
	@${RM} ${OBJECTDIR}/net/SSL.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O1 -D_SUPPRESS_PLIB_WARNING -DSYSCLK=40000000L -D_DISABLE_OPENADC10_CONFIGPORT_WARNING -MP -MMD -MF "${OBJECTDIR}/net/SSL.o.d" -o ${OBJECTDIR}/net/SSL.o net/SSL.c    -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/net/StackTsk.o: net/StackTsk.c  .generated_files/flags/default/ea0cc1ffda1925b7a759d7869a5d629e781f23c9 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/net" 
	@${RM} ${OBJECTDIR}/net/StackTsk.o.d 
	@${RM} ${OBJECTDIR}/net/StackTsk.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O1 -D_SUPPRESS_PLIB_WARNING -DSYSCLK=40000000L -D_DISABLE_OPENADC10_CONFIGPORT_WARNING -MP -MMD -MF "${OBJECTDIR}/net/StackTsk.o.d" -o ${OBJECTDIR}/net/StackTsk.o net/StackTsk.c    -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/net/TCP.o: net/TCP.c  .generated_files/flags/default/723b6a79c32123a69100c44da09f853d5b269306 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/net" 
	@${RM} ${OBJECTDIR}/net/TCP.o.d 
	@${RM} ${OBJECTDIR}/net/TCP.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O1 -D_SUPPRESS_PLIB_WARNING -DSYSCLK=40000000L -D_DISABLE_OPENADC10_CONFIGPORT_WARNING -MP -MMD -MF "${OBJECTDIR}/net/TCP.o.d" -o ${OBJECTDIR}/net/TCP.o net/TCP.c    -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/net/Telnet.o: net/Telnet.c  .generated_files/flags/default/f7366dbc2f0e0ed9005bd0dcc9da0de7916d2f03 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/net" 
	@${RM} ${OBJECTDIR}/net/Telnet.o.d 
	@${RM} ${OBJECTDIR}/net/Telnet.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O1 -D_SUPPRESS_PLIB_WARNING -DSYSCLK=40000000L -D_DISABLE_OPENADC10_CONFIGPORT_WARNING -MP -MMD -MF "${OBJECTDIR}/net/Telnet.o.d" -o ${OBJECTDIR}/net/Telnet.o net/Telnet.c    -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/net/Tick.o: net/Tick.c  .generated_files/flags/default/78cf21ce79ad5e9673b174326a9997abecfa2e14 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/net" 
	@${RM} ${OBJECTDIR}/net/Tick.o.d 
	@${RM} ${OBJECTDIR}/net/Tick.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O1 -D_SUPPRESS_PLIB_WARNING -DSYSCLK=40000000L -D_DISABLE_OPENADC10_CONFIGPORT_WARNING -MP -MMD -MF "${OBJECTDIR}/net/Tick.o.d" -o ${OBJECTDIR}/net/Tick.o net/Tick.c    -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/net/UDP.o: net/UDP.c  .generated_files/flags/default/4488e82f7502dc71237fafaea7823ec079e0ebfc .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/net" 
	@${RM} ${OBJECTDIR}/net/UDP.o.d 
	@${RM} ${OBJECTDIR}/net/UDP.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O1 -D_SUPPRESS_PLIB_WARNING -DSYSCLK=40000000L -D_DISABLE_OPENADC10_CONFIGPORT_WARNING -MP -MMD -MF "${OBJECTDIR}/net/UDP.o.d" -o ${OBJECTDIR}/net/UDP.o net/UDP.c    -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/net/ZeroconfHelper.o: net/ZeroconfHelper.c  .generated_files/flags/default/68592365b5e7a61be1a2cdea02e6491413ba56b6 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/net" 
	@${RM} ${OBJECTDIR}/net/ZeroconfHelper.o.d 
	@${RM} ${OBJECTDIR}/net/ZeroconfHelper.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O1 -D_SUPPRESS_PLIB_WARNING -DSYSCLK=40000000L -D_DISABLE_OPENADC10_CONFIGPORT_WARNING -MP -MMD -MF "${OBJECTDIR}/net/ZeroconfHelper.o.d" -o ${OBJECTDIR}/net/ZeroconfHelper.o net/ZeroconfHelper.c    -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/net/ZeroconfLinkLocal.o: net/ZeroconfLinkLocal.c  .generated_files/flags/default/fc0fadbe159125aa57c29b84d5e9e8b72d478f35 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/net" 
	@${RM} ${OBJECTDIR}/net/ZeroconfLinkLocal.o.d 
	@${RM} ${OBJECTDIR}/net/ZeroconfLinkLocal.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O1 -D_SUPPRESS_PLIB_WARNING -DSYSCLK=40000000L -D_DISABLE_OPENADC10_CONFIGPORT_WARNING -MP -MMD -MF "${OBJECTDIR}/net/ZeroconfLinkLocal.o.d" -o ${OBJECTDIR}/net/ZeroconfLinkLocal.o net/ZeroconfLinkLocal.c    -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/net/ZeroconfMulticastDNS.o: net/ZeroconfMulticastDNS.c  .generated_files/flags/default/ffdbc4d6d3426b06a6c1d5b69ba8a448489d8cb9 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/net" 
	@${RM} ${OBJECTDIR}/net/ZeroconfMulticastDNS.o.d 
	@${RM} ${OBJECTDIR}/net/ZeroconfMulticastDNS.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O1 -D_SUPPRESS_PLIB_WARNING -DSYSCLK=40000000L -D_DISABLE_OPENADC10_CONFIGPORT_WARNING -MP -MMD -MF "${OBJECTDIR}/net/ZeroconfMulticastDNS.o.d" -o ${OBJECTDIR}/net/ZeroconfMulticastDNS.o net/ZeroconfMulticastDNS.c    -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/net/MQTT.o: net/MQTT.c  .generated_files/flags/default/c34afd0e95be9f9026252ee09e09ee09d9b45479 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/net" 
	@${RM} ${OBJECTDIR}/net/MQTT.o.d 
	@${RM} ${OBJECTDIR}/net/MQTT.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O1 -D_SUPPRESS_PLIB_WARNING -DSYSCLK=40000000L -D_DISABLE_OPENADC10_CONFIGPORT_WARNING -MP -MMD -MF "${OBJECTDIR}/net/MQTT.o.d" -o ${OBJECTDIR}/net/MQTT.o net/MQTT.c    -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/nvram/nvram.o: nvram/nvram.c  .generated_files/flags/default/cc7ae4d1610e39cb420cbeddb96c493b98f1a812 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/nvram" 
	@${RM} ${OBJECTDIR}/nvram/nvram.o.d 
	@${RM} ${OBJECTDIR}/nvram/nvram.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O1 -D_SUPPRESS_PLIB_WARNING -DSYSCLK=40000000L -D_DISABLE_OPENADC10_CONFIGPORT_WARNING -MP -MMD -MF "${OBJECTDIR}/nvram/nvram.o.d" -o ${OBJECTDIR}/nvram/nvram.o nvram/nvram.c    -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/time/time.o: time/time.c  .generated_files/flags/default/24e07294d601fedda99a3c3671fca106f2392ee9 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/time" 
	@${RM} ${OBJECTDIR}/time/time.o.d 
	@${RM} ${OBJECTDIR}/time/time.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O1 -D_SUPPRESS_PLIB_WARNING -DSYSCLK=40000000L -D_DISABLE_OPENADC10_CONFIGPORT_WARNING -MP -MMD -MF "${OBJECTDIR}/time/time.o.d" -o ${OBJECTDIR}/time/time.o time/time.c    -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/uart/uart.o: uart/uart.c  .generated_files/flags/default/cd33a94940e73110e2259f0525325c5349e342cf .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/uart" 
	@${RM} ${OBJECTDIR}/uart/uart.o.d 
	@${RM} ${OBJECTDIR}/uart/uart.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O1 -D_SUPPRESS_PLIB_WARNING -DSYSCLK=40000000L -D_DISABLE_OPENADC10_CONFIGPORT_WARNING -MP -MMD -MF "${OBJECTDIR}/uart/uart.o.d" -o ${OBJECTDIR}/uart/uart.o uart/uart.c    -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/usb_host_msd/usb_config.o: usb_host_msd/usb_config.c  .generated_files/flags/default/e09c7b9f5739002fb2b134af6142577810bd0a8c .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/usb_host_msd" 
	@${RM} ${OBJECTDIR}/usb_host_msd/usb_config.o.d 
	@${RM} ${OBJECTDIR}/usb_host_msd/usb_config.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O1 -D_SUPPRESS_PLIB_WARNING -DSYSCLK=40000000L -D_DISABLE_OPENADC10_CONFIGPORT_WARNING -MP -MMD -MF "${OBJECTDIR}/usb_host_msd/usb_config.o.d" -o ${OBJECTDIR}/usb_host_msd/usb_config.o usb_host_msd/usb_config.c    -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/usb_host_msd/usb_host.o: usb_host_msd/usb_host.c  .generated_files/flags/default/d4986dc20ebf4ee9962df58167526566cddd9b43 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/usb_host_msd" 
	@${RM} ${OBJECTDIR}/usb_host_msd/usb_host.o.d 
	@${RM} ${OBJECTDIR}/usb_host_msd/usb_host.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O1 -D_SUPPRESS_PLIB_WARNING -DSYSCLK=40000000L -D_DISABLE_OPENADC10_CONFIGPORT_WARNING -MP -MMD -MF "${OBJECTDIR}/usb_host_msd/usb_host.o.d" -o ${OBJECTDIR}/usb_host_msd/usb_host.o usb_host_msd/usb_host.c    -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/usb_host_msd/usb_host_msd.o: usb_host_msd/usb_host_msd.c  .generated_files/flags/default/d95aa752a35aff4fc9969fd9235f2594b98d4c62 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/usb_host_msd" 
	@${RM} ${OBJECTDIR}/usb_host_msd/usb_host_msd.o.d 
	@${RM} ${OBJECTDIR}/usb_host_msd/usb_host_msd.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O1 -D_SUPPRESS_PLIB_WARNING -DSYSCLK=40000000L -D_DISABLE_OPENADC10_CONFIGPORT_WARNING -MP -MMD -MF "${OBJECTDIR}/usb_host_msd/usb_host_msd.o.d" -o ${OBJECTDIR}/usb_host_msd/usb_host_msd.o usb_host_msd/usb_host_msd.c    -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/usb_host_msd/usb_host_msd_scsi.o: usb_host_msd/usb_host_msd_scsi.c  .generated_files/flags/default/9d1b53f0b4c4bc004b0cdfb09b030f5d9af93c7b .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/usb_host_msd" 
	@${RM} ${OBJECTDIR}/usb_host_msd/usb_host_msd_scsi.o.d 
	@${RM} ${OBJECTDIR}/usb_host_msd/usb_host_msd_scsi.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O1 -D_SUPPRESS_PLIB_WARNING -DSYSCLK=40000000L -D_DISABLE_OPENADC10_CONFIGPORT_WARNING -MP -MMD -MF "${OBJECTDIR}/usb_host_msd/usb_host_msd_scsi.o.d" -o ${OBJECTDIR}/usb_host_msd/usb_host_msd_scsi.o usb_host_msd/usb_host_msd_scsi.c    -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/usb_host_msd/event.o: usb_host_msd/event.c  .generated_files/flags/default/b43604ce13d76688bfcfa1eabb9287cc32f29aba .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/usb_host_msd" 
	@${RM} ${OBJECTDIR}/usb_host_msd/event.o.d 
	@${RM} ${OBJECTDIR}/usb_host_msd/event.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O1 -D_SUPPRESS_PLIB_WARNING -DSYSCLK=40000000L -D_DISABLE_OPENADC10_CONFIGPORT_WARNING -MP -MMD -MF "${OBJECTDIR}/usb_host_msd/event.o.d" -o ${OBJECTDIR}/usb_host_msd/event.o usb_host_msd/event.c    -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/main.o: main.c  .generated_files/flags/default/56983acb2c28e2d8f26c7944096522e147eed4b4 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/main.o.d 
	@${RM} ${OBJECTDIR}/main.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O1 -D_SUPPRESS_PLIB_WARNING -DSYSCLK=40000000L -D_DISABLE_OPENADC10_CONFIGPORT_WARNING -MP -MMD -MF "${OBJECTDIR}/main.o.d" -o ${OBJECTDIR}/main.o main.c    -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/common.o: common.c  .generated_files/flags/default/8ab03f1b0ac3d4ec6f887f1bdd1449230206c9e4 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/common.o.d 
	@${RM} ${OBJECTDIR}/common.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O1 -D_SUPPRESS_PLIB_WARNING -DSYSCLK=40000000L -D_DISABLE_OPENADC10_CONFIGPORT_WARNING -MP -MMD -MF "${OBJECTDIR}/common.o.d" -o ${OBJECTDIR}/common.o common.c    -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: compileCPP
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
else
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: link
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
${DISTDIR}/code.${IMAGE_TYPE}.${OUTPUT_SUFFIX}: ${OBJECTFILES}  nbproject/Makefile-${CND_CONF}.mk    
	@${MKDIR} ${DISTDIR} 
	${MP_CC} $(MP_EXTRA_LD_PRE) -g   -mprocessor=$(MP_PROCESSOR_OPTION)  -o ${DISTDIR}/code.${IMAGE_TYPE}.${OUTPUT_SUFFIX} ${OBJECTFILES_QUOTED_IF_SPACED}          -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)      -Wl,--defsym=__MPLAB_BUILD=1$(MP_EXTRA_LD_POST)$(MP_LINKER_FILE_OPTION),--defsym=__MPLAB_DEBUG=1,--defsym=__DEBUG=1,-D=__DEBUG_D,--defsym=_min_heap_size=2048,--no-code-in-dinit,--no-dinit-in-serial-mem,-Map="${DISTDIR}/${PROJECTNAME}.${IMAGE_TYPE}.map",--memorysummary,${DISTDIR}/memoryfile.xml -mdfp="${DFP_DIR}"
	
else
${DISTDIR}/code.${IMAGE_TYPE}.${OUTPUT_SUFFIX}: ${OBJECTFILES}  nbproject/Makefile-${CND_CONF}.mk   
	@${MKDIR} ${DISTDIR} 
	${MP_CC} $(MP_EXTRA_LD_PRE)  -mprocessor=$(MP_PROCESSOR_OPTION)  -o ${DISTDIR}/code.${IMAGE_TYPE}.${DEBUGGABLE_SUFFIX} ${OBJECTFILES_QUOTED_IF_SPACED}          -DXPRJ_default=$(CND_CONF)  -no-legacy-libc  $(COMPARISON_BUILD)  -Wl,--defsym=__MPLAB_BUILD=1$(MP_EXTRA_LD_POST)$(MP_LINKER_FILE_OPTION),--defsym=_min_heap_size=2048,--no-code-in-dinit,--no-dinit-in-serial-mem,-Map="${DISTDIR}/${PROJECTNAME}.${IMAGE_TYPE}.map",--memorysummary,${DISTDIR}/memoryfile.xml -mdfp="${DFP_DIR}"
	${MP_CC_DIR}/xc32-bin2hex ${DISTDIR}/code.${IMAGE_TYPE}.${DEBUGGABLE_SUFFIX} 
endif


# Subprojects
.build-subprojects:


# Subprojects
.clean-subprojects:

# Clean Targets
.clean-conf: ${CLEAN_SUBPROJECTS}
	${RM} -r ${OBJECTDIR}
	${RM} -r ${DISTDIR}

# Enable dependency checking
.dep.inc: .depcheck-impl

DEPFILES=$(wildcard ${POSSIBLE_DEPFILES})
ifneq (${DEPFILES},)
include ${DEPFILES}
endif
