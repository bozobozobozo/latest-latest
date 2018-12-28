#!/bin/sh   
# LINUX script to run usb camera and email pics and flash
# LEDs on Arduino side. (uses both CURL and python JSON to invoke.)
# run  C2-3-Yun_LED_iduinoCurl+py.ino on Arduino side   
# bjs August 2016

/etc/init.d/mjpg-streamer start  

sleep 1

wget http://localhost:8080/?action=snapshot -O output.jpg
python emailarg.py output.jpg   

sleep 3  # Waits 3 seconds.
wget http://localhost:8080/?action=snapshot -O output.jpg
python emailarg.py output.jpg  

sleep 3  # Waits 3 seconds.
wget http://localhost:8080/?action=snapshot -O output.jpg
python emailarg.py output.jpg 

# flash LEDs on Arduino side using CURL and python JSON.
./steppy.sh 

/etc/init.d/mjpg-streamer stop