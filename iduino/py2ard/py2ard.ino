// Arduino Yun listens to python script via Bridge library to turn digital pins on/off.
// H.Zimmerman, 9-12-2014.
// Arduino Yun.
 
#include <Bridge.h>
#include <stdio.h>
 
// Here we will hold the values coming from Python via Bridge.
char D12value[2];
char D13value[2];
 
void setup() {
  // Zero out the memory we're using for the Bridge.
  memset(D12value, 0, 2);
  memset(D13value, 0, 2);
   
  // Initialize digital pins 12 and 13 as output.
  pinMode(8, OUTPUT); 
  pinMode(9, OUTPUT); 
 
  // Start using the Bridge.
  Bridge.begin();
}
 
void loop() {
  // Write current value of D12 to the pin (basically turning it on or off).
  Bridge.get("D12", D12value, 2);
  int D12int = atoi(D12value);
  digitalWrite(8, D12int);
   
  // An arbitrary amount of delay to make the whole thing more reliable. YMMV
  delay(10);
   
  // Write current value of D13 to the pin (basically turning it on or off).
  Bridge.get("D13", D13value, 2);
  int D13int = atoi(D13value);
  digitalWrite(9, D13int);
   
  // An arbitrary amount of delay to make the whole thing more reliable. YMMV
  delay(10);  
}
