# Hassio AVRDUDE

It's an add-on for those who:
* installed Hassio https://www.home-assistant.io/hassio/installation/ on Raspberry Pi (or compatible)
* connected Arduino (or many other microcontrollers supported by AVRDUDE http://savannah.nongnu.org/projects/avrdude) to RPi via USB
* wants to reflash Arduino on the air.

The task can be divided into stages:
* on "big PC" compile source code, for example using Arduino IDE
* transfer compiled binary hex-file to Rpi
* install and run the add-on and Arduino will start in seconds the updated program.

Of cource, You have to read "Tutorial: Making your first add-on" from https://developers.home-assistant.io/docs/en/hassio_addon_tutorial.html

## Compilation
There are several compilers, but the most common is probably the Arduino IDE. It is assumed that there is no problem with local sketch filling, when Arduino connected to "big PC". `Arduino IDE` also uses `avrdude` - lets go to menu "File/Preferences" and set check-box "Show verbose output during upload". 

Now there is in the log important info about command line arguments for your Arduino device like:
`/app/Arduino/hardware/tools/avr/bin/avrdude -C/app/Arduino/hardware/tools/avr/etc/avrdude.conf -v -patmega328p -carduino -P/dev/ttyUSB0 -b57600 -D -Uflash:w:/tmp/arduino_build_486540/Blink.ino.hex:i`
Therefore for docker on RPi command line will be `avrdude -v -patmega328p -carduino -P/dev/ttyUSB0 -b57600 -D -Uflash:w:/firmware.ino.hex:i`, where `firmware.ino.hex` is the name of sketch file.

You can get the sketch file with menu `Sketch/Export compiled binary Ctrl+Alt+S` - will create 2 files, you need a smaller size, without bootloader.

There is `fastblink.ino.hex`. It is standart `Blink` example with `delay(100)`.

## Transfer
First of all, the addon is trying to execute the file download command, by default:
`wget -O /firmware.ino.hex https://github.com/ArtHome12/hassio_avrdude/blob/master/fastblink.ino.hex` - download file from URL and save/rewrite it under a new name `/firmware.ino.hex`.

Keep in mind the following:
1. Just updating (manually) the file in directory of addon is not enough, you need to update the version and after that update the addon, so it’s more convenient to upload a new firmware somewhere so that the addon picks it up.
2. Github is not really serving binary files out of repositories properly. Use `release` page or other hostings.

## Flash
After downloading, the firmware is updated and there should be something like this in the add-on log:

```
Downloading the update
Connecting to github.com (52.74.223.119:443)
Connecting to github-production-release-asset-2e65be.s3.amazonaws.com (52.216.171.19:443)
 
firmware.ino.hex     100% |********************************|  2619  0:00:00 ETA
avrdude: Version 6.3, compiled on May  9 2019 at 14:27:38
         Copyright (c) 2000-2005 Brian Dean, http://www.bdmicro.com/
         Copyright (c) 2007-2014 Joerg Wunsch
         System wide configuration file is "/etc/avrdude.conf"
         User configuration file is "/root/.avrduderc"
         User configuration file does not exist or is not a regular file, skipping
         Using Port                    : /dev/ttyUSB0
         Using Programmer              : arduino
         Overriding Baud Rate          : 57600
         AVR Part                      : ATmega328P
         Chip Erase delay              : 9000 us
         PAGEL                         : PD7
         BS2                           : PC2
         RESET disposition             : dedicated
         RETRY pulse                   : SCK
         serial program mode           : yes
         parallel program mode         : yes
         Timeout                       : 200
         StabDelay                     : 100
         CmdexeDelay                   : 25
         SyncLoops                     : 32
         ByteDelay                     : 0
         PollIndex                     : 3
         PollValue                     : 0x53
         Memory Detail                 :
                                  Block Poll               Page                       Polled
           Memory Type Mode Delay Size  Indx Paged  Size   Size #Pages MinW  MaxW   ReadBack
           ----------- ---- ----- ----- ---- ------ ------ ---- ------ ----- ----- ---------
           eeprom        65    20     4    0 no       1024    4      0  3600  3600 0xff 0xff
           flash         65     6   128    0 yes     32768  128    256  4500  4500 0xff 0xff
           lfuse          0     0     0    0 no          1    0      0  4500  4500 0x00 0x00
           hfuse          0     0     0    0 no          1    0      0  4500  4500 0x00 0x00
           efuse          0     0     0    0 no          1    0      0  4500  4500 0x00 0x00
           lock           0     0     0    0 no          1    0      0  4500  4500 0x00 0x00
           calibration    0     0     0    0 no          1    0      0     0     0 0x00 0x00
           signature      0     0     0    0 no          3    0      0     0     0 0x00 0x00
         Programmer Type : Arduino
         Description     : Arduino
         Hardware Version: 2
         Firmware Version: 1.16
         Vtarget         : 0.0 V
         Varef           : 0.0 V
         Oscillator      : Off
         SCK period      : 0.1 us
avrdude: AVR device initialized and ready to accept instructions
Reading | ################################################## | 100% 0.00s
avrdude: Device signature = 0x1e950f (probably m328p)
avrdude: reading input file "/firmware.ino.hex"
avrdude: writing flash (926 bytes):
Writing | ################################################## | 100% 0.31s
avrdude: 926 bytes of flash written
avrdude: verifying flash memory against /firmware.ino.hex:
avrdude: load data flash data from input file /firmware.ino.hex:
avrdude: input file /firmware.ino.hex contains 926 bytes
avrdude: reading on-chip flash data:
Reading | ################################################## | 100% 0.24s
avrdude: verifying ...
avrdude: 926 bytes of flash verified
avrdude done.  Thank you.
``````
Now your Arduino executes a new code!
