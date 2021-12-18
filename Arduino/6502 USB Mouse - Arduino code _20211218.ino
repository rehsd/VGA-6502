// USB mouse for 6502. Leverages Arduino Mega 2560 with USB Host Shield
// Read USB mouse data and output signals to be read by 6502 VIA (65C22)
//
// Last updated: 18 December 2021
// Reduced required number of data lines. Six data lines, plus interrupt line.
// 
// Six bits on VIA required
// Two MSB bits unused. Next four bits for mouse move direction. Two LSB bits for mouse buttons.
// xxMMMMBB
// 
// Mouse direction bits
//      0000    No mouse movement
//      0001    Up
//      0010    RightUp
//      0011    Right
//      0100    RightDown
//      0101    Down
//      0110    LeftDown
//      0111    Left
//      1000    LeftUp
//      1001 to 1111 are unused combinations
// 
//  
// Mouse buttons bits
//      00      No mouse buttons pressed
//      01      Left button down
//      10      Middle button down
//      11      Right button down

#define PIN_1               A9      //Mouse button
#define PIN_2               A10     //Mouse button
#define PIN_4               A11     //Mouse move
#define PIN_8               A12     //Mouse move
#define PIN_16              A13     //Mouse move
#define PIN_32              A14     //Mouse move
#define PIN_INTERRUPT       A15     //raise interrupt on VIA (bring LOW for interrupt)

#define INTERRUPT_DURTION_MILLIS    6 

unsigned long lastInterruptMillis = 0;

// USB
#include <usbhub.h>
USB         Usb;
USBHub      Hub(&Usb);

// Human Interface Device
#include <hidboot.h>
HIDBoot<USB_HID_PROTOCOL_MOUSE>    HidMouse(&Usb);

// SPI
#include <SPI.h>

// Mouse variables
int dx;
int dy;
int X = 0;
int Y = 0;

bool button_left_down = false;
bool button_middle_down = false;
bool button_right_down = false;


// ----- Mouse Report Parser
class MouseRptParser : public MouseReportParser
{
protected:
    void OnMouseMove(MOUSEINFO* mi);
    void OnLeftButtonUp(MOUSEINFO* mi);
    void OnLeftButtonDown(MOUSEINFO* mi);
    void OnRightButtonUp(MOUSEINFO* mi);
    void OnRightButtonDown(MOUSEINFO* mi);
    void OnMiddleButtonUp(MOUSEINFO* mi);
    void OnMiddleButtonDown(MOUSEINFO* mi);
};
void MouseRptParser::OnMouseMove(MOUSEINFO* mi)
{
    // ----- Code by LINGIB
    int dx = mi->dX;
    int dy = mi->dY;
    X += dx;
    Y += dy;
    
    //reset bits
    digitalWrite(PIN_4, LOW);
    digitalWrite(PIN_8, LOW);
    digitalWrite(PIN_16, LOW);
    digitalWrite(PIN_32, LOW);


    if (dx > 0 && dy > 0)           //rightdown
    {
        Serial.println("move right down");
        digitalWrite(PIN_16, HIGH);
    }
    else if (dx > 0 && dy < 0)      //rightup
    {
        Serial.println("move right up"); 
        digitalWrite(PIN_8, HIGH);
    }
    else if (dx < 0 && dy > 0)      //leftdown
    {
        Serial.println("move left down"); 
        digitalWrite(PIN_16, HIGH);
        digitalWrite(PIN_8, HIGH);
    }
    else if (dx < 0 && dy < 0)      //leftup
    {
        Serial.println("move left up"); 
        digitalWrite(PIN_32, HIGH);
    }
    else if (dx < 0)                //left
    {
        Serial.println("move left");
        digitalWrite(PIN_16, HIGH);
        digitalWrite(PIN_8, HIGH);
        digitalWrite(PIN_4, HIGH);
    }
    else if (dx > 0)                //right
    {
        Serial.println("move right");
        digitalWrite(PIN_8, HIGH);
        digitalWrite(PIN_4, HIGH);
    }
    else if (dy > 0)                //down
    {
        Serial.println("move down");
        digitalWrite(PIN_16, HIGH);
        digitalWrite(PIN_4, HIGH);
    }
    else if (dy < 0)                //up
    {
        Serial.println("move up"); 
        digitalWrite(PIN_4, HIGH);
    }



    digitalWrite(PIN_INTERRUPT, LOW);
    lastInterruptMillis = millis();
};

