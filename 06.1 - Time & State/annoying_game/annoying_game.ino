// An annoying game with a button (with pull-down) on pin 2, and the buzzer on pin 8
// Try to hold down the button for exactly 10 seconds

int val;         // button val
int prevVal;     // prev button val
long startTime;  // variable to record the start time of the game. We use the long datatype for large number such as millis()
int state = 1;   // game starts at state 1

void setup() {
  Serial.begin(9600);
  pinMode(2, INPUT);    // button pin 2
  pinMode(13, OUTPUT);  // internal LED pin 13
}

void loop() {
  if (state == 1) {
    state1();
  } else if (state == 2) {
    state2();
  } else if (state == 3) {
    state3();
  }
}

// intro
void state1() {
  tone(8, random(100, 1100));  // generate random sounds every 100 ms
  delay(100);
  val = digitalRead(2);
  if (prevVal == LOW && val == HIGH) {
    state = 2;             // transition to main game
    startTime = millis();  // record the time the player started pressing the button
  }
   prevVal = val;
}

// main game
void state2() {
   val = digitalRead(2);

   if (prevVal == HIGH && val == LOW) {  // After the button is released
    noTone(8);          // turn off the sound while checking the results
    Serial.print("10 seconds? You pressed ");
    Serial.println((millis() - startTime) / 1000.0);  // write on serial print the amount of seconds you pressed the button

    if (millis() - startTime > 9500 && millis() - startTime < 10500) {
      state = 3;  // transition to outro (player won)
      Serial.println("Good timing!");
    } else {
      state = 1;  // transition back to intro (player lost)
      // but first a brief sound effect
      tone(8, 294);
      delay(300);
      tone(8, 277);
      delay(300);
      tone(8, 262);
      delay(300);
      tone(8, 247);
      delay(900);
      noTone(8);
      delay(1000);
    }
  }
  prevVal = val;
}

// outro
void state3() {
  // blink the LED.. in silence
  digitalWrite(13, HIGH);
  delay(500);
  digitalWrite(13, LOW);
  delay(500);
}
