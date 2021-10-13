#include<SPI.h>
#include <Wire.h>
#include <Adafruit_GFX.h>
#include <Adafruit_SSD1306.h>
volatile byte recvByte = '0';
volatile byte sendByte = '0';
volatile byte currentCommand;
volatile byte bytesSent;
volatile byte totalBytesToSend;
volatile byte printScreenBytesReceived;
const byte CMD_RESET        = 0;
const byte CMD_GETSTATUS    = 1;
const byte CMD_GETTWOBYTES  = 2;
const byte CMD_PRINTSCREEN  = 3;
const byte CMD_GETSOUNDINFO = 4;
const byte CMD_FLUSH        = 255;
volatile byte currentX = 0;
volatile byte currentY = 0;
volatile byte currentTEST = 0;
volatile bool imageComplete = false;

#define VIA3_CB2_PIN  5

#define SCREEN_WIDTH 128 // OLED display width, in pixels
#define SCREEN_HEIGHT 64 // OLED display height, in pixels
#define OLED_RESET     4 // Reset pin # (or -1 if sharing Arduino reset pin)
#define SCREEN_ADDRESS 0x3C ///< See datasheet for Address; 0x3D for 128x64, 0x3C for 128x32
Adafruit_SSD1306 display(SCREEN_WIDTH, SCREEN_HEIGHT, &Wire, OLED_RESET);

volatile byte audio_data[56];
//const int TonePeriodCourseLA    = 0;
//const int TonePeriodCourseLB    = 1;
//const int TonePeriodCourseLC    = 2;
//const int TonePeriodCourseLD    = 3;
//const int TonePeriodCourseLE    = 4;
//const int TonePeriodCourseLF    = 5;
//const int TonePeriodFineLA      = 6;
//const int TonePeriodFineLB      = 7;
//const int TonePeriodFineLC      = 8;
//const int TonePeriodFineLD      = 9;
//const int TonePeriodFineLE      = 10;
//const int TonePeriodFineLF      = 11;
//const int VolumeLA              = 12;
//const int VolumeLB              = 13;
//const int VolumeLC              = 14;
//const int VolumeLD              = 15;
//const int VolumeLE              = 16;
//const int VolumeLF              = 17;
//const int TonePeriodCourseRA    = 18;
//const int TonePeriodCourseRB    = 19;
//const int TonePeriodCourseRC    = 20;
//const int TonePeriodCourseRD    = 21;
//const int TonePeriodCourseRE    = 22;
//const int TonePeriodCourseRF    = 23;
//const int TonePeriodFineRA      = 24;
//const int TonePeriodFineRB      = 25;
//const int TonePeriodFineRC      = 26;
//const int TonePeriodFineRD      = 27;
//const int TonePeriodFineRE      = 28;
//const int TonePeriodFineRF      = 29;
//const int VolumeRA              = 30;
//const int VolumeRB              = 31;
//const int VolumeRC              = 32;
//const int VolumeRD              = 33;
//const int VolumeRE              = 34;
//const int VolumeRF              = 35;
//const int NoisePeriod           = 36;
//const int EnvelopePeriodCourse  = 37;
//const int EnvelopePeriodFine    = 38;
//const int EnvelopeShapeCycle    = 39;
// enableLeft1;
// enableRight1;
// enableLeft2;
// enableRight2;                  = 43
// nudNoisePeriodR1.Value;  
//nudEnvelopePeriodCourseR1.Value;
//nudEnvelopePeriodFineR1.Value;
//envelopeShapeCycleR1;
//nudNoisePeriodL2.Value;
//nudEnvelopePeriodCourseL2.Value;   = 49
//nudEnvelopePeriodFineL2.Value;
//envelopeShapeCycleL2;
//nudNoisePeriodR2.Value;
//nudEnvelopePeriodCourseR2.Value;
//nudEnvelopePeriodFineR2.Value;
//envelopeShapeCycleR2;             = 55

void setup()
{

    currentCommand = CMD_RESET;
    //Serial.begin(230400);
    Serial.begin(115200);
    SPCR |= _BV(SPE);
    pinMode(MISO, OUTPUT);
    pinMode(SS, INPUT_PULLUP);
    pinMode(MOSI, INPUT);
    pinMode(SCK, INPUT);
    Serial.flush();
    SPI.attachInterrupt();

    pinMode(VIA3_CB2_PIN, OUTPUT);
    digitalWrite(VIA3_CB2_PIN, HIGH);

    if (!display.begin(SSD1306_SWITCHCAPVCC, SCREEN_ADDRESS)) {
        Serial.println(F("SSD1306 allocation failed"));
        //    for (;;); // Don't proceed, loop forever
    }
    display.clearDisplay();
    testdrawchar();      // Draw characters of the default font
    display.clearDisplay();
    display.setTextSize(1);      // Normal 1:1 pixel scale
    display.setTextColor(SSD1306_WHITE); // Draw white text
    display.setCursor(0, 0);     // Start at top-left corner
    display.display();

}

