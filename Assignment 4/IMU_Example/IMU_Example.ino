#include <Wire.h>
#include <LSM6.h>

// Create an object called 'imu' of the type LSM6
LSM6 imu;

void setup() {
  // Start Serial
  Serial.begin(115200);
  // Start I2C
  Wire.begin();

  // Initialize the IMU
  if(!imu.init())
  {
    // Error message if we didn't start correctly
    Serial.println("Failed to detect and initialize IMU!");
    delay(1000);
  }
  // Set the default values
  imu.enableDefault();
}

void loop() {
  // Get all the data to the arduino from the IMU
  imu.read();

  // PART 1: 
  /*
  Serial.print("A: ");
  Serial.print(imu.a.x); Serial.print(", ");
  Serial.print(imu.a.y); Serial.print(", ");
  Serial.print(imu.a.z); 

  Serial.print("\t\tG: ");
  Serial.print(imu.g.x); Serial.print(", ");
  Serial.print(imu.g.y); Serial.print(", ");
  Serial.print(imu.g.z); Serial.println();

  delay(1000);
  /**/

  // PART 2: 
  /**/
  Serial.print(millis());Serial.print(",");
  Serial.print(imu.a.x); Serial.print(",");
  Serial.print(imu.a.y); Serial.print(",");
  Serial.print(imu.a.z); Serial.print(",");
  Serial.print(imu.g.x); Serial.print(",");
  Serial.print(imu.g.y); Serial.print(",");
  Serial.print(imu.g.z); Serial.println();

  /**/

  
}
