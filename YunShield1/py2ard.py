#!/usr/bin/python 

# Test to (un)set pin 8 and 9 on the Iduino.
# bjs 2016
 
import sys
sys.path.insert(0, '/usr/lib/python2.7/bridge')
 
from time import sleep
 
from bridgeclient import BridgeClient as bridgeclient
value = bridgeclient()
 
for idx in range(0, 100):
    value.put('D12','0')
    value.put('D13','1')
    sleep(0.1)
    value.put('D12','1')
    value.put('D13','0')
    sleep(0.1)
 
print("I hope you enjoyed the light show\n")