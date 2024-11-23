#include <Servo.h> 
#include <SPI.h>
#include "Ucglib.h"

#define  SERVO_PIN   3      // Servo Signal->D3

#define  ECHO_PIN    5      // Ultrasonic Module Echo->D5
#define  TRIG_PIN    6      // Ultrasonic Module Trig->D6

#define RESET_PIN    8      // TFT Module RESET->D8
#define AO_PIN       9      // TFT Module AO->D9
#define CS_PIN      10      // TFT Module CS->D10

#define BAUD    115200

int ScreenHeight = 128;
int ScreenWidth = 160;
int CenterX = 80;
int BasePosition = 118;
int ScanLength = 105;

Servo BaseServo;

Ucglib_ST7735_18x128x160_HWSPI ucg(AO_PIN, CS_PIN, RESET_PIN);

void setup(void)
{
    ucg.begin(UCG_FONT_MODE_SOLID); // Init screen
    // Use setRotate90 or setRotate270 if the screen display direction is reversed
    ucg.setRotate90(); // Set to horizontal screen

    pinMode(TRIG_PIN, OUTPUT); // Set Trig Pin port mode
    pinMode(ECHO_PIN, INPUT); //Set Echo Pin port mode
    Serial.begin(BAUD); // Set the serial port transmission rate
    //BaseServo.attach(SERVO_PIN); // Initialize servos

    // Screen startup interface
    ucg.setFontMode(UCG_FONT_MODE_TRANSPARENT);
    ucg.setColor(0, 0, 100, 0);
    ucg.setColor(1, 0, 100, 0);
    ucg.setColor(2, 20, 20, 20);
    ucg.setColor(3, 20, 20, 20);
    ucg.drawGradientBox(0, 0, 160, 128);
    ucg.setPrintDir(0);
    ucg.setColor(0, 5, 0);
    ucg.setPrintPos(27, 42);
    ucg.setFont(ucg_font_logisoso18_tf);
    ucg.print("Z.I.L.G.A.M.R");
    ucg.setColor(0, 255, 0);
    ucg.setPrintPos(25, 40);
    ucg.print("Z.I.L.G.A.M.R");
    ucg.setFont(ucg_font_helvB08_tf);
    ucg.setColor(0, 255, 0);
    ucg.setPrintPos(40, 100);
    ucg.print("Testing");
    delay(100);
    ucg.print(" . ");
    delay(100);
    ucg.print(" . ");
    delay(100);
    ucg.print(" . ");
    delay(100);
    ucg.print(" . ");
    delay(100);
    ucg.print(" . ");
    delay(100);
    ucg.print(" . ");
    ucg.print("OK");

    //BaseServo.write(90);
    ucg.setColor(0, 255, 0);
    delay(1000);
    ucg.setColor(0, 0, 0, 0);
    ucg.setColor(1, 0, 0, 0);
    ucg.setColor(2, 0, 0, 0);
    ucg.setColor(3, 0, 0, 0);

    //clear screen
    //ucg.clearScreen();
    ClearScreen();

    ucg.setFont(ucg_font_orgv01_hr);
    ucg.setFontMode(UCG_FONT_MODE_SOLID);
}

void ClearScreen() {
  ucg.setColor(0, 0, 0, 0);
  for (int y = 0; y < ScreenHeight; y += 8) {
      for (int x = 0; x < ScreenWidth; x += 16) {
          ucg.drawBox(x, y, 16, 8);
      }
  }  
}

int GetDistance() {
  long dt;
  digitalWrite(TRIG_PIN, LOW);
  delayMicroseconds(2);
  digitalWrite(TRIG_PIN, HIGH);
  delayMicroseconds(10);
  digitalWrite(TRIG_PIN, LOW);
  dt = pulseIn(ECHO_PIN, HIGH);
  return dt * 0.034 / 2;
}

void DrawRadarRanges() {
    ucg.setColor(0, 180, 0);
    ucg.setPrintPos(CenterX - 10, ScreenHeight - 113);
    ucg.print("100cm");
    ucg.setPrintPos(CenterX - 10, ScreenHeight - 96);
    ucg.print("75cm");
    ucg.setPrintPos(CenterX - 10, ScreenHeight - 68);
    ucg.print("50cm");
    ucg.setPrintPos(CenterX - 10, ScreenHeight - 39);
    ucg.print("25cm");
}

