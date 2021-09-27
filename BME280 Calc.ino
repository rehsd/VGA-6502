//Used on Mega to receive raw BME280 data via serial, process that data, and return temperature and humidity via serial
// https://www.bosch-sensortec.com/media/boschsensortec/downloads/datasheets/bst-bme280-ds002.pdf
//
// Leveraged code fragments from Tyler Glenn
// https://www.arduino.cc/reference/en/libraries/bme280/


//#include <math.h>
char commandReceived[100] {0};
bool capturingCommand;
int iLoc = 0;
int iCommandLength = 0;
int32_t t_fine;

enum TempUnit
{
    TempUnit_Celsius,
    TempUnit_Fahrenheit
};

void setup() {
    capturingCommand = false;
    // initialize both serial ports:
    Serial.begin(115200);   //PC to Arduino
    Serial1.begin(115200);  //Connection from 6551 ACIA to Mega. Requires Mega (Nano only has a single serial)

}

void loop() {
    // read from port 1, send to port 0:
    if (Serial1.available()) {
        int inByte = Serial1.read();
        // Serial.write(inByte);

        if (inByte == '{')
        {
            iLoc = 0;
            capturingCommand = true;
            // Serial.println("{");
        }
        else if (inByte == '}')
        {
            capturingCommand = false;
            iCommandLength = iLoc;
            // Serial.println("}");
            //process command
            processCommand();
        }
        else
        {
            // Serial.println(inByte);
            if (capturingCommand)
            {   
                commandReceived[iLoc] = inByte;
                iLoc++;
                int val = (int)inByte;
            }
        }
    }

    // read from port 0, send to port 1:
    if (Serial.available()) {
        int inByte = Serial.read();
        Serial1.write(inByte);
    }
}

void processCommand()
{
    //Get command # from first two bytes of data --for now, assuming 01 as that's the only option :)
    processCommand01();
}
void printByteAsInt(unsigned char c)
{
    //function to allow further processing, if desired
    //simple for now, could be done inline below instead
    Serial.println(c);
}
void processCommand01()
{
    /*  Expected to receive these data elements after command #:
   SPI_Temp_Current_MSB    = $0023
   SPI_Temp_Current_LSB    = $0024
   SPI_Temp_Current_XLSB   = $0025
   SPI_Humid_Current_MSB   = $0026
   SPI_Humid_Current_LSB   = $0027
   SPI_Temp_digT1_MSB      = $0028
   SPI_Temp_digT1_LSB      = $0029
   SPI_Temp_digT2_MSB      = $002A
   SPI_Temp_digT2_LSB      = $002B
   SPI_Temp_digT3_MSB      = $002C
   SPI_Temp_digT3_LSB      = $002D
   SPI_Temp_digH1          = $002E
   SPI_Temp_digH2_MSB      = $002F
   SPI_Temp_digH2_LSB      = $0030
   SPI_Temp_digH3          = $0031
   SPI_Temp_digH4_MSB      = $0032
   SPI_Temp_digH4_LSB      = $0033
   SPI_Temp_digH5_MSB      = $0034
   SPI_Temp_digH5_LSB      = $0035
   */
    
    Serial.println();
    Serial.println();
    Serial.print(iCommandLength);
    Serial.print("  chars received at ");
    Serial.print(millis());
    Serial.println(" millis");
    Serial.println();

    Serial.print("SPI_Temp_Current_MSB:");
    printByteAsInt(commandReceived[3]);
    Serial.print("SPI_Temp_Current_LSB:");
    printByteAsInt(commandReceived[5]);
    Serial.print("SPI_Temp_Current_XLSB:");
    printByteAsInt(commandReceived[7]);
    Serial.print("SPI_Humid_Current_MSB:");
    printByteAsInt(commandReceived[9]);
    Serial.print("SPI_Humid_Current_LSB:");
    printByteAsInt(commandReceived[11]);
    Serial.print("SPI_Temp_digT1_MSB:");
    printByteAsInt(commandReceived[13]);
    Serial.print("SPI_Temp_digT1_LSB:");
    printByteAsInt(commandReceived[15]);
    Serial.print("SPI_Temp_digT2_MSB:");
    printByteAsInt(commandReceived[17]);
    Serial.print("SPI_Temp_digT2_LSB:");
    printByteAsInt(commandReceived[19]);
    Serial.print("SPI_Temp_digT3_MSB:");
    printByteAsInt(commandReceived[21]);
    Serial.print("SPI_Temp_digT3_LSB:");
    printByteAsInt(commandReceived[23]);
    Serial.print("SPI_Temp_digH1:");
    printByteAsInt(commandReceived[25]);
    Serial.print("SPI_Temp_digH2_MS:");
    printByteAsInt(commandReceived[27]);
    Serial.print("SPI_Temp_digH2_LSB:");
    printByteAsInt(commandReceived[29]);
    Serial.print("SPI_Temp_digH3:");
    printByteAsInt(commandReceived[31]);
    Serial.print("SPI_Temp_digH4_MS:");
    printByteAsInt(commandReceived[33]);
    Serial.print("SPI_Temp_digH4_LSB:");
    printByteAsInt(commandReceived[35]);
    Serial.print("SPI_Temp_digH5_MSB:");
    printByteAsInt(commandReceived[37]);
    Serial.print("SPI_Temp_digH5_LSB:");
    printByteAsInt(commandReceived[39]);
    Serial.print("SPI_Temp_digH6:");
    printByteAsInt(commandReceived[41]);

    Serial.println();
    Serial.println();

    uint32_t rawTemp = (commandReceived[3] << 12) | (commandReceived[5] << 4) | (commandReceived[7] >> 4);
    uint32_t rawHumidity = (commandReceived[9] << 8) | commandReceived[11];

    Serial.print("Raw Temp:");
    Serial.println(rawTemp);
    Serial.print("Raw Humidity:");
    Serial.println(rawHumidity);

    float t = CalculateTemperature(rawTemp, t_fine, TempUnit_Celsius);
    float h = CalculateHumidity(rawHumidity, t_fine);
    Serial.print("Temp:");
    Serial.print(t);
    Serial.println("F");
    Serial.print("Humidity:");
    Serial.print(h);
    Serial.println("%");
    
    do
    {
    } while (!Serial1.available());
    Serial1.write((int)t);
    delay(500); //could try different delays

    do
    {
    } while (!Serial1.available());
    Serial1.write((int)h);
    delay(500); //could try different delays
}

