import processing.serial.*;

Serial serialPort;
String myString;

int NUM_OF_VALUES_FROM_ARDUINO = 2;   /** YOU MUST CHANGE THIS ACCORDING TO YOUR PROJECT **/
int sensorValues[] = new int[NUM_OF_VALUES_FROM_ARDUINO];
   /** this array stores values from Arduino **/


void setup() {
  size(500, 500);
  background(0);

  printArray(Serial.list());
  // put the name of the serial port your Arduino is connected
  // to in the line below - this should be the same as you're
  // using in the "Port" menu in the Arduino IDE
  serialPort = new Serial(this, "/dev/cu.usbmodem1101", 9600);
}

void draw() {
  getSerialData();
  printArray(sensorValues);
  background(0);
  stroke(255);
  fill(255);

  // use the values like this:
  float x = map(sensorValues[0], 0, 1023, 0, width);
  float y = map(sensorValues[1], 0, 1023, 0, height);
  
  rectMode(CENTER);
  rect(width/2, height/2, x, y);
}


// the helper function below receives the values from arduino
// in the "sensorValues" array from a connected Arduino
// running the "Serial_AtoP" sketch

void getSerialData() {
  while (serialPort.available() > 0) {
    myString = serialPort.readStringUntil( 10 ); // 10 = '\n'  Linefeed in ASCII
    if (myString != null) {
      String[] serialInArray = split(trim(myString), ",");
      if (serialInArray.length == NUM_OF_VALUES_FROM_ARDUINO) {
        for (int i=0; i<serialInArray.length; i++) {
          sensorValues[i] = int(serialInArray[i]);
        }
      }
    }
  }
}
