# EtherGeiger

## Overview

This is firmware for Ethergeiger project, described on my [Hackaday.io profile](https://hackaday.io/project/163717-ethergeiger-20).

## Required Tools

Project was created in Microchip MPLAB X IDE.
It uses legacy plib.h (https://www.microchip.com/SWLibraryWeb/product.aspx?product=PIC32%20Peripheral%20Library) and MLA libraries (https://www.microchip.com/en-us/tools-resources/develop/libraries/microchip-libraries-for-applications).
You need to use older version of XC32 compiler to build this project (tested with v2.40). Attempt to build it with never version (like 4.xx) leads linker issues.
