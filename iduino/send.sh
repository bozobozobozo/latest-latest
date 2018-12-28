#!/bin/sh
#mv -f "$1"  '/www/video0.jpg' 
/etc/init.d/mjpg-streamer start  

sleep 2

wget http://localhost:8080/?action=snapshot -O output.jpg
python emailarg.py output.jpg   

sleep 5  # Waits 5 seconds.
wget http://localhost:8080/?action=snapshot -O output.jpg
python emailarg.py output.jpg  

sleep 5  # Waits 5 seconds.
wget http://localhost:8080/?action=snapshot -O output.jpg
python emailarg.py output.jpg 

/etc/init.d/mjpg-streamer stop