ISR(SPI_STC_vect)   //Interrupt routine function
{
    recvByte = SPDR;
    //display.print("i:");
    //display.print(recvByte);
    //display.print(".");
    if (currentCommand==CMD_RESET)
    {
        display.print("reset");
        //if we don't already have an instruction, assume this byte is an instruction
        //Serial.print("Instruction 0x");
        //Serial.print(recvByte, HEX);
        currentCommand = recvByte;

        sendByte = 1;       //ack
        SPDR = sendByte;
        //Serial.print(", Return Status: 0x");
        //Serial.println(sendByte, HEX);

        switch (currentCommand) {
            case CMD_GETTWOBYTES:      //2
                totalBytesToSend = 2;
                break;
            case CMD_PRINTSCREEN:
                //Serial.println("***PRINTSCREEN***");
                display.clearDisplay();
                break;
            case CMD_GETSOUNDINFO:
                totalBytesToSend = 56;
                break;
            default:
                totalBytesToSend = 1;
                break;
        }
        bytesSent = 0;
    }
    else if (currentCommand == CMD_FLUSH)
    {
        currentCommand = CMD_RESET;
    }
    else
    {
        if (currentCommand != CMD_PRINTSCREEN)
        {
            //if we already have the instruction info, process the data
            //Serial.print("Processing data for instruction 0x");
            //Serial.print(currentCommand);
        }

        switch (currentCommand) {
            case CMD_GETSTATUS:         //1
                sendByte = 1;
                SPDR = sendByte;
                currentCommand = CMD_RESET;
                break;
            case CMD_GETTWOBYTES:      //2
                if (bytesSent == 0)
                {
                    //send first byte
                    sendByte = 3;
                    bytesSent++;
                    SPDR = sendByte;
                }
                else if (bytesSent == 1)
                {
                    //send second byte
                    sendByte = 4;
                    bytesSent++;
                    SPDR = sendByte;
                    currentCommand = CMD_FLUSH;
                }
                break;
            case CMD_PRINTSCREEN:
                //receive 4k from 6502 to represent the screen
                
                if (currentX > 1)      //filter out first two column of noise
                {
                    //send to PC
                    //Serial.write(recvByte);

                    //send to OLED I2C display
                    if (recvByte > 0)
                    {
                        display.drawPixel(currentX, currentY, SSD1306_WHITE);
                    }
                }
                currentTEST++;
                currentX++;
                if (currentX == 100)
                {
                    currentX = 0;
                    currentY++;
                    if (currentY == 64)
                    {
                        currentCommand = CMD_RESET;
                        currentY = 0;
                        printScreenBytesReceived = 0;
                    }
                }
  
                break;
            case CMD_GETSOUNDINFO:          //4
                //display.print("sent:");
                //display.print(bytesSent);
                if (bytesSent < 56)
                {
                    //display.print("$");

                    //send byte
                    sendByte = audio_data[bytesSent];
                    display.print(sendByte);
                    display.print(";");
                    bytesSent++;
                    SPDR = sendByte;
                }
                else
                {
                    display.print("!");

                    //in case too much data is received for some reason
                    currentCommand = CMD_RESET;
                }
                if (bytesSent == 56)   //last byte
                {
                    display.print("^");

                    currentCommand = CMD_FLUSH;
                }

                break;
        }

        if (currentCommand != CMD_PRINTSCREEN)
        {
            //Serial.print(", Return: 0x");
            //Serial.println(sendByte, HEX);
        }
        if (currentCommand == CMD_RESET)
        {
            //Serial.println("************************");
        }
    }

}

void testdrawchar(void) {
    display.clearDisplay();

    display.setTextSize(1);      // Normal 1:1 pixel scale
    display.setTextColor(SSD1306_WHITE); // Draw white text
    display.setCursor(0, 0);     // Start at top-left corner
    display.cp437(true);         // Use full 256 char 'Code Page 437' font

    // Not all the characters will fit on the display. This is normal.
    // Library will draw what it can and the rest will be clipped.
    for (int16_t i = 0; i < 256; i++) {
        if (i == '\n') display.write(' ');
        else          display.write(i);
    }

    display.display();
    delay(500);
}

void loop()
{
    if (Serial.available()>=60) {
        //TO DO May need logic to ensure all 44 bytes have been received before proceeding
        //For now, assuming we have all 44 bytes

        //For future expansion, might need different buffer length, but 61 should be the longest
        char buffer[60];
        Serial.readBytes(buffer, 60);
        //display.print(buffer[0]);
        //display.print(buffer[1]);
        //display.print(buffer[2]);
        //display.print(":");
        //String testString = String(char(buffer[0]));
        //display.println(char(buffer[0]));
        //display.println(char(buffer[1]));
        display.display();


        //first three bytes should indicate the command
        //String commandString = String(buffer[0]) + String(buffer[1]) + String(buffer[2]);
        //display.print("Serial Command:");
        //display.println(commandString);
        //display.display();

        //if ((buffer[0] == 'C') && (buffer[1] == 'B') && (buffer[2]) == 'C' && (buffer[3] == ':'))
        if ((buffer[0] == 'C')) //  && (buffer[1] == 'B') && (buffer[2]) == 'C' && (buffer[3] == ':'))
        {
            //display.print("Serial Command: CB1");
            //display.display();
            //delay(1000);
            //display.clearDisplay();
            //display.setCursor(0, 0);     // Start at top-left corner
            //display.print("data:");
            //display.write(buffer);
            //display.display();
            //delay(10000);

            //then skip the ':' and pull the next 40 bytes and store in memory for quick access during SPI call from 6502
            //display.println("interrupt start...");
            //display.display();

            for (int i = 0; i < 56; i++)    //don't need the first four bytes (command info)
            {
                audio_data[i] = buffer[i + 4];
            }


            //display.println();
            //display.println("interrupt complete...");
            //display.display();
            //delay(500);

            display.clearDisplay();
            display.setCursor(0, 0);     // Start at top-left corner

            for (int i = 0; i < 56; i++)
            {
                display.print(audio_data[i]);
            }
            display.println();
            display.display();

            digitalWrite(VIA3_CB2_PIN, LOW);
            delay(500);
            digitalWrite(VIA3_CB2_PIN, HIGH);

        }
        else
        {
            display.println("Unrecognized incoming serial data");
            display.display();
        }
    }

    display.display();
}

