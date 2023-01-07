/* This is a code example for Processing, to be used on Recitation 7
  You need to have installed the SerialRecord library.
  
  Interaction Lab
  IMA NYU Shanghai
  2022 Fall
*/

import processing.serial.*;
import osteele.processing.SerialRecord.*;

Serial serialPort;
SerialRecord serialRecord;

int W;         //width of the tiles
int NUM = 60;  //amount of pixels
int[] r = new int[NUM]; //red of each tile
int[] g = new int[NUM]; //red of each tile
int[] b = new int[NUM]; //red of each tile

void setup() {
  size(600, 200);
  W = width/NUM;


  // You can use this syntax and change COM3 for your serial port
  // printArray(Serial.list());
  // serialPort = new Serial(this, "COM3", 9600);
  // in MacOS it looks like "/dev/cu.usbmodem1101"
  //or you can try to use this instead:
  
  String serialPortName = SerialUtils.findArduinoPort();
  serialPort = new Serial(this, serialPortName, 9600);
  serialRecord = new SerialRecord(this, serialPort, 4);
  serialRecord.logToCanvas(false);
  rectMode(CENTER);
}

void draw() {
  background(0);
  for (int i=0; i<NUM; i ++) {
    fill(r[i], g[i], b[i]);
    rect(i * W + W/2, height/2, 10, 10);
  }

 if (mousePressed == true) {
    int n = floor(constrain(mouseX/W , 0, NUM-1));

    r[n] = floor(random(255));
    g[n] = floor(random(255));
    b[n] = floor(random(255));

    serialRecord.values[0] = n;     // which pixel we change (0-59)
    serialRecord.values[1] = r[n];  // how much red (0-255)
    serialRecord.values[2] = g[n];  // how much green (0-255)
    serialRecord.values[3] = b[n];  // how much blue (0-255)
    serialRecord.send();            // send it!
  }

}
