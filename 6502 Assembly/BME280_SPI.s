;Code related to reading BME280... pulling out of main code and removing circuitry for now.
;Putting code here for future reference

SPI_ExpectingData       = $001F
SPI_Temp_NewData        = $0020
SPI_TempSend_Address    = $0021
SPI_TempSend_Command    = $0022
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
SPI_Temp_digH6          = $0036
SPI_Calculated_Temp     = $0037
SPI_Calculated_Humid    = $0038


;VIA3                  ;PORTB
OE                     = %00000001
SCK                    = %00000010
RCK_OUT                = %00000100
SLOAD                  = %00001000
RCK_IN                 = %00010000
SPI_DEV0               = %00000000      ;Leave unused for now -- to toggle away from other SPI_DEVs
SPI_DEV1               = %00100000      ;8 digit 7-segment LED
SPI_DEV2               = %01000000
SPI_DEV3               = %01100000
SPI_DEV4               = %10000000
SPI_DEV5               = %10100000
SPI_DEV6               = %11000000      ;Waveshare BME280 temperature sensor
SPI_DEV7               = %11100000      ;74HC595 serial to parallel shift register (SPI to VIA)

setup:
  ;jsr PrintStringLCD_readTemp
  ;jsr InitTempHumidity
  ;jsr GetTemperatureHumdity
  ;jsr CalcTempHumidityFromRawData       ;temp location = this should move to loop:

SetupTemperatureTimer:
  ;For 6522-based Timer1 --- too quick to use, will maybe use in future for a different purpose
  rts
  lda #0
  sta ticks
  lda #255          ; update every 255 times TIMER5_1_INTERVAL = 255*20ms = 5 seconds (?)
  sta max_ticks
  lda #%01000000    ; T1 continuous interrupts, disable PB7; T2, SR disabled
  sta ACR5
  lda #%11000000    ; enable T1 interrupt
  sta IER5
  ;lda #<TIMER5_1_INTERVAL
  ;sta T1C_L5
  lda #TIMER5_1_INTERVAL       ;> load upper bits or 2-byte
  sta T1C_H5
  rts
  
InitTempHumidity:
  ;lda #$D0    ;chip id register
  ;jsr TempSpiSendReceive
  ;store chip id received from sensor
  ;sta ...
  ;jsr print_hex_lcd
  
  lda #$72      ;CTRL_HUM (0xF4 without highest bit to set)      ;the last (right) three bits control humidity sampling (001 = x1 sampling)
  sta SPI_TempSend_Address
  lda #%00000101
  sta SPI_TempSend_Command
  jsr TempSpiSendCommand

  lda #$74      ;CTRL_MEAS (0xF4 without highest bit to set)
  sta SPI_TempSend_Address
  ;lda #%00110111                ;first (left) three bits control temp sampling; next three for pressure sampling; last two for sensor mode
  lda #%10110111                ;first (left) three bits control temp sampling; next three for pressure sampling; last two for sensor mode
  sta SPI_TempSend_Command
  jsr TempSpiSendCommand

  lda #$75      ;CONFIG (0xF5 without highest bit to set) - this probably does not apply to 'normal' mode
  sta SPI_TempSend_Address
  ;lda #%00010000        ;left three = inactive duration; next three = IIR filter; last two = can set 3-wire SPI
  lda #%00001000        ;left three = inactive duration; next three = IIR filter; last two = can set 3-wire SPI
  sta SPI_TempSend_Command
  jsr TempSpiSendCommand

  ;****** calibration data *******
  ;TO DO Double-check MSB vs LSB and upper bits / lower bits within for all of the below (make sure none are swapped when used)
  lda #$88    ;dig_T1 LSB
  jsr TempSpiSendReceive
  sta SPI_Temp_digT1_LSB

  lda #$89    ;dig_T1 MSB
  jsr TempSpiSendReceive
  sta SPI_Temp_digT1_MSB

  lda #$8A    ;dig_T2 LSB
  jsr TempSpiSendReceive
  sta SPI_Temp_digT2_LSB

  lda #$8B    ;dig_T2 MSB
  jsr TempSpiSendReceive
  sta SPI_Temp_digT2_MSB

  lda #$8C    ;dig_T3 LSB
  jsr TempSpiSendReceive
  sta SPI_Temp_digT3_LSB

  lda #$8D    ;dig_T3 MSB
  jsr TempSpiSendReceive
  sta SPI_Temp_digT3_MSB

  lda #$A1    ;dig_H1
  jsr TempSpiSendReceive
  sta SPI_Temp_digH1

  lda #$E1    ;dig_H2 LSB
  jsr TempSpiSendReceive
  sta SPI_Temp_digH2_LSB

  lda #$E2    ;dig_H2 MSB
  jsr TempSpiSendReceive
  sta SPI_Temp_digH2_MSB

  lda #$E3    ;dig_H3
  jsr TempSpiSendReceive
  sta SPI_Temp_digH3

  lda #$E4    ;dig_H4 MSB                                  
  jsr TempSpiSendReceive
  sta SPI_Temp_digH4_MSB

  lda #$E5    ;dig_H4 LSB   ;only lower four bits of HSB  
  jsr TempSpiSendReceive
  sta SPI_Temp_digH4_LSB

  lda #$E5    ;dig_H5 LSB   ;only upper four bits of LSB
  jsr TempSpiSendReceive
  sta SPI_Temp_digH5_LSB

  lda #$E6    ;dig_H5 MSB   
  jsr TempSpiSendReceive
  sta SPI_Temp_digH5_MSB

  lda #$E7    ;dig_H6   
  jsr TempSpiSendReceive
  sta SPI_Temp_digH6

  rts
