//Portions adapted from https://github.com/MrScrith/arduino_due/blob/master/spi_slave.ino

#include<SPI.h>
#include <stdint.h>
#include <Wire.h>
#include <Adafruit_GFX.h>
#include <Adafruit_SSD1306.h>
// volatile byte recvByte = '0';
volatile byte sendByte = '0';
volatile byte currentCommand;
volatile byte bytesSent;
volatile byte totalBytesToSend;
volatile byte printScreenBytesReceived;
const byte CMD_RESET = 0;
const byte CMD_GETSTATUS = 1;
const byte CMD_GETTWOBYTES = 2;
const byte CMD_PRINTSCREEN = 3;
const byte CMD_GETSOUNDINFO = 4;
const byte CMD_FLUSH = 255;
volatile byte currentX = 0;
volatile byte currentY = 0;
volatile byte currentTEST = 0;
volatile bool imageComplete = false;
const int INTERRUPT_ENABLE_TIME = 50;
#define VIA3_CB2_PIN  5

#define SCREEN_WIDTH 128 // OLED display width, in pixels
#define SCREEN_HEIGHT 64 // OLED display height, in pixels
#define OLED_RESET     4 // Reset pin # (or -1 if sharing Arduino reset pin)
#define SCREEN_ADDRESS 0x3C ///< See datasheet for Address; 0x3D for 128x64, 0x3C for 128x32
Adafruit_SSD1306 display(SCREEN_WIDTH, SCREEN_HEIGHT, &Wire, OLED_RESET);
#define SCREEN_ADDRESS2 0x3D ///< See datasheet for Address; 0x3D for 128x64, 0x3C for 128x32
Adafruit_SSD1306 display2(SCREEN_WIDTH, SCREEN_HEIGHT, &Wire, OLED_RESET);

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
//EnableLeft1
//EnableRight1
//EnableLeft2
//EnableRight2                    = 43
//NoisePeriodR1
//EnvelopePeriodCourseR1
//EnvelopePeriodFineR1
//EnvelopeShapeCycleR1
//NoisePeriodL2
//EnvelopePeriodCourseL2         = 49
//EnvelopePeriodFineL2
//EnvelopeShapeCycleL2
//NoisePeriodR2.Value
//EnvelopePeriodCourseR2
//EnvelopePeriodFineR2
//EnvelopeShapeCycleR2           = 55


// SPI 0 interrupt for the SAM3XA chip:
#define SPI0_INTERRUPT_NUMBER (IRQn_Type)24

// Buffer sized as needed
#define BUFFER_SIZE 1000

// Default chip select pin, not tested with any other pins
#define SS 10

// Make sure the handler is properly defined for the compiler to catch it.
void SPI0_Handler(void);


void slaveBegin(uint8_t _pin) {
    // Setup the SPI Interrupt registers.
    NVIC_ClearPendingIRQ(SPI0_INTERRUPT_NUMBER);
    NVIC_EnableIRQ(SPI0_INTERRUPT_NUMBER);

    // Initialize the SPI device with Arduino default values
    SPI.begin(_pin);
    //SPI.setDataMode(10, SPI_MODE0);
    //REG_SPI0_CR |= 0x1;          // SPI enable (write only)
    //REG_SPI0_WPMR = 0x53504900;  // Write Protection disable
    //REG_SPI0_MR = 0x2;           // DLYBCS=0, PCS=0, PS=1, MSTR=0
    //REG_SPI0_CSR = 0xA;          // DLYBCT=0, DLYBS=0, SCBR=0, 8 bit transfer, Clock Phase = 1 for SPI mode 0

    REG_SPI0_CR = SPI_CR_SWRST;     // reset SPI
    SPI.setBitOrder(MSBFIRST);

    // Setup interrupt
    REG_SPI0_IDR = SPI_IDR_TDRE | SPI_IDR_MODF | SPI_IDR_OVRES | SPI_IDR_NSSR | SPI_IDR_TXEMPTY | SPI_IDR_UNDES;
    REG_SPI0_IER = SPI_IER_RDRF;

    // Setup the SPI registers.
    REG_SPI0_CR = SPI_CR_SPIEN;     // enable SPI
    REG_SPI0_MR = SPI_MR_MODFDIS;     // slave and no modefault
    REG_SPI0_CSR = SPI_MODE0;    // DLYBCT=0, DLYBS=0, SCBR=0, 8 bit transfer
}

void SPI0_Handler(void)
{
    //uint32_t b = 0;
    byte b = 0;
    
    // Receive byte
    //while ((REG_SPI0_SR & SPI_SR_RDRF) == 0);
    b = REG_SPI0_RDR;

    HandleSPIbyte(b);
}

