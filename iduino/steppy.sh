#!/bin/sh
#/etc/init.d/mjpg-streamer start  

sleep 2

curl http://localhost/arduino/step^^ 
curl http://localhost/arduino/on^^
curl http://localhost/arduino/off^^
curl http://localhost/arduino/on^^
curl http://localhost/arduino/off^^
curl http://localhost/arduino/on^^
curl http://localhost/arduino/off^^
curl http://localhost/arduino/stop^^

python py2ard.py