#include <Bridge.h>
#include <YunServer.h>
#include <YunClient.h>

int LEDPIN = 8; // your LED PIN
YunServer server;

void setup() {
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
  client.println("<a href='http://192.168.1.117/arduino/on^^'>Turn ON LED</a><br>");
  client.println("<a href='http://192.168.1.117/arduino/off^^'>Turn OFF LED</a><br>");
  client.println("<a href='http://192.168.1.117/arduino/on10^^'>Turn ON 10 PB2</a><br>");
  client.println("<a href='http://192.168.1.117/arduino/step^^'>Step Seq.</a><br>");
  client.println("<a href='http://192.168.1.117/arduino/back^^'>Rev. Step Seq.</a><br>");
  client.println("<a href='http://192.168.1.117/arduino/stop^^'>Turn Off All LEDs</a><br>");
  
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