void DrawRadarCurves() {
    ucg.setColor(0, 40, 0);

    ucg.drawDisc(CenterX, BasePosition + 1, 3, UCG_DRAW_ALL);
    ucg.drawCircle(CenterX, BasePosition + 1, 115, UCG_DRAW_UPPER_LEFT);
    ucg.drawCircle(CenterX, BasePosition + 1, 115, UCG_DRAW_UPPER_RIGHT);
    ucg.drawCircle(CenterX, BasePosition + 1, 86, UCG_DRAW_UPPER_LEFT);
    ucg.drawCircle(CenterX, BasePosition + 1, 86, UCG_DRAW_UPPER_RIGHT);
    ucg.drawCircle(CenterX, BasePosition + 1, 58, UCG_DRAW_UPPER_LEFT);
    ucg.drawCircle(CenterX, BasePosition + 1, 58, UCG_DRAW_UPPER_RIGHT);
    ucg.drawCircle(CenterX, BasePosition + 1, 29, UCG_DRAW_UPPER_LEFT);
    ucg.drawCircle(CenterX, BasePosition + 1, 29, UCG_DRAW_UPPER_RIGHT);
    ucg.drawLine(0, BasePosition + 1, ScreenWidth, BasePosition + 1);

    ucg.setColor(0, 120, 0);

    for (int i = 40; i < 140; i += 2) {
        if (i % 10 == 0) {
            ucg.drawLine(105 * cos(radians(i)) + CenterX, BasePosition - 105 * sin(radians(i)), 113 * cos(radians(i)) + CenterX, BasePosition - 113 * sin(radians(i)));
        }
        else {
            ucg.drawLine(110 * cos(radians(i)) + CenterX, BasePosition - 110 * sin(radians(i)), 113 * cos(radians(i)) + CenterX, BasePosition - 113 * sin(radians(i)));
        }
    }

    // Draw some decorative patterns
    // ucg.setColor(0, 200, 0);
    // ucg.drawLine(0, 0, 0, 18);
    // for (int i = 0; i < 5; i++) {
    //     ucg.setColor(random(255), random(255), random(255));
    //     ucg.drawBox(2, i * 4, random(14) + 2, 3);
    // }

    // ucg.setColor(0, 0, 180);
    // ucg.drawFrame(146, 0, 14, 14);
    // ucg.setColor(0, 0, 60);
    // ucg.drawHLine(148, 0, 10);
    // ucg.drawVLine(146, 2, 10);
    // ucg.drawHLine(148, 13, 10);
    // ucg.drawVLine(159, 2, 10);

    // ucg.setColor(random(255), random(255), random(255));
    // //ucg.setColor(0,220,0);
    // ucg.drawBox(148, 2, 4, 4);
    // ucg.setColor(0, 220, 0);
    // ucg.drawBox(148, 8, 4, 4);
    // ucg.setColor(random(255), random(255), random(255));
    // //ucg.setColor(100,0,0);
    // ucg.drawBox(154, 8, 4, 4);
    // ucg.setColor(random(255), random(255), random(255));
    // //ucg.setColor(0,0,150);
    // ucg.drawBox(154, 2, 4, 4);

    // ucg.setColor(0, 0, 90);
    // ucg.drawTetragon(62, 123, 58, 127, 98, 127, 102, 123);
    // ucg.setColor(0, 0, 160);
    // ucg.drawTetragon(67, 123, 63, 127, 93, 127, 97, 123);
    // ucg.setColor(0, 255, 0);
    // ucg.drawTetragon(72, 123, 68, 127, 88, 127, 92, 123);
}