GetTemperatureChipId:
  
  ;init SPI on VIA3 - PORTA for data, PORTB for control
  
  lda #%11111111    ;all pins output - control
  sta DDR3B

  lda #%11111111    ;all pins output - data
  sta DDR3A

  lda #(OE | SCK | RCK_OUT)     ;#%00000111    ;to do: change to declared variable names with |
  sta PORT3B

  lda #%00000000
  sta PORT3B

  lda #(SCK | RCK_OUT)   ;shift clock and receive/latch clock
  sta PORT3B

  lda #(SLOAD)
  sta PORT3B
  
  lda #$D0    ;chip id register
  sta PORT3A

  lda #(SLOAD | OE | SCK)
  sta PORT3B

  lda #(SLOAD | OE)
  sta PORT3B

  lda #(SLOAD | OE | SCK | RCK_OUT)
  sta PORT3B

  lda #(SLOAD | OE)
  sta PORT3B

  lda #(SLOAD | OE | SCK)
  sta PORT3B

  ;data is latched for out, can now switch to input
  ;read it back in from the receiving SPI to parallel
  ;set VIA PORTA to input
  ;Enable output of 595  with SPI_DEV7
  lda #%00000000    ;all pins input - data
  sta DDR3A

  lda #(SCK)
  sta PORT3B

  lda #(SLOAD | SPI_DEV6 | SCK)
  sta PORT3B

  lda #(SLOAD | SPI_DEV6)
  sta PORT3B

  lda #(SLOAD | SPI_DEV6 | SCK)
  sta PORT3B

  lda #(SLOAD | SPI_DEV6)
  sta PORT3B

  lda #(SLOAD | SPI_DEV6 | SCK)
  sta PORT3B

  lda #(SLOAD | SPI_DEV6)
  sta PORT3B

  lda #(SLOAD | SPI_DEV6 | SCK)
  sta PORT3B

  lda #(SLOAD | SPI_DEV6)
  sta PORT3B

  lda #(SLOAD | SPI_DEV6 | SCK)
  sta PORT3B

  lda #(SLOAD | SPI_DEV6)
  sta PORT3B

  lda #(SLOAD | SPI_DEV6 | SCK)
  sta PORT3B

  lda #(SLOAD | SPI_DEV6)
  sta PORT3B

  lda #(SLOAD | SPI_DEV6 | SCK)
  sta PORT3B

  lda #(SLOAD | SPI_DEV6)
  sta PORT3B

  lda #(SLOAD | SPI_DEV6 | SCK)
  sta PORT3B

  lda #(SLOAD | SPI_DEV6)
  sta PORT3B

  lda #(SLOAD | SPI_DEV6 | SCK)
  sta PORT3B

  lda #(SLOAD | SPI_DEV6)
  sta PORT3B

  lda #(SLOAD | SPI_DEV6 | SCK)
  sta PORT3B

  ;8 more pulses to get return data from SPI device
  ;

  lda #(SCK | SPI_DEV6) 
  sta PORT3B
  lda #(SPI_DEV6 | RCK_IN) 
  sta PORT3B

  lda #(SCK | SPI_DEV6) 
  sta PORT3B
  lda #(SPI_DEV6 | RCK_IN) 
  sta PORT3B

  lda #(SCK | SPI_DEV6) 
  sta PORT3B
  lda #(SPI_DEV6 | RCK_IN) 
  sta PORT3B

  lda #(SCK | SPI_DEV6) 
  sta PORT3B
  lda #(SPI_DEV6 | RCK_IN) 
  sta PORT3B

  lda #(SCK | SPI_DEV6) 
  sta PORT3B
  lda #(SPI_DEV6 | RCK_IN) 
  sta PORT3B

  lda #(SCK | SPI_DEV6) 
  sta PORT3B
  lda #(SPI_DEV6 | RCK_IN) 
  sta PORT3B

  lda #(SCK | SPI_DEV6) 
  sta PORT3B
  lda #(SPI_DEV6 | RCK_IN) 
  sta PORT3B

  lda #(SCK | SPI_DEV6) 
  sta PORT3B
  lda #(SPI_DEV6 | RCK_IN) 
  sta PORT3B

  lda #(SLOAD | SCK | SPI_DEV7)  ;enable inbound shift register''s data output
  sta PORT3B

  lda #(SLOAD | SPI_DEV7)
  sta PORT3B

  lda #(SCK | SPI_DEV7) 
  sta PORT3B

  lda PORT3A
  jsr print_hex_lcd

  rts
