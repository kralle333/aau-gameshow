int sensorPin0 = 0;    // select the input pin for the potentiometer
int sensorValue0 = 0;  // variable to store the value coming from the sensor
int low0 = 0;          // variable to keep track of rising or falling edge of sensorvalue
int counter0 = 0;
int sensorPin1 = 1;    // select the input pin for the potentiometer
int sensorValue1 = 0;  // variable to store the value coming from the sensor
int low1 = 0;          // variable to keep track of rising or falling edge of sensorvalue
int counter1 = 0;
int sendout0 = 0;
int sendout1 = 0;

void setup() {
  Serial.begin(9600); 
}

void loop() {
  sensorValue0 = analogRead(sensorPin0);
  sensorValue1 = analogRead(sensorPin1);
  
  if(sensorValue0 > 400) {
    low0 = 0; 
  }
  if(sensorValue0 < 400 && low0 == 0) {zzzzzzzz
    sendout0 = 1;
    low0 = 1;
  }
  
  if(sensorValue1 > 400) {
    low1 = 0; 
  }
  if(sensorValue1 < 400 && low1 == 0) {
    
    sendout1 = 1;
    low1 = 1;
  } 
  
  if(sendout0 == 1 || sendout1 == 1) {
   if(sendout0 == 1) {
    Serial.print('B', BYTE);
   } else {
    Serial.print('A', BYTE);
   } 
   if(sendout1 == 1) {
    Serial.print('Y', BYTE);
   } else {
    Serial.print('X', BYTE);
   }
   sendout0 = 0;
   sendout1 = 0;
  }
  
  
  /*if(sensorValue0 > 400){
    low0 = 0;
  }
  if(low0 == 0){
    if(sensorValue0 < 400){
      //counter0++;
      //if(counter0 == 2){
        Serial.print('B', BYTE);
        low0 = 1;
        //counter0 = 0;
      //}
    }
  }
  
  //
  

  //if(sensorValue0 > 400){
  //  low1 = 0;
  //}
  //if(low1 == 0){  
  //  if(sensorValue1 < 400){
  //    counter1++;
  //    if(counter1 == 2){
  //      Serial.print('Y', BYTE);
  //      low1 = 1;
  //      counter1 = 0;
  //    }
  //  }
  //}
  */
  delay(15);
}
