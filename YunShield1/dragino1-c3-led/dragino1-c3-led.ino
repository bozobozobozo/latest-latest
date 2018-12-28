#include <Bridge.h>
#include <YunServer.h>
#include <YunClient.h>

int LEDPIN = 13; // your LED PIN
YunServer server;

void setup() {
  // Start our connection
  Serial.begin(9600);
  pinMode(LEDPIN,OUTPUT);
  
  pinMode(3,OUTPUT);
  pinMode(2,OUTPUT);
  pinMode(4,OUTPUT);
  pinMode(6,OUTPUT);
  
  digitalWrite(LEDPIN,HIGH); // turn on Led while connecting
  Bridge.begin();  

  // Show a fancy flash pattern once connected
  digitalWrite(3,LOW); 
  delay(150);
  digitalWrite(3,HIGH); 
  delay(150);
  digitalWrite(2,LOW); 
  delay(150);
  digitalWrite(2,HIGH); 
  delay(150);
  digitalWrite(4,LOW); 
  delay(150);
  digitalWrite(4,HIGH); 
  delay(150);
  digitalWrite(6,LOW); 
  delay(150);
  digitalWrite(6,HIGH); 
  delay(150);
  
  
  //bjs
  
  digitalWrite(3,LOW); 
  delay(150);
  digitalWrite(3,HIGH); 
  delay(150);
  digitalWrite(3,LOW); 
  delay(150);
  digitalWrite(LEDPIN,HIGH); 
  delay(150);
  digitalWrite(3,LOW); 
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
}

void process(YunClient client) {
  // Collect user commands
  String command = client.readStringUntil('^^'); // load whole string
  
  // Enable HTML
  client.println("Status: 200");
  client.println("Content-type: text/html");
  client.println();
  
  // Show UI  ********* REMEMBER REVERSE LOGIC FOR ON/OFF LEDs ******************
  client.println("<B><Center>");
  client.println("<a href='http://192.168.1.107/arduino/on^^'>Turn OFF LED 3</a><br>");
  client.println("<a href='http://192.168.1.107/arduino/off^^'>Turn ON LED 3</a><br>");
  client.println("<a href='http://192.168.1.107/arduino/on10^^'>Flash LEDs</a><br>");
  client.println("<a href='http://192.168.1.107/arduino/step^^'>Step Sequence</a><br>");
  client.println("<a href='http://192.168.1.107/arduino/back^^'>Reverse Step Sequence</a><br>");
  client.println("<a href='http://192.168.1.107/arduino/stop^^'>Turn Off all LEDs</a><br>");
  client.print("Command: ");
  client.println(command);
  client.println("</B></Center>");
  //digitalWrite(13,HIGH); //bjs
  // Check what the user entered ...
  
  // Turn on
  if (command == "on") {
    //bjs
     //digitalWrite(LEDPIN,HIGH); 
     digitalWrite(6,HIGH);
     client.println(command);
  }
  
  // Turn off
  if (command == "off") {
    //digitalWrite(LEDPIN,LOW);
    digitalWrite(6,LOW);
    client.println(command);
  }
  
  if (command == "on10") {
  
  digitalWrite(3,LOW); 
  delay(150);
  digitalWrite(3,HIGH); 
  delay(150);
  digitalWrite(2,LOW); 
  delay(150);
  digitalWrite(2,HIGH); 
  delay(150);
  digitalWrite(4,LOW); 
  delay(150);
  digitalWrite(4,HIGH); 
  delay(150);
  digitalWrite(6,LOW); 
  delay(150);
  digitalWrite(6,HIGH); 
  delay(150);
  digitalWrite(3,LOW); 
  delay(150);
  digitalWrite(3,HIGH); 
  delay(150);
  digitalWrite(2,LOW); 
  delay(150);
  digitalWrite(2,HIGH); 
  delay(150);
  digitalWrite(4,LOW); 
  delay(150);
  digitalWrite(4,HIGH); 
  delay(150);
  digitalWrite(6,LOW); 
  delay(150);
  digitalWrite(6,HIGH); 
   
  
  client.println(command);
  }
  
  // stepper sequence
  if (command == "step") 
  {
    // loop thru LEDs from 8 to 11 -- 10 times:
   for (int step = 4; step >= 1; step--)
   {    
    digitalWrite(3,LOW);
    delay(150); 
    digitalWrite(3,HIGH);
    delay(150); 
    digitalWrite(2,LOW);
    delay(150); 
    digitalWrite(2,HIGH);
    delay(150); 
    digitalWrite(4,LOW);
    delay(150); 
    digitalWrite(4,HIGH);
    delay(150); 
    digitalWrite(6,LOW);
    delay(150); 
    digitalWrite(6,HIGH);
    
   } // end for loop
       
    client.println(command);
  }
  
 // reverse stepper sequence
  if (command == "back") 
  {
    // loop thru LEDs from 11 to 8 -- 4 times:
   for (int step = 4; step >= 1; step--)
   {    
    digitalWrite(6,LOW);
    delay(150); 
    digitalWrite(6,HIGH);
    delay(150); 
    digitalWrite(4,LOW);
    delay(150); 
    digitalWrite(4,HIGH);
    delay(150); 
    digitalWrite(2,LOW);
    delay(150); 
    digitalWrite(2,HIGH);
    delay(150); 
    digitalWrite(3,LOW);
    delay(150); 
    digitalWrite(3,HIGH);
    
   } // end for loop
       
    client.println(command);
  }
 // stop sequence ???
  if (command == "stop") {
    //bjs
     // new digitalWrite(LEDPIN,LOW); 
     digitalWrite(3,HIGH);
     digitalWrite(2,HIGH);
     digitalWrite(4,HIGH);
     digitalWrite(6,HIGH);
     
     client.println(command);
  }  
}