GetTemperatureHumdity:

  lda #$00
  sta delayDurationHighByte

  lda #%00000001
  sta SPI_Temp_NewData

  ;lda #$D0    ;chip id register
  ;sta SPI_TempSend_Address
  ;jsr TempSpiSendReceive

  
  jsr Delay
  jsr Delay

  ;not sure why I have to call these two SendCommands, as it should already be done in the InitTempHumidity, but without the extra calls, updates do not happen -- probably bad SPI calls to look into
  lda #$72      ;CTRL_HUM (0xF4 without highest bit to set)      ;the last (right) three bits control humidity sampling (001 = x1 sampling)
  sta SPI_TempSend_Address
  lda #%00000101
  sta SPI_TempSend_Command
  jsr TempSpiSendCommand

  lda #$74      ;CTRL_MEAS (0xF4 without highest bit to set)
  sta SPI_TempSend_Address
  ;lda #%00110111                ;first (left) three bits control temp sampling; next three for pressure sampling; last two for sensor mode
  lda #%10110111                ;first (left) three bits control temp sampling; next three for pressure sampling; last two for sensor mode
  sta SPI_TempSend_Command
  jsr TempSpiSendCommand

  lda #$75      ;CONFIG (0xF5 without highest bit to set) - this probably does not apply to 'normal' mode
  sta SPI_TempSend_Address
  ;lda #%00010000        ;left three = inactive duration; next three = IIR filter; last two = can set 3-wire SPI
  lda #%00001000        ;left three = inactive duration; next three = IIR filter; last two = can set 3-wire SPI
  sta SPI_TempSend_Command
  jsr TempSpiSendCommand

  jsr Delay
  jsr Delay
  jsr Delay
  jsr Delay

  lda #$FA    ;temp msb
  jsr TempSpiSendReceive
  sta SPI_Temp_Current_MSB

  jsr Delay
  jsr Delay

  lda #$FB    ;temp lsb
  jsr TempSpiSendReceive
  sta SPI_Temp_Current_LSB
  
  lda #$FC    ;temp xlsb
  jsr TempSpiSendReceive
  sta SPI_Temp_Current_XLSB

  lda #$FD    ;humidity msb
  jsr TempSpiSendReceive
  sta SPI_Humid_Current_MSB

  jsr Delay

  lda #$FE    ;humidity lsb
  jsr TempSpiSendReceive
  sta SPI_Humid_Current_LSB

  jsr Delay

  rts
