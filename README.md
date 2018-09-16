# Hassio AVRDUDE

It's an add-on for those who:
* installed Hassio https://www.home-assistant.io/hassio/installation/ on Raspberry Pi (or compatible)
* connected Arduino (or many other microcontrollers supported by AVRDUDE http://savannah.nongnu.org/projects/avrdude) to RPi via USB
* wants to reflash Arduino on the air.

The task can be divided into stages:
* on "big PC" compile source code, for example using Arduino IDE
* transfer compiled binary hex-file to Rpi
* run the add-on and Arduino will start in seconds the updated program.

## Compilation
There are several compilers, but the most common is probably the Arduino IDE. It is assumed that there is no problem with local sketch filling, when Arduino connected to "big PC". Arduino also uses avrdude - lets go to menu "File/Preferences" and set check-box "Show verbose output during upload". 
