#define MOTOR_PIN_1 10
#define MOTOR_PIN_2 11

void setup() {
  // put your setup code here, to run once:
  pinMode(MOTOR_PIN_1, OUTPUT);
  pinMode(MOTOR_PIN_2, OUTPUT);

}

void loop() {
  // put your main code here, to run repeatedly:
  digitalWrite(MOTOR_PIN_1, LOW);
  analogWrite(MOTOR_PIN_2, 157);
  delay(1000);
  digitalWrite(MOTOR_PIN_1, LOW);
  digitalWrite(MOTOR_PIN_2, LOW);
  delay(1000);
  analogWrite(MOTOR_PIN_1, 157);
  digitalWrite(MOTOR_PIN_2, LOW);
  delay(1000);
  digitalWrite(MOTOR_PIN_1, LOW);
  digitalWrite(MOTOR_PIN_2, LOW);
  delay(1000);

}