void MouseRptParser::OnLeftButtonDown(MOUSEINFO* mi)
{
    button_left_down = true;
    digitalWrite(PIN_1, HIGH);
    digitalWrite(PIN_2, LOW);
    digitalWrite(PIN_INTERRUPT, LOW);
    lastInterruptMillis = millis();
};

void MouseRptParser::OnMiddleButtonDown(MOUSEINFO* mi)
{
    button_middle_down = true;
    digitalWrite(PIN_1, LOW);
    digitalWrite(PIN_2, HIGH);
    digitalWrite(PIN_INTERRUPT, LOW);
    lastInterruptMillis = millis();
};

void MouseRptParser::OnRightButtonDown(MOUSEINFO* mi)
{
    button_right_down = true;
    digitalWrite(PIN_1, HIGH);
    digitalWrite(PIN_2, HIGH);
    digitalWrite(PIN_INTERRUPT, LOW);
    lastInterruptMillis = millis();
};

void MouseRptParser::OnLeftButtonUp(MOUSEINFO* mi)
{
    button_left_down = false;
    digitalWrite(PIN_1, LOW);
    digitalWrite(PIN_2, LOW);
    //digitalWrite(PIN_INTERRUPT, HIGH);
    lastInterruptMillis = millis();
};

void MouseRptParser::OnMiddleButtonUp(MOUSEINFO* mi)
{
    button_middle_down = false;
    digitalWrite(PIN_1, LOW);
    digitalWrite(PIN_2, LOW);
    //digitalWrite(PIN_INTERRUPT, HIGH);
    lastInterruptMillis = millis();
};

void MouseRptParser::OnRightButtonUp(MOUSEINFO* mi)
{
    button_right_down = false;
    digitalWrite(PIN_1, LOW);
    digitalWrite(PIN_2, LOW);
    //digitalWrite(PIN_INTERRUPT, HIGH);
    lastInterruptMillis = millis();
}; 

MouseRptParser Prs;

void setup()
{
    Serial.println();
    Serial.println("Initializing mouse...");

    pinMode(PIN_1, OUTPUT);
    pinMode(PIN_2, OUTPUT);
    pinMode(PIN_4, OUTPUT);
    pinMode(PIN_8, OUTPUT);
    pinMode(PIN_16, OUTPUT);
    pinMode(PIN_32, OUTPUT);
    pinMode(PIN_INTERRUPT, OUTPUT);

    digitalWrite(PIN_INTERRUPT, HIGH);  //drop to LOW to enable interrupt on 6502 VIA

    // Serial port
    Serial.begin(115200);

    // Inititialise USB card
    Usb.Init();
    HidMouse.SetReportParser(0, &Prs);

    // Clear mouse variables
    Serial.println("Mouse Ready");
    X = 0;
    Y = 0;
}

void loop()
{
    Usb.Task();
    if ((millis() - lastInterruptMillis) > INTERRUPT_DURTION_MILLIS)
    {
        digitalWrite(PIN_INTERRUPT, HIGH);
        
        //reset bits -- shouldn't be needed, but just in case...
        digitalWrite(PIN_1, LOW);
        digitalWrite(PIN_2, LOW);
        digitalWrite(PIN_4, LOW);
        digitalWrite(PIN_8, LOW);
        digitalWrite(PIN_16, LOW);
        digitalWrite(PIN_32, LOW);
        digitalWrite(PIN_INTERRUPT, HIGH);

        lastInterruptMillis = millis();
    }
}
