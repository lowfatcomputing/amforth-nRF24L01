nRF24L01 library for amforth
============================

A WIP library for the inexpensive nRF24L01 family of radios.


##installation

After installing amforth, upload the source file to two arduinos
with something like:

    python2.7 amforth-shell.py -p /dev/ttyUSB0 -s 9600 nrf24l01.frt


Try it out with:
    python2.7 amforth-shell.py -p /dev/ttyUSB0 -s 9600 examples/00_Transmit.frt -i
    python2.7 amforth-shell.py -p /dev/ttyUSB1 -s 9600 examples/01_Receive.frt -i


Enjoy!