void setup()
{
    pinMode(VIA3_CB2_PIN, OUTPUT);
    digitalWrite(VIA3_CB2_PIN, LOW);
    //digitalWrite(VIA3_CB2_PIN, LOW);

    currentCommand = CMD_RESET;
    SerialUSB.begin(115200); //speed doesn't matter, runs at USB max (480Mbps)
    SerialUSB.flush();

    if (!display.begin(SSD1306_SWITCHCAPVCC, SCREEN_ADDRESS)) {
        SerialUSB.println(F("SSD1306 allocation failed"));
    }
    display.clearDisplay();
    testdrawchar();      // Draw characters of the default font
    display.clearDisplay();
    display.setTextSize(1);      // Normal 1:1 pixel scale
    display.setTextColor(SSD1306_WHITE); // Draw white text
    display.setCursor(0, 0);     // Start at top-left corner
    display.println("Ready display #1");
    display.display();

    if (!display2.begin(SSD1306_SWITCHCAPVCC, SCREEN_ADDRESS2)) {
        SerialUSB.println(F("SSD1306 allocation failed"));
    }
    display2.clearDisplay();
    testdrawchar2();      // Draw characters of the default font
    display2.clearDisplay();
    display2.setTextSize(1);      // Normal 1:1 pixel scale
    display2.setTextColor(SSD1306_WHITE); // Draw white text
    display2.setCursor(0, 0);     // Start at top-left corner
    display2.println("Ready display #2");
    display2.display();

    // Setup the SPI as Slave
    slaveBegin(SS);
}

void HandleSPIbyte(byte recvByte)   //Interrupt routine function
{
    if (currentCommand == CMD_RESET)
    {
        currentCommand = recvByte;

        sendByte = 1;       //ack
        REG_SPI0_TDR = sendByte;
      
        switch (currentCommand) {
        case CMD_GETTWOBYTES:      //2
            totalBytesToSend = 2;
            break;
        case CMD_PRINTSCREEN:
            //Serial.println("***PRINTSCREEN***");
            display2.clearDisplay();
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
        switch (currentCommand) {
        case CMD_GETSTATUS:         //1
            sendByte = 1;
            //SPDR = sendByte;
            REG_SPI0_TDR = sendByte;
            currentCommand = CMD_RESET;
            break;
        case CMD_GETTWOBYTES:      //2
            if (bytesSent == 0)
            {
                //send first byte
                sendByte = 3;
                bytesSent++;
                //SPDR = sendByte;
                REG_SPI0_TDR = sendByte;

            }
            else if (bytesSent == 1)
            {
                //send second byte
                sendByte = 4;
                bytesSent++;
                //SPDR = sendByte;
                REG_SPI0_TDR = sendByte;

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
                    display2.drawPixel(currentX, currentY, SSD1306_WHITE);
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
            if (bytesSent < 56)
            {
                //display.print("$");

                //send byte
                sendByte = audio_data[bytesSent];
                display2.print(sendByte);
                display2.print(";");
                bytesSent++;
                //SPDR = sendByte;
                REG_SPI0_TDR = sendByte;
            }
            else
            {
                display2.print("!");

                //in case too much data is received for some reason
                currentCommand = CMD_RESET;
            }
            if (bytesSent == 56)   //last byte
            {
                display2.print("^");

                currentCommand = CMD_FLUSH;
            }

            break;
        default:
            {
                
            }
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
void testdrawchar2(void) {
    display2.clearDisplay();

    display2.setTextSize(1);      // Normal 1:1 pixel scale
    display2.setTextColor(SSD1306_WHITE); // Draw white text
    display2.setCursor(0, 0);     // Start at top-left corner
    display2.cp437(true);         // Use full 256 char 'Code Page 437' font

    // Not all the characters will fit on the display. This is normal.
    // Library will draw what it can and the rest will be clipped.
    for (int16_t i = 0; i < 256; i++) {
        if (i == '\n') display2.write(' ');
        else          display2.write(i);
    }

    display2.display();
    delay(1000);
}

void loop()
{
    if (SerialUSB.available() >= 60) {
        char buffer[60];
        SerialUSB.readBytes(buffer, 60);

        //if ((buffer[0] == 'C') && (buffer[1] == 'B') && (buffer[2]) == 'C' && (buffer[3] == ':'))
        if ((buffer[0] == 'C')) //  && (buffer[1] == 'B') && (buffer[2]) == 'C' && (buffer[3] == ':'))
        {
            for (int i = 0; i < 56; i++)    //don't need the first four bytes (command info)
            {
                audio_data[i] = buffer[i + 4];
            }

            display.clearDisplay();
            display.setCursor(0, 0);     // Start at top-left corner

            display2.clearDisplay();
            display2.setCursor(0, 0);     // Start at top-left corner

            for (int i = 0; i < 56; i++)
            {
                display.print(audio_data[i]);
                display.print(";");
            }
            display.println();
            display.display();

            //raise interrupt on VIA
            //send HIGH to 74HC00 to trigger LOW interrupt on VIA
            digitalWrite(VIA3_CB2_PIN, HIGH);
            delay(INTERRUPT_ENABLE_TIME);
            digitalWrite(VIA3_CB2_PIN, LOW);
        }
        else
        {
            display.println("Unrecognized incoming serial data");
            display.display();
        }
    }

    display.display();
    display2.display();
}