void loop(void) {

    int distance;

    DrawRadarCurves();
    DrawRadarRanges();  //Repaint screen background elements

    for (int x = 180; x > 4; x -= 2) {       //The base servo rotates from 180 to 0 degrees

        //BaseServo.write(x);             //Adjust the steering gear angle

        //Draw Radar Scanlines
        int f = x - 4;
        ucg.setColor(0, 255, 0);
        ucg.drawLine(CenterX, BasePosition, ScanLength * cos(radians(f)) + CenterX, BasePosition - ScanLength * sin(radians(f)));
        f += 2;
        ucg.setColor(0, 128, 0);
        ucg.drawLine(CenterX, BasePosition, ScanLength * cos(radians(f)) + CenterX, BasePosition - ScanLength * sin(radians(f)));
        f += 2;
        ucg.setColor(0, 0, 0);
        ucg.drawLine(CenterX, BasePosition, ScanLength * cos(radians(f)) + CenterX, BasePosition - ScanLength * sin(radians(f)));
        ucg.setColor(0, 200, 0);
        //Get the distance value
        distance = GetDistance();

        //Draw a point at the corresponding position according to the measured distance
        if (distance < 100) {
            ucg.setColor(255, 0, 0);
            ucg.drawDisc(1.15 * distance * cos(radians(x)) + CenterX, -(1.15 * distance * sin(radians(x))) + BasePosition, 1, UCG_DRAW_ALL);
        }
        else { //If it is more than 1 meter, it is indicated by a yellow painting on the edge area
            ucg.setColor(255, 255, 0);
            ucg.drawDisc(116 * cos(radians(x)) + CenterX, -116 * sin(radians(x)) + BasePosition, 1, UCG_DRAW_ALL);
        }

        if (x > 70 && x < 110) {
            DrawRadarRanges();  //When the scan line and the number coincide, redraw the number
        }

        ucg.setColor(0, 0, 155, 0);
        ucg.setPrintPos(0, 126);
        ucg.print("DEG: ");
        ucg.setPrintPos(24, 126);
        ucg.print(x);
        ucg.print("  ");
        ucg.setPrintPos(125, 126);
        ucg.print("  ");
        ucg.print(distance);
        ucg.print("cm  ");
    }

    delay(50);
    ClearScreen();
    DrawRadarCurves();
    DrawRadarRanges();          //Repaint screen background elements

    for (int x = 1; x < 176; x += 2) {
        //BaseServo.write(x);             //Adjust the steering gear angle

        //Draw Radar Scanlines
        int f = x + 4;
        ucg.setColor(0, 255, 0);
        ucg.drawLine(CenterX, BasePosition, ScanLength * cos(radians(f)) + CenterX, BasePosition - ScanLength * sin(radians(f)));
        f -= 2;
        ucg.setColor(0, 128, 0);
        ucg.drawLine(CenterX, BasePosition, ScanLength * cos(radians(f)) + CenterX, BasePosition - ScanLength * sin(radians(f)));
        f -= 2;
        ucg.setColor(0, 0, 0);
        ucg.drawLine(CenterX, BasePosition, ScanLength * cos(radians(f)) + CenterX, BasePosition - ScanLength * sin(radians(f)));
        ucg.setColor(0, 200, 0);

        distance = GetDistance();

        //Draw a point at the corresponding position according to the measured distance
        if (distance < 100) {
            ucg.setColor(255, 0, 0);
            ucg.drawDisc(1.15 * distance * cos(radians(x)) + CenterX, -(1.15 * distance * sin(radians(x))) + BasePosition, 1, UCG_DRAW_ALL);
        }
        else { //If it is more than 1 meter, it is indicated by a yellow painting on the edge area
            ucg.setColor(255, 255, 0);
            ucg.drawDisc(116 * cos(radians(x)) + CenterX, -116 * sin(radians(x)) + BasePosition, 1, UCG_DRAW_ALL);
        }

        //Debug code, output angle and range value
        Serial.print("Degree:  ");
        Serial.print(x);
        Serial.print("    ,Distance:   ");
        Serial.println(distance);

        if (x > 70 && x < 110) {
            DrawRadarRanges();  // When the scan line and the number coincide, redraw the number
        }

        ucg.setColor(0, 0, 155, 0);
        ucg.setPrintPos(0, 126);
        ucg.print("DEG: ");
        ucg.setPrintPos(24, 126);
        ucg.print(x);
        ucg.print("   ");
        ucg.setPrintPos(125, 126);
        ucg.print("   ");
        ucg.print(distance);
        ucg.print("cm   ");
    }

    delay(50);
    ClearScreen();
}
