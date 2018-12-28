@echo off
cls
:start


curl http://192.168.1.118/arduino/on^^
SLEEP 1
curl http://192.168.1.118/arduino/off^^
SLEEP 1
curl http://192.168.1.118/arduino/on^^
SLEEP 1
curl http://192.168.1.118/arduino/off^^
SLEEP 1

REM  * "/arduino/digital/13"     -> digitalRead(13)
REM  * "/arduino/digital/13/1"   -> digitalWrite(13, HIGH)
REM  * "/arduino/analog/2/123"   -> analogWrite(2, 123)
REM  * "/arduino/analog/2"       -> analogRead(2)
REM  * "/arduino/mode/13/input"  -> pinMode(13, INPUT)
REM  * "/arduino/mode/13/output" -> pinMode(13, OUTPUT)


goto start