TempSpiSendReceive:
  sta $69
  
  lda #%11111111    ;all pins output - control
  sta DDR3B

  lda #%11111111    ;all pins output - data
  sta DDR3A

  lda #(OE | SCK | RCK_OUT) ;#%00000111
  sta PORT3B

  lda #%00000000
  sta PORT3B

  lda #(SCK | RCK_OUT)   ;shift clock and receive/latch clock
  sta PORT3B

  lda #(SLOAD)
  sta PORT3B
  
  lda $69
  sta PORT3A

  lda #(SLOAD | OE)
  sta PORT3B

  lda #(SLOAD | OE | SCK)
  sta PORT3B

  lda #(SLOAD | OE | RCK_OUT)
  sta PORT3B

  lda #(SLOAD | OE | SCK)
  sta PORT3B

  lda #(SLOAD | OE)
  sta PORT3B

  ;data is latched for out, can now switch to input
  ;read it back in from the receiving SPI to parallel
  ;set VIA PORTA to input
  ;Enable output of 595  with SPI_DEV7
  lda #%00000000    ;all pins input - data
  sta DDR3A

  lda #(SCK)
  sta PORT3B

  lda #(SLOAD | SPI_DEV6 | SCK)
  sta PORT3B

  lda #(SLOAD | SPI_DEV6)
  sta PORT3B

  lda #(SLOAD | SPI_DEV6 | SCK)
  sta PORT3B

  lda #(SLOAD | SPI_DEV6)
  sta PORT3B

  lda #(SLOAD | SPI_DEV6 | SCK)
  sta PORT3B

  lda #(SLOAD | SPI_DEV6)
  sta PORT3B

  lda #(SLOAD | SPI_DEV6 | SCK)
  sta PORT3B

  lda #(SLOAD | SPI_DEV6)
  sta PORT3B

  lda #(SLOAD | SPI_DEV6 | SCK)
  sta PORT3B

  lda #(SLOAD | SPI_DEV6)
  sta PORT3B

  lda #(SLOAD | SPI_DEV6 | SCK)
  sta PORT3B

  lda #(SLOAD | SPI_DEV6)
  sta PORT3B

  lda #(SLOAD | SPI_DEV6 | SCK)
  sta PORT3B

  lda #(SLOAD | SPI_DEV6)
  sta PORT3B

  lda #(SLOAD | SPI_DEV6 | SCK)
  sta PORT3B

  lda #(SLOAD | SPI_DEV6)
  sta PORT3B

  lda #(SLOAD | SPI_DEV6 | SCK)
  sta PORT3B

  lda #(SLOAD | SPI_DEV6)
  sta PORT3B

  lda #(SLOAD | SPI_DEV6 | SCK)
  sta PORT3B

  ;8 more pulses to get return data from SPI device
  ;

  lda #(SCK | SPI_DEV6) 
  sta PORT3B
  lda #(SPI_DEV6 | RCK_IN) 
  sta PORT3B

  lda #(SCK | SPI_DEV6) 
  sta PORT3B
  lda #(SPI_DEV6 | RCK_IN) 
  sta PORT3B

  lda #(SCK | SPI_DEV6) 
  sta PORT3B
  lda #(SPI_DEV6 | RCK_IN) 
  sta PORT3B

  lda #(SCK | SPI_DEV6) 
  sta PORT3B
  lda #(SPI_DEV6 | RCK_IN) 
  sta PORT3B

  lda #(SCK | SPI_DEV6) 
  sta PORT3B
  lda #(SPI_DEV6 | RCK_IN) 
  sta PORT3B

  lda #(SCK | SPI_DEV6) 
  sta PORT3B
  lda #(SPI_DEV6 | RCK_IN) 
  sta PORT3B

  lda #(SCK | SPI_DEV6) 
  sta PORT3B
  lda #(SPI_DEV6 | RCK_IN) 
  sta PORT3B

  lda #(SCK | SPI_DEV6) 
  sta PORT3B
  lda #(SPI_DEV6 | RCK_IN) 
  sta PORT3B

  lda #(SLOAD | SCK | SPI_DEV7)  ;enable inbound shift register''s data output
  sta PORT3B

  lda #(SLOAD | SPI_DEV7)
  sta PORT3B

  lda #(SCK | SPI_DEV7) 
  sta PORT3B

  lda PORT3A

  rts
