# Hassio AVRDUDE

It's an add-on for those who:
* installed Hassio https://www.home-assistant.io/hassio/installation/ on Raspberry Pi (or compatible)
* connected Arduino (or many other microcontrollers supported by AVRDUDE http://savannah.nongnu.org/projects/avrdude) to RPi via USB
* wants to reflash Arduino on the air.

The task can be divided into stages:
* on "big PC" compile source code, for example using Arduino IDE
* transfer compiled binary hex-file to Rpi
* run the add-on and Arduino will start in seconds the updated program.

Of cource, You have to read "Tutorial: Making your first add-on" from https://developers.home-assistant.io/docs/en/hassio_addon_tutorial.html

## Compilation
There are several compilers, but the most common is probably the Arduino IDE. It is assumed that there is no problem with local sketch filling, when Arduino connected to "big PC". `Arduino IDE` also uses `avrdude` - lets go to menu "File/Preferences" and set check-box "Show verbose output during upload". 

Now there is in the log important info about command line arguments for your Arduino device like:
`/app/Arduino/hardware/tools/avr/bin/avrdude -C/app/Arduino/hardware/tools/avr/etc/avrdude.conf -v -patmega328p -carduino -P/dev/ttyUSB0 -b57600 -D -Uflash:w:/tmp/arduino_build_486540/Blink.ino.hex:i`
Therefore for docker on RPi command line will be `avrdude -v -patmega328p -carduino -P/dev/ttyUSB0 -b57600 -D -Uflash:w:/firmware.ino.hex:i`, where `firmware.ino.hex` is the name of sketch file.

You can get the sketch file with menu `Sketch/Export compiled binary Ctrl+Alt+S` - will create 2 files, you need a smaller size, without bootloader.

## Transfer
I decided not to give an example of moving a file to raspberries, since there are a lot of them. Simply transfer your '.hex' instead sample and run once the addon.
