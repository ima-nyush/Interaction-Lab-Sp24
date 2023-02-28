// An annoying game with a button (with pull-down) on pin 2, and the buzzer on pin 8
// Try to hold down the button for exactly 10 seconds

int state = 1;
int button;
long startTime;

void setup() {
  Serial.begin(9600);
  pinMode(2, INPUT);
  pinMode(13, OUTPUT);
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
  tone(8, random(100, 1100));
  delay(100);

  if (digitalRead(2) == HIGH) {
    // transition to main game
    state = 2;
    // record the time the player started pressing the button
    startTime = millis();
  }
}

// main game
void state2() {
  button = digitalRead(2);

  if (button == LOW) {
    // turn off the sound again
    noTone(8);

    Serial.print("10 seconds? You pressed ");
    Serial.println((millis()-startTime) / 1000.0);

    if (millis()-startTime > 9500 && millis()-startTime < 10500) {
      // transition to outro (player won)
      state = 3;
      Serial.println("Good timing!");
    } else {
      // transition back to intro (player lost)
      state = 1;
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
}

// outro
void state3() {
  // blink the LED.. in silence
  digitalWrite(13, HIGH);
  delay(500);
  digitalWrite(13, LOW);
  delay(500);
}
