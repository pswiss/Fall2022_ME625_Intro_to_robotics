#define BAUD_RATE 115200

void setup() {
  // put your setup code here, to run once:
  Serial.begin(BAUD_RATE);
}

uint8_t ii = 0;

void loop() {
  // put your main code here, to run repeatedly:
  Serial.print("Hello ");
  Serial.print(ii++);
  Serial.println();
  delay(100);
}
