#define BAUD_RATE 115200
#define PIN_IN_BUTTON 8

#define PIN_OUT_LED_RED 3
#define PIN_OUT_LED_GRE 5
#define PIN_OUT_LED_BLU 6

void setup() {
  // put your setup code here, to run once:
  Serial.begin(BAUD_RATE);

  pinMode(PIN_IN_BUTTON, INPUT);

  pinMode(PIN_OUT_LED_RED, OUTPUT);
  pinMode(PIN_OUT_LED_GRE, OUTPUT);
  pinMode(PIN_OUT_LED_BLU, OUTPUT);
}

uint8_t ii = 0;

unsigned long t_last_pressed = 0;

void loop() {
  // put your main code here, to run repeatedly:

  // PART 1: Run
  /*
  if(digitalRead(PIN_IN_BUTTON))
  {
    Serial.print("Hello ");
    Serial.print(ii++);
    Serial.println();
    delay(100);
  }/**/

  // PART 2: No delay
  /*
  if(digitalRead(PIN_IN_BUTTON))
  {
    Serial.print("Hello ");
    Serial.print(ii++);
    Serial.println();
  }/**/


  // PART 3: Only once
  /*
  if(digitalRead(PIN_IN_BUTTON))
  {
    Serial.print("Hello ");
    Serial.print(ii++);
    Serial.println();
    while(digitalRead(PIN_IN_BUTTON))
    {
      // Do Nothing
    }
  }/**/


  // PART 4: Debouncing
  /*
  if(digitalRead(PIN_IN_BUTTON)&&(millis() > (t_last_pressed+10)))
  {
    Serial.print("Hello ");
    Serial.print(ii++);
    Serial.println();
    while(digitalRead(PIN_IN_BUTTON))
    {
      t_last_pressed = millis();
    }
  }/**/

  //Part 5: LEDs
  /*
  digitalWrite(PIN_OUT_LED_RED, HIGH);
  digitalWrite(PIN_OUT_LED_GRE , HIGH);
  digitalWrite(PIN_OUT_LED_BLU , HIGH);
  delay(1000);
  digitalWrite(PIN_OUT_LED_RED, HIGH);
  digitalWrite(PIN_OUT_LED_GRE , LOW);
  digitalWrite(PIN_OUT_LED_BLU , LOW);
  delay(1000);
  digitalWrite(PIN_OUT_LED_RED, LOW);
  digitalWrite(PIN_OUT_LED_GRE , HIGH);
  digitalWrite(PIN_OUT_LED_BLU , LOW);
  delay(1000);
  digitalWrite(PIN_OUT_LED_RED, LOW);
  digitalWrite(PIN_OUT_LED_GRE , LOW);
  digitalWrite(PIN_OUT_LED_BLU , HIGH);
  delay(1000);
  digitalWrite(PIN_OUT_LED_BLU , LOW);
  for(int ii = 0; ii < 255; ii++)
  {
    analogWrite(PIN_OUT_LED_RED, ii);
    delay(20);
  }/**/
  
}