TempSpiSendCommand:
  ;SPI_TempSend_Address
  ;SPI_TempSend_Command
  
  lda #%11111111    ;all pins output - control
  sta DDR3B

  lda #%11111111    ;all pins output - data
  sta DDR3A

  lda #(OE | SCK | RCK_OUT) ;#%00000111
  sta PORT3B

  lda #%00000000
  sta PORT3B

  lda #(SCK)   ;shift clock and receive/latch clock
  sta PORT3B

  lda #(SLOAD)
  sta PORT3B
  
  lda SPI_TempSend_Address
  sta PORT3A

  lda #(SLOAD | OE | SCK)
  sta PORT3B

  lda #(SLOAD | OE)
  sta PORT3B

  lda #(SLOAD | OE | SCK | RCK_OUT)
  sta PORT3B

  lda #(SLOAD | OE)
  sta PORT3B

  lda #(SLOAD | OE | SCK)
  sta PORT3B

  ;data is latched for out, can now switch to input
  ;read it back in from the receiving SPI to parallel
  ;set VIA PORTA to input
  ;Enable output of 595  with SPI_DEV7
  ;lda #%00000000    ;all pins input - data
  ;sta DDR3A

  lda #(SCK)
  sta PORT3B

  lda #(SLOAD | SPI_DEV6 | SCK)
  sta PORT3B

  lda #(SLOAD | SPI_DEV6 | SCK)
  sta PORT3B

  lda #(SLOAD | SPI_DEV6 | SCK)
  sta PORT3B

  lda #(SLOAD | SPI_DEV6)
  sta PORT3B

  lda #(SLOAD | SPI_DEV6 | SCK)
  sta PORT3B

  lda #(SLOAD | SPI_DEV6 | SCK)
  sta PORT3B

  lda #(SLOAD | SPI_DEV6)
  sta PORT3B

  lda #(SLOAD | SPI_DEV6 | SCK)
  sta PORT3B

  lda #(SLOAD | SPI_DEV6)
  sta PORT3B

  lda #(SLOAD | SPI_DEV6 | SCK)
  sta PORT3B

  lda #(SLOAD | SPI_DEV6)
  sta PORT3B

  lda #(SLOAD | SPI_DEV6 | SCK)
  sta PORT3B

  lda #(SLOAD | SPI_DEV6)
  sta PORT3B

  lda #(SLOAD | SPI_DEV6 | SCK)
  sta PORT3B

  lda #(SLOAD | SPI_DEV6)
  sta PORT3B

  lda #(SLOAD | SPI_DEV6 | SCK)
  sta PORT3B

  lda #(SLOAD | SPI_DEV6)
  sta PORT3B

  lda #(SLOAD | SPI_DEV6 | SCK)
  sta PORT3B

  lda #(SLOAD | SPI_DEV6)
  sta PORT3B


  ;******
  lda SPI_TempSend_Command
  sta PORT3A

  lda #(SLOAD | OE | SCK| SPI_DEV6)
  sta PORT3B

  lda #(SLOAD | OE| SPI_DEV6)
  sta PORT3B

  lda #(SLOAD | OE | SCK | RCK_OUT| SPI_DEV6)
  sta PORT3B

  lda #(SLOAD | OE| SPI_DEV6)
  sta PORT3B

  lda #(SLOAD | OE | SCK| SPI_DEV6)
  sta PORT3B

  ;data is latched for out, can now switch to input
  ;read it back in from the receiving SPI to parallel
  ;set VIA PORTA to input
  ;Enable output of 595  with SPI_DEV7
  lda #%00000000    ;all pins input - data
  sta DDR3A

  lda #(SCK| SPI_DEV6)
  sta PORT3B

  lda #(SLOAD | SPI_DEV6 | SCK)
  sta PORT3B

  lda #(SLOAD | SPI_DEV6)
  sta PORT3B

  lda #(SLOAD | SPI_DEV6 | SCK)
  sta PORT3B

  lda #(SLOAD | SPI_DEV6)
  sta PORT3B

  lda #(SLOAD | SPI_DEV6 | SCK)
  sta PORT3B

  lda #(SLOAD | SPI_DEV6)
  sta PORT3B

  lda #(SLOAD | SPI_DEV6 | SCK)
  sta PORT3B

  lda #(SLOAD | SPI_DEV6)
  sta PORT3B

  lda #(SLOAD | SPI_DEV6 | SCK)
  sta PORT3B

  lda #(SLOAD | SPI_DEV6)
  sta PORT3B

  lda #(SLOAD | SPI_DEV6 | SCK)
  sta PORT3B

  lda #(SLOAD | SPI_DEV6)
  sta PORT3B

  lda #(SLOAD | SPI_DEV6 | SCK)
  sta PORT3B

  lda #(SLOAD | SPI_DEV6)
  sta PORT3B

  lda #(SLOAD | SPI_DEV6 | SCK)
  sta PORT3B

  lda #(SLOAD | SPI_DEV6)
  sta PORT3B

  lda #(SLOAD | SPI_DEV6 | SCK)
  sta PORT3B

  lda #(SLOAD | SPI_DEV6)
  sta PORT3B

  lda #(SLOAD | SPI_DEV6 | SCK)
  sta PORT3B

  rts

