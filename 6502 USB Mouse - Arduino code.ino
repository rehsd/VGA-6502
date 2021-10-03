
#define PIN_LEFT            2   //mouse moving left
#define PIN_UP              3   //mouse moving up
#define PIN_RIGHT           4   //mouse moving right
#define PIN_DOWN            5   //mouse moving down
#define PIN_CLICKLEFT       6   //left button click
#define PIN_CLICKRIGHT      7   //right button click
#define PIN_CLICKMIDDLE     A0  //middle button click
#define PIN_INTERRUPT       A1  //raise interrupt on VIA (bring LOW for interrupt)
#define PIN_LEFTUP          A2  //mouse moving left and up
#define PIN_RIGHTUP         A3  //mouse moving right and up
#define PIN_RIGHTDOWN       A4  //mouse moving right and down
#define PIN_LEFTDOWN        A5  //mouse moving left and down

#define INTERRUPT_DURTION_MILLIS    7 

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
    
    Serial.print("dx=");
    Serial.print(dx);
    Serial.print(" dy=");
    Serial.print(dy);
    Serial.print(" X=");
    Serial.print(X);
    Serial.print(" Y=");
    Serial.println(Y);

    //reset bits
    digitalWrite(PIN_LEFT, LOW);
    digitalWrite(PIN_LEFTUP, LOW);
    digitalWrite(PIN_UP, LOW);
    digitalWrite(PIN_RIGHTUP, LOW);
    digitalWrite(PIN_RIGHT, LOW);
    digitalWrite(PIN_RIGHTDOWN, LOW);
    digitalWrite(PIN_DOWN, LOW);
    digitalWrite(PIN_LEFTDOWN, LOW);

    if (dx > 0 && dy > 0)           //rightdown
    {
        digitalWrite(PIN_RIGHTDOWN, HIGH);
    }
    else if (dx > 0 && dy < 0)      //rightup
    {
        digitalWrite(PIN_RIGHTUP, HIGH);
    }
    else if (dx < 0 && dy > 0)      //leftdown
    {
        digitalWrite(PIN_LEFTDOWN, HIGH);
    }
    else if (dx < 0 && dy < 0)      //leftup
    {
        digitalWrite(PIN_LEFTUP, HIGH);
    }
    else if (dx < 0)                //left
    {
        digitalWrite(PIN_LEFT, HIGH);
    }
    else if (dx > 0)                //right
    {
        digitalWrite(PIN_RIGHT, HIGH);
    }
    else if (dy > 0)                //up
    {
        digitalWrite(PIN_DOWN, HIGH);
    }
    else if (dy < 0)                //down
    {
        digitalWrite(PIN_UP, HIGH);
    }
    digitalWrite(PIN_INTERRUPT, LOW);
    lastInterruptMillis = millis();
};
void MouseRptParser::OnLeftButtonUp(MOUSEINFO* mi)
{
    Serial.println("L Butt Up");
    digitalWrite(PIN_CLICKLEFT, LOW);
    digitalWrite(PIN_INTERRUPT, HIGH);
    lastInterruptMillis = millis();
};
void MouseRptParser::OnLeftButtonDown(MOUSEINFO* mi)
{
    Serial.println("L Butt Dn");
    digitalWrite(PIN_CLICKLEFT, HIGH);
    digitalWrite(PIN_INTERRUPT, LOW);
    lastInterruptMillis = millis();
};
void MouseRptParser::OnRightButtonUp(MOUSEINFO* mi)
{
    Serial.println("R Butt Up");
    digitalWrite(PIN_CLICKRIGHT, LOW);
    digitalWrite(PIN_INTERRUPT, HIGH);
    lastInterruptMillis = millis();
};
void MouseRptParser::OnRightButtonDown(MOUSEINFO* mi)
{
    Serial.println("R Butt Dn");
    digitalWrite(PIN_CLICKRIGHT, HIGH);
    digitalWrite(PIN_INTERRUPT, LOW);
    lastInterruptMillis = millis();
};
void MouseRptParser::OnMiddleButtonUp(MOUSEINFO* mi)
{
    Serial.println("M Butt Up");
    digitalWrite(PIN_CLICKMIDDLE, LOW);
    digitalWrite(PIN_INTERRUPT, HIGH);
    lastInterruptMillis = millis();
};
void MouseRptParser::OnMiddleButtonDown(MOUSEINFO* mi)
{
    Serial.println("M Butt Dn");
    digitalWrite(PIN_CLICKMIDDLE, HIGH);
    digitalWrite(PIN_INTERRUPT, LOW);
    lastInterruptMillis = millis();
};
MouseRptParser                               Prs;



void setup()
{
    Serial.println();
    Serial.println("Initializing mouse...");

    pinMode(PIN_LEFT, OUTPUT);
    pinMode(PIN_LEFTUP, OUTPUT);
    pinMode(PIN_UP, OUTPUT);
    pinMode(PIN_RIGHTUP, OUTPUT);
    pinMode(PIN_RIGHT, OUTPUT);
    pinMode(PIN_RIGHTDOWN, OUTPUT);
    pinMode(PIN_DOWN, OUTPUT);
    pinMode(PIN_LEFTDOWN, OUTPUT);
    pinMode(PIN_CLICKLEFT, OUTPUT);
    pinMode(PIN_CLICKRIGHT, OUTPUT);
    pinMode(PIN_CLICKMIDDLE, OUTPUT);
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
        //Serial.print(millis());
        //Serial.print(" - ");
        //Serial.println(lastInterruptMillis);

        digitalWrite(PIN_INTERRUPT, HIGH);
        
        //reset bits -- shouldn't be needed, but just in case...
        digitalWrite(PIN_LEFT, LOW);
        digitalWrite(PIN_LEFTUP, LOW);
        digitalWrite(PIN_UP, LOW);
        digitalWrite(PIN_RIGHTUP, LOW);
        digitalWrite(PIN_RIGHT, LOW);
        digitalWrite(PIN_RIGHTDOWN, LOW);
        digitalWrite(PIN_DOWN, LOW);
        digitalWrite(PIN_LEFTDOWN, LOW);
        digitalWrite(PIN_CLICKLEFT, LOW);
        digitalWrite(PIN_CLICKRIGHT, LOW);
        digitalWrite(PIN_CLICKMIDDLE, LOW);
        digitalWrite(PIN_INTERRUPT, HIGH);

        lastInterruptMillis = millis();
    }
}
