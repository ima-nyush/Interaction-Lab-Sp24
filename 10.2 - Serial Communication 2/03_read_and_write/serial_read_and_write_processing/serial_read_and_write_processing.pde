import processing.serial.*;

Serial serialPort;
String myString;

int NUM_OF_VALUES_FROM_PROCESSING = 2;  /** YOU MUST CHANGE THIS ACCORDING TO YOUR PROJECT **/
int processing_values[] = new int[NUM_OF_VALUES_FROM_PROCESSING]; /** this array stores values you might want to send to Arduino **/

int NUM_OF_VALUES_FROM_ARDUINO = 2;  /** YOU MUST CHANGE THIS ACCORDING TO YOUR PROJECT **/
int sensorValues[] = new int[NUM_OF_VALUES_FROM_ARDUINO]; /** this array stores values from Arduino **/


void setup() {
  size(500, 500);

  printArray(Serial.list());
  // put the name of the serial port your Arduino is connected
  // to in the line below - this should be the same as you're
  // using in the "Port" menu in the Arduino IDE
  serialPort = new Serial(this, "/dev/cu.usbmodem1101", 9600);
}


void draw() {
  background(0);

  //receive the values from Arduino
  getSerialData();

  //use the values from arduino
  
   //sensorValues[0] are the values from the potentiometer
  float r = map(sensorValues[0], 0, 1023, 0, width);
  circle(width/2, height/2, r);
  //sensorValues[1] are the values from the button
  if (sensorValues[1] == 1) {
    fill(random(255), random(255), random(255));
  }
 

  // give values to the variables you want to send to arduino
  //change the code according to your project
  if (mousePressed) {
    processing_values[0] = 1;
  } else {
    processing_values[0] = 0;
  }
  processing_values[1] = int(map(mouseX, 0, width, 0, 180));

    // send the values to Arduino.
    sendSerialData();
}



// the helper function below receives the values from arduino
// in the "sensorValues" array from a connected Arduino
// running the "Serial_AtoP" sketch

void getSerialData() {
  while (serialPort.available() > 0) {
    myString = serialPort.readStringUntil( 10 ); // 10 = '\n'  Linefeed in ASCII
    if (myString != null) {
      print("from arduino: "+ myString);
      String[] serialInArray = split(trim(myString), ",");
      if (serialInArray.length == NUM_OF_VALUES_FROM_ARDUINO) {
        for (int i=0; i<serialInArray.length; i++) {
          sensorValues[i] = int(serialInArray[i]);
        }
      }
    }
  }
}

// the helper function below sends the variables
// in the "processing_values" array to a connected Arduino
// running the "Serial_PtoA" sketch

void sendSerialData() {
  String data = "";
  for (int i=0; i<processing_values.length; i++) {
    data += processing_values[i];
    //if i is less than the index number of the last element in the values array
    if (i < processing_values.length-1) {
      data += ","; // add splitter character "," between each values element
    }
    //if it is the last element in the values array
    else {
      data += "\n"; // add the end of data character "n"
    }
  }
  //write to Arduino
  serialPort.write(data);
  print("to arduino: "+ data); // this prints to the console the values going to arduino
}