tempUpdates:

    ;put items on stack, so we can return them
    ;pha ;a to stack
    ;phx ;x to stack
    ;phy ;y to stack

    jsr CalcTempHumidityFromRawData

    ;update temp display
    lda SPI_Calculated_Temp
    sta SPI_LED_VAL1
    lda SPI_Calculated_Humid
    sta SPI_LED_VAL2
    jsr print_dec_spi_led
    ;reset dirtly flag
    lda #$00
    sta SPI_Temp_NewData


    ;return items from stack
    ;ply ;stack to y
    ;plx ;stack to x
    ;pla ;stack to a

    bra loopCont

loop:
  ;sit here and loop, process key presses via interrupts as they come in

  ;Temporarily comment out the following SPI temp sensor section
  ;lda SPI_Temp_NewData
  ;and #%00000001
  ;bne tempUpdates   ;jump if temperature updates
  
  loopCont:
  sei                   ;Set the interrupt disable flag to one.
  lda kb_rptr
  cmp kb_wptr
  cli                   ;Clear Interrupt Disable
  bne key_pressed

  ;Handle KB flags
  jmp Handle_KB_flags
  ;bra loop

CalcTempHumidityFromRawData:
  ;Send data to Mega via serial for calculation

  lda #%00000001
  sta SPI_ExpectingData

  lda #$A0  ;start counting up at this value; higher # = shorter delay
  sta delayDurationHighByte

  ;TO DO test without delays, or shorter delay

  lda #$7B              ;'{' start sequence
  jsr SerialSendByte
  lda #$30              ;'0' command # msb
  jsr SerialSendByte
  ;jsr Delay 
  lda #$31              ;'1' command # lsb
  jsr SerialSendByte
  lda #$3A              ;':'
  jsr SerialSendByte

  lda SPI_Temp_Current_MSB
  jsr SerialSendByte
  lda #$3A              ;':'
  jsr SerialSendByte
  lda SPI_Temp_Current_LSB
  jsr SerialSendByte
  lda #$3A              ;':'
  jsr SerialSendByte 
  lda SPI_Temp_Current_XLSB
  jsr SerialSendByte
  lda #$3A              ;':'
  jsr SerialSendByte

  lda SPI_Humid_Current_MSB
  jsr SerialSendByte
  lda #$3A              ;':'
  jsr SerialSendByte 
  lda SPI_Humid_Current_LSB             ;????
  jsr SerialSendByte
  lda #$3A              ;':'
  jsr SerialSendByte

  lda SPI_Temp_digT1_MSB
  jsr SerialSendByte
  lda #$3A              ;':'
  jsr SerialSendByte 
  lda SPI_Temp_digT1_LSB
  jsr SerialSendByte
  lda #$3A              ;':'
  jsr SerialSendByte
  lda SPI_Temp_digT2_MSB
  jsr SerialSendByte
  lda #$3A              ;':'
  jsr SerialSendByte 
  lda SPI_Temp_digT2_LSB
  jsr SerialSendByte
  lda #$3A              ;':'
  jsr SerialSendByte
  lda SPI_Temp_digT3_MSB
  jsr SerialSendByte
  lda #$3A              ;':'
  jsr SerialSendByte 
  lda SPI_Temp_digT3_LSB
  jsr SerialSendByte
  lda #$3A              ;':'
  jsr SerialSendByte

  lda SPI_Temp_digH1
  jsr SerialSendByte
  lda #$3A              ;':'
  jsr SerialSendByte 
  lda SPI_Temp_digH2_MSB
  jsr SerialSendByte
  lda #$3A              ;':'
  jsr SerialSendByte
  lda SPI_Temp_digH2_LSB
  jsr SerialSendByte
  lda #$3A              ;':'
  jsr SerialSendByte 
  lda SPI_Temp_digH3
  jsr SerialSendByte
  lda #$3A              ;':'
  jsr SerialSendByte
  lda SPI_Temp_digH4_MSB
  jsr SerialSendByte
  lda #$3A              ;':'
  jsr SerialSendByte 
  lda SPI_Temp_digH4_LSB
  jsr SerialSendByte
  lda #$3A              ;':'
  jsr SerialSendByte
  lda SPI_Temp_digH5_MSB
  jsr SerialSendByte
  lda #$3A              ;':'
  jsr SerialSendByte 
  lda SPI_Temp_digH5_LSB
  jsr SerialSendByte
  lda #$3A              ;':'
  jsr SerialSendByte
  lda SPI_Temp_digH6
  jsr SerialSendByte

  lda #$7D              ;'}' end sequence
  jsr SerialSendByte

  rts

 irq:
  ;put items on stack, so we can return them
  pha ;a to stack
  phx ;x to stack
  phy ;y to stack

  ;check interrupts in order of priority
  BIT  IFR1				; Check status register for VIA1        ; PS2 keyboard
  BMI  VIA1_IRQ			; Branch if VIA1 is interrupt source
  
  BIT  IFR3				; Check status register for VIA3        ; ACIA serial
  BMI  VIA3_IRQ			; Branch if VIA3 is interrupt source

  BIT IFR5              ; Check status register for VIA5        ; USB mouse  
  BMI VIA5_IRQ
  
  BIT  IFR2				; Check status register for VIA2        ; joystick
  BMI  VIA2_IRQ			; Branch if VIA2 is interrupt source

  ;Not using any interrupts on VIA4 (IFR4) - SPI

  ;Should never get here unless missing a BIT/BMI for the interrupt source
  jmp irq_done
  
 VIA3_IRQ:               ;Serial ACIA data received | temp sensor data update
  ;check interrupt source on VIA IER (T1, T2, CB1, CB2, SR, CA1, CA2)
  lda IFR3
  and IER3
  asl
  ;BMI T1_handler
  asl
  ;BMI T2_handler
  asl
  bmi VIA3_CB1_handler  ;temperature sensor
  asl
  ;bmi CB2_handler
  asl
  ;bmi SR_handler
  asl
  bmi VIA3_CA1_handler  ;ACIA
  asl
  ;bmi CA2_handler

  jmp irq_done      ;should not get to this line if handlers above are setup
  
 VIA3_CB1_handler:       ;Counter for temperature sensor refresh
  ;jmp irq_done  ;to do take out
  jsr GetTemperatureHumdity
  bit PORT3B        ;reset VIA interrupts CA1, CB1
  jmp irq_done
  
 VIA3_CA1_handler:       ;ACIA
  lda SPI_ExpectingData
  and #%00000001
  bne recvTemp ;jump down if temp, otherwise, process as humidity
  lda ACIA_DATA     
  sta SPI_Calculated_Humid
  jmp CA1_handler_out
  ;fall into recvTemp
  recvTemp:
      lda ACIA_DATA     
      sta SPI_Calculated_Temp
      lda #%00000000
      sta SPI_ExpectingData ;got first byte, next time process other byte
      ;fall into CA1_handler_out
      CA1_handler_out:
          bit ACIA_STATUS   ;reset interrupt of ACIA
          bit PORT3A        ;reset VIA interrupt    ;if running ACIA interrupt direct to 6502 (i.e., no VIA), this step is not necessary
          jmp irq_done
		  
