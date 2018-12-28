#include <Bridge.h>
#include <YunServer.h>
#include <YunClient.h>
#include <stdio.h>

int LEDPIN = 8; // your LED PIN

// Here we will hold the values coming from Python via Bridge.
char D12value[2];
char D13value[2];

YunServer server;

void setup() {

 // Zero out the memory we're using for the Bridge.
 memset(D12value, 0, 2);
 memset(D13value, 0, 2);
 
  // Start our connection
  Serial.begin(9600);
  pinMode(LEDPIN,OUTPUT);
  
  pinMode(8,OUTPUT);
  pinMode(9,OUTPUT);
  pinMode(10,OUTPUT);
  pinMode(11,OUTPUT);
  
  digitalWrite(LEDPIN,HIGH); // turn on Led while connecting
  
  Bridge.begin();  

  // Show a fancy flash pattern once connected
  digitalWrite(8,LOW); 
  delay(150);
  digitalWrite(8,HIGH); 
  delay(150);
  digitalWrite(9,LOW); 
  delay(150);
  digitalWrite(9,HIGH); 
  delay(150);
  digitalWrite(10,LOW); 
  delay(150);
  digitalWrite(10,HIGH); 
  delay(150);
  digitalWrite(11,LOW); 
  delay(150);
  digitalWrite(11,HIGH); 
  delay(150);
  
  
  //bjs
  
  digitalWrite(LEDPIN,LOW); 
  delay(150);
  digitalWrite(LEDPIN,HIGH); 
  delay(150);
  digitalWrite(LEDPIN,LOW); 
  delay(150);
  digitalWrite(LEDPIN,HIGH); 
  delay(150);
  digitalWrite(LEDPIN,LOW); 
  delay(150);
  
  // Disable for some connections:
  // Start listening for connections  
  
  // server.listenOnLocalhost();
  
 server.listenOnLocalhost(); //bjs
  server.begin();
 
}

void loop() {
  // Listen for clients
  YunClient client = server.accept();
  // Client exists?
  if (client) {
    // Lets process the request!
    process(client);
    client.stop();
  }
  delay(100);

// Process name/value pairs coming from Linux
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

void process(YunClient client) {
  // Collect user commands
  String command = client.readStringUntil('^^'); // load whole string
  
  // Enable HTML
  client.println("Status: 200");
  client.println("Content-type: text/html");
  client.println();
  
  // Show UI
  client.println("<B><Center>");
  client.println("<a href='http://192.168.1.120/arduino/on^^'>Turn ON LED</a><br>");
  client.println("<a href='http://192.168.1.120/arduino/off^^'>Turn OFF LED</a><br>");
  client.println("<a href='http://192.168.1.120/arduino/on10^^'>Turn ON 10 PB2</a><br>");
  client.println("<a href='http://192.168.1.120/arduino/step^^'>Step Seq.</a><br>");
  client.println("<a href='http://192.168.1.120/arduino/back^^'>Rev. Step Seq.</a><br>");
  client.println("<a href='http://192.168.1.120/arduino/stop^^'>Turn Off All LEDs</a><br>");
  
  client.print("Command: ");
  client.println(command);
  client.println("</B></Center>");
  //digitalWrite(13,HIGH); //bjs
  // Check what the user entered ...
  
  // Turn on
  if (command == "on") {
    //bjs
     digitalWrite(LEDPIN,HIGH); 
     client.println(command);
  }
  
  // Turn off
  if (command == "off") {
    digitalWrite(LEDPIN,LOW);
    client.println(command);
  }
  
  if (command == "on10") {
  
  digitalWrite(10,LOW); 
  delay(150);
  digitalWrite(10,HIGH); 
  delay(150);
  digitalWrite(10,LOW); 
  delay(150);
  digitalWrite(10,HIGH); 
  delay(150);
  digitalWrite(10,LOW); 
  delay(150);
  digitalWrite(10,HIGH); 
  delay(150);
  digitalWrite(10,LOW); 
  delay(150);
  digitalWrite(10,HIGH); 
  delay(150);
  digitalWrite(10,LOW); 
  delay(150);
  digitalWrite(10,HIGH); 
  delay(150);
  digitalWrite(10,LOW); 
  delay(150);
  digitalWrite(10,HIGH); 
  delay(150);
  digitalWrite(10,LOW); 
  delay(150);
  digitalWrite(10,HIGH); 
  delay(150);
  digitalWrite(10,LOW); 
  delay(150);
  digitalWrite(10,HIGH); 
  delay(150); 
  digitalWrite(10,LOW); 
  delay(150);
  digitalWrite(10,HIGH); 
  
  client.println(command);
  }
  
  // stepper sequence
  if (command == "step") 
  {
    // loop thru LEDs from 8 to 11 -- 4 times:
   for (int step = 4; step >= 1; step--)
   {    
    digitalWrite(8,LOW);
    delay(150); 
    digitalWrite(8,HIGH);
    delay(150); 
    digitalWrite(9,LOW);
    delay(150); 
    digitalWrite(9,HIGH);
    delay(150); 
    digitalWrite(10,LOW);
    delay(150); 
    digitalWrite(10,HIGH);
    delay(150); 
    digitalWrite(11,LOW);
    delay(150); 
    digitalWrite(11,HIGH);
    
   } // end for loop
       
    client.println(command);
  }
  // reverse stepper sequence
  if (command == "back") 
  {
    // loop thru LEDs from 11 to 8 -- 4 times:
   for (int step = 4; step >= 1; step--)
   {    
    digitalWrite(11,LOW);
    delay(150); 
    digitalWrite(11,HIGH);
    delay(150); 
    digitalWrite(10,LOW);
    delay(150); 
    digitalWrite(10,HIGH);
    delay(150); 
    digitalWrite(9,LOW);
    delay(150); 
    digitalWrite(9,HIGH);
    delay(150); 
    digitalWrite(8,LOW);
    delay(150); 
    digitalWrite(8,HIGH);
    
   } // end for loop
       
    client.println(command);
  }
 // stop sequence ???
  if (command == "stop") {
    //bjs
     // new digitalWrite(LEDPIN,LOW); 
     digitalWrite(8,LOW);
     digitalWrite(9,LOW);
     digitalWrite(10,LOW);
     digitalWrite(11,LOW);
     
     client.println(command);
  }  
}