float CalculateTemperature (int32_t raw, int32_t& t_fine, TempUnit unit)
{
    // Code based on calibration algorthim provided by Bosch.
    int32_t var1, var2, final;
    uint16_t dig_T1 = (commandReceived[13] << 8) | commandReceived[15];
    int16_t   dig_T2 = (commandReceived[17] << 8) | commandReceived[19];
    int16_t   dig_T3 = (commandReceived[21] << 8) | commandReceived[23];
    var1 = ((((raw >> 3) - ((int32_t)dig_T1 << 1))) * ((int32_t)dig_T2)) >> 11;
    var2 = (((((raw >> 4) - ((int32_t)dig_T1)) * ((raw >> 4) - ((int32_t)dig_T1))) >> 12) * ((int32_t)dig_T3)) >> 14;
    t_fine = var1 + var2;
    final = (t_fine * 5 + 128) >> 8;
    return unit == TempUnit_Celsius ? final / 100.0 : final / 100.0 * 9.0 / 5.0 + 32.0;
}


float CalculateHumidity (int32_t raw, int32_t t_fine)
{
    // Code based on calibration algorthim provided by Bosch.
    int32_t var1;
    uint8_t   dig_H1 = commandReceived[25];
    int16_t dig_H2 = (commandReceived[27] << 8) | commandReceived[29];
    uint8_t   dig_H3 = commandReceived[31];
    int16_t dig_H4 = ((int8_t)commandReceived[33] * 16) | (0x0F & commandReceived[35]);
    int16_t dig_H5 = ((int8_t)commandReceived[37] * 16) | ((commandReceived[39] >> 4) & 0x0F);
    int8_t   dig_H6 = commandReceived[41];

    var1 = (t_fine - ((int32_t)76800));
    var1 = (((((raw << 14) - (((int32_t)dig_H4) << 20) - (((int32_t)dig_H5) * var1)) +
        ((int32_t)16384)) >> 15) * (((((((var1 * ((int32_t)dig_H6)) >> 10) * (((var1 *
            ((int32_t)dig_H3)) >> 11) + ((int32_t)32768))) >> 10) + ((int32_t)2097152)) *
            ((int32_t)dig_H2) + 8192) >> 14));
    var1 = (var1 - (((((var1 >> 15) * (var1 >> 15)) >> 7) * ((int32_t)dig_H1)) >> 4));
    var1 = (var1 < 0 ? 0 : var1);
    var1 = (var1 > 419430400 ? 419430400 : var1);
    return ((uint32_t)(var1 >> 12)) / 1024.0;
}

