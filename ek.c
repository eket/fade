const int redPin = 3;
const int greenPin = 5;
const int bluePin = 6;

const int redPin1 = 10;
const int greenPin1 = 11;
const int bluePin1 = 13;

void setup() {
  Serial.begin(9600);
  pinMode(redPin, OUTPUT); 
  pinMode(greenPin, OUTPUT); 
  pinMode(bluePin, OUTPUT);
  
  pinMode(redPin1, OUTPUT); 
  pinMode(greenPin1, OUTPUT); 
  pinMode(bluePin1, OUTPUT);
}

void loop() {
  while (Serial.available() > 0) {
    int red = Serial.parseInt(); 
    int green = Serial.parseInt(); 
    int blue = Serial.parseInt();
    
    int red1 = Serial.parseInt();
    int green1 = Serial.parseInt();
    int blue1 = Serial.parseInt();

    if (Serial.read() == '\n') {
      red = 255 - constrain(red, 0, 255);
      green = 255 - constrain(green, 0, 255);
      blue = 255 - constrain(blue, 0, 255);

      red1 = 255 - constrain(red1, 0, 255);
      green1 = 255 - constrain(green1, 0, 255);
      blue1 = 255 - constrain(blue1, 0, 255);

      analogWrite(redPin, red);
      analogWrite(greenPin, green);
      analogWrite(bluePin, blue);
      
      analogWrite(redPin1, red1);
      analogWrite(greenPin1, green1);
      analogWrite(bluePin1, blue1);

      Serial.print(red, HEX);
      Serial.print(green, HEX);
      Serial.println(blue, HEX);
    }
  }
}