;General Information
    ; Project for 6502+LCD+PS2+VGA for Ben Eater circuit design
    ; This assembly code developed by rehsd with foundational elements from Ben Eater (others if noted in code)
    ; Last updated September 2021
    ; Assembly code compiled with vasm and uploaded to ROM on 6502 build
    ; Example build command line:
    ;	vasm6502_oldstyle.exe -Fbin -dotdir -wdc02 g10.s -o g10.bin

    ; *** Hardware config ***
    ; W65C02 (Ben), 5.0 MHz
    ; VGA circuit (Ben), 10.0 MHz
    ; PS2 keyboard circuit (Ben)
    ; VIA1 PortA - PS2 keyboard input
    ; VIA1 PortB - 20x04 LCD in 4-bit (nibble) mode
    ; VIA2 PortA - SPI extra control / clock
    ; VIA2 PortB - Mouse input
    ; VIA3 PortA - SPI data
    ; VIA3 PortB - SPI control / clock (using external shift registers)
    ; VIA4 PortA - AY38910 audio data
    ; VIA4 PortB - AY38910 audio control
    ; VIA5 PortA - FPGA VGA Command
    ; VIA5 PortB - FPGA VGA Data

    ; W65C51N ACIA at $4100 (data direct from 6502 data bus)
    ; *** SPI devices ***
        ; BME280 Temp/Humidity/Pressure
        ; 8-char 7-segment LED Display

    ; VGA info
    ; Use X to track the video page
    ; Use Y to track the column in the page
    ; Use A to track pixel color
    ; 'VGA' Resolution: 100 columns x 64 rows (was 75 rows with just VGA circuit, with no 6502 integration)

    ; All calls to the Delay routine are tested with a 6502 clock of ~5.0 MHz. Other clock speeds may require adjusting the duration of the delays.

    ;6502 microprocessor reference: https://www.westerndesigncenter.com/wdc/documentation/w65c02s.pdf
    ;6502 dev reference: http://www.obelisk.me.uk/6502/reference.html
    ;6522 VIA reference: https://www.westerndesigncenter.com/wdc/documentation/w65c22.pdf
    ;2-line LCD display reference:   ;see page 42 of https://eater.net/datasheets/HD44780.pdf
    
    ;VGA color info
        ;	00000000 	0 	#$00    black
        ;	00000001 	1 	#$01    red
        ;	00000010 	2 	#$02    dark red
        ;	00000011 	3	#$03    bright red
        ;	00000100 	4 	#$04    green
        ;	00001000 	8 	#$08    dark green
        ;	00001100 	12 	#$0c    bright green
        ;	00010000 	16 	#$10    blue
        ;	00100000 	32 	#$20    dark blue
        ;	00110000 	48 	#$30    bright blue 
        ;	00111111 	63 	#$3F    white
        ;   Combine bits for other colors

    ; Font: 5x7 fixed   https://fontstruct.com/fontstructions/show/847768/5x7_dot_matrix
    ; Font pixel data is stored in ROM - see charmaps at end of file
    ; Could add additional fonts, up to 8x8 pixels given the initial structure of this code

    ; Video locations start at 20 00. Increment by 00 80 to move down a line.
    ; Example VGA rows:     1 - 20 00
    ;                       2 - 20 80
    ;                       3 - 21 00
    ;                       4 - 21 80
    ;                       5 - 22 00
    ; Possible ranges: 20 00 to 3F FF
    ; See https://github.com/rehsd/VGA-6502/blob/main/Notes

; TO DO
    ; -Improve code commenting :)
    ; -ClearChar subroutine
    ; -Take advantage of 65C02 new instructions (e.g., bra, bbs, phx phy plx ply)
    ; -General code optimization - removal of unecessary calls, better ways of solving problems, ...
    ; -safety code in case text/cursor/drawing is taken outside of screen (video address range) - keyboard, mouse, other
    ; -Clean up variable memory locations
    ; -Clean up capitalization of procedures to be consistent - same with variables, etc.
    ; -Clean up indentation

;Variable declarations / memory-related

vidpage                 = $0000 ; 2 bytes

kb_wptr                 = $0005
kb_rptr                 = $0006
kb_flags                = $0007
kb_flags2               = $0008

char_vp                 = $0010
char_vp_p1              = $0012
char_color              = $0014
char_y_offset           = $0016
char_current_val        = $0018
message_to_process      = $0019
delayDurationHighByte   = $001A     ;Count from this number (high byte) to FF - higher number results in shorter delay
SPI_LED_MSB             = $001B
SPI_LED_LSB             = $001C
SPI_LED_VAL1            = $001D
SPI_LED_VAL2            = $001E

SPI_ARD_Next_Command    = $0020
SPI_ARD_Send_Next_Byte  = $0021

TUNE_PTR_LO             = $0039
TUNE_PTR_HI             = $003A


;other addresses used throughout code
;                         $40, $41  Delay subroutine
;                         $44       Horizontal pixel writing location
;                         $46
;                         $48       Charpixel row stop
;                         $49       Store A while in print_stats
;                         $4A       Store vidpage while in print_stats
;                         $4B       Store vidpage+1 while in print_stats
;                         $4C       Store color while in print_stats
;                         $50       charmap current char byte
;                         $52       charix row loop counter
;                         $54       print string current char to process
;                         $60       Temporarily track incoming cursor x position during procedure call (high)
;                         $61       Temporarily track incoming cursor x position during procedure call (low)
;                         $62       Temporarily track incoming cursor y position during procedure call
;                         $63       FillRegion loop tracking columns
;                         $64       FillRegion loop tracking rows
;                         $65       print_hex_lcd, print_dec_lcd
;                         $66       print_dec_lcd
;                         $67       print_dec_lcd
;                         $68       print_dec_lcd
;                         $69       temp storage in mouse handlers (new testing)
;                         $6A       temp storage in mouse handlers
;                         $6B       print_dec_spi_led
;                         $6C       print_dec_spi_led
;                         $6D       print_dec_spi_led
;                         $6E       print_dec_spi_led

fill_region_start_x     = $A0       ;Horizontal pixel position, 0 to 99
fill_region_start_y     = $A1       ;Vertical pixel position,   0 to 59
fill_region_end_x       = $A2       ;Horizontal pixel position, 0 to 99
fill_region_end_y       = $A3       ;Vertical pixel position,   0 to 59
fill_region_color       = $A4       ;Color for fill,            0 to 63  
jump_to_line_y          = $A5       ;Line to jump to,           0 to 63
pixel_prev_x            = $A6       ;Previous pixel x position  0 to 99
pixel_prev_y            = $A7       ;Previous pixel y position  0 to 63
pixel_prev_color        = $A8       ;Previous pixel COLOR       0 to 63
currently_drawing       = $A9       ;0x01 if yes
fill_region_clk_start_x = $AA       ;when drawing rectangles by using keyboard, joystick, mouse... capture the start of bounds
fill_region_clk_start_y = $AB
mouseFillRegionStarted  = $AC       ;used to track if mouse right-button has been used to mark the start of a region to fill
audio_data_to_write     = $AD       ;used to track when audio config data has been received from Arduino and should be processed in loop:

kb_buffer               = $0200  ; 256-byte kb buffer 0200-02ff

;TO DO map out all memory spaces to ensure no potential overlaps -- where are the gaps?
TonePeriodCourseLA      = $0300     ;0
TonePeriodCourseLB      = $0301
TonePeriodCourseLC      = $0302
TonePeriodCourseLD      = $0303
TonePeriodCourseLE      = $0304
TonePeriodCourseLF      = $0305
TonePeriodFineLA        = $0306
TonePeriodFineLB        = $0307
TonePeriodFineLC        = $0308
TonePeriodFineLD        = $0309
TonePeriodFineLE        = $030A     ;10
TonePeriodFineLF        = $030B
VolumeLA                = $030C
VolumeLB                = $030D
VolumeLC                = $030E
VolumeLD                = $030F
VolumeLE                = $0310
VolumeLF                = $0311
TonePeriodCourseRA      = $0312
TonePeriodCourseRB      = $0313
TonePeriodCourseRC      = $0314     ;20
TonePeriodCourseRD      = $0315
TonePeriodCourseRE      = $0316
TonePeriodCourseRF      = $0317
TonePeriodFineRA        = $0318
TonePeriodFineRB        = $0319
TonePeriodFineRC        = $031A
TonePeriodFineRD        = $031B
TonePeriodFineRE        = $031C
TonePeriodFineRF        = $031D
VolumeRA                = $031E     ;30
VolumeRB                = $031F
VolumeRC                = $0320
VolumeRD                = $0321
VolumeRE                = $0322
VolumeRF                = $0323
NoisePeriodL1           = $0324
EnvelopePeriodCourseL1  = $0325
EnvelopePeriodFineL1    = $0326
EnvelopeShapeCycleL1    = $0327
EnableLeft1             = $0328     ;40
EnableRight1            = $0329
EnableLeft2             = $032A
EnableRight2            = $032B
NoisePeriodR1           = $032C
EnvelopePeriodCourseR1  = $032D
EnvelopePeriodFineR1    = $032E
EnvelopeShapeCycleR1    = $032F
NoisePeriodL2           = $0330
EnvelopePeriodCourseL2  = $0331
EnvelopePeriodFineL2    = $0332     ;50
EnvelopeShapeCycleL2    = $0333
NoisePeriodR2           = $0334
EnvelopePeriodCourseR2  = $0335
EnvelopePeriodFineR2    = $0336
EnvelopeShapeCycleR2    = $0337
SoundDelay              = $0338
Sound_Future1           = $0339
Sound_Future2           = $033A
Sound_Future3           = $033B
Sound_Future4           = $033C     ;60
Sound_Future5           = $033D     
Sound_Future6           = $033E
Sound_EOF               = $033F     ;63 (64th byte... END)
Sound_ROW               = $0340     ;track with 'row' we are in for a sound sequence


;VIAs
;VIA1 Address Line A13		    110000000000000
PORT1B = $6000
PORT1A = $6001
DDR1B  = $6002
DDR1A  = $6003
PCR1   = $600C
IFR1   = $600D
IER1   = $600E

;VIA2 Address Line A12		    101000000000000
PORT2B = $5000
PORT2A = $5001
DDR2B  = $5002
DDR2A  = $5003
PCR2   = $500C
IFR2   = $500D
IER2   = $500E

;VIA3 Address Line A11		    100100000000000
PORT3B = $4800
PORT3A = $4801
DDR3B  = $4802
DDR3A  = $4803
PCR3   = $480C
IFR3   = $480D
IER3   = $480E

;VIA 4 Address Line A10			100010000000000
PORT4B = $4400
PORT4A = $4401
DDR4B  = $4402
DDR4A  = $4403
PCR4   = $440C
IFR4   = $440D
IER4   = $440E
	
;VIA 5 Address Line A09		    100001000000000
PORT5B = $4200
PORT5A = $4201
DDR5B  = $4202
DDR5A  = $4203
T1C_L5 = $4204
T1C_H5 = $4205
T1L_L5 = $4206
T1L_H5 = $4207
T2C_L5 = $4208
T2C_H5 = $4209
SR5    = $420A
ACR5   = $420B
PCR5   = $420C
IFR5   = $420D
IER5   = $420E

;ACIA
;Address Line A08           100000100000000
ACIA_DATA       = $4100         ;A0 and A1 off
ACIA_STATUS     = $4101         ;tied to A0
ACIA_COMMAND    = $4102         ;tied to A1
ACIA_CONTROL    = $4103         ;A0 & A1 on

;for kb_flags
RELEASE                 = %00000001
SHIFT                   = %00000010
ARROW_LEFT              = %00000100
ARROW_RIGHT             = %00001000
ARROW_UP                = %00010000
ARROW_DOWN              = %00100000
NKP5                    = %01000000
NKP_PLUS                = %10000000

;for kb_flags2
NKP_INSERT              = %00000001
NKP_DELETE              = %00000010
NKP_MINUS               = %00000100
NKP_ASTERISK            = %00001000
PRINTSCREEN             = %00010000
;room for four more

E                       = %01000000
RW                      = %00100000
RS                      = %00010000

PIXEL_COL1              = %10000000
PIXEL_COL2              = %01000000
PIXEL_COL3              = %00100000
PIXEL_COL4              = %00010000
PIXEL_COL5              = %00001000

ASCII_CHARMAP           = %11100000

;VIA2 PORTB
MOUSE_UP                 = %00000100     
MOUSE_RIGHT_UP           = %00001000     
MOUSE_RIGHT              = %00001100     
MOUSE_RIGHT_DOWN         = %00010000     
MOUSE_DOWN               = %00010100     
MOUSE_LEFT_DOWN          = %00011000     
MOUSE_LEFT               = %00011100     
MOUSE_LEFT_UP            = %00100000     

MOUSE_CLICK_LEFT         = %00000001
MOUSE_CLICK_MIDDLE       = %00000010     
MOUSE_CLICK_RIGHT        = %00000011     

;VIA2                  ;PORTA
SPI_SCK                = %00000001      ;Used for separate SCK on devices without OE, such as SPI 8 char 7-segment LED display with MAX7219
OEB595                 = %00000010      ;74HC595 serial to parallel shift register OE (SPI to VIA) -- used to be on 74HC138

;VIA3                  ;PORTB
OE                     = %00000001
SCK                    = %00000010
RCK_OUT                = %00000100
SLOAD                  = %00001000
RCK_IN                 = %00010000
SPI_DEV0               = %00000000      ;Leave unused for now -- to toggle away from other SPI_DEVs
SPI_DEV1_DUE           = %00100000      ;was 8 digit 7-segment LED
SPI_DEV2_NANO1         = %01000000      ;Arduino Nano
SPI_DEV3_NANO2         = %01100000
SPI_DEV4_NANO3         = %10000000
SPI_DEV5               = %10100000
SPI_DEV6               = %11000000      ;previously Waveshare BME280 temperature sensor
SPI_DEV7               = %11100000      

TIMER5_1_INTERVAL      = 65535          ;Interrupt every xx ms with 5 MHz 6502

;***** AY38910 *****
;AY1_A9_B                = %00000001        //Used in pre-PCB version
;AY2_A9_B                = %00010000        //Used in pre-PCB version
AY1_BC1                 = %00000001
AY1_BDIR                = %00000010
AY2_BC1                 = %00000100
AY2_BDIR                = %00001000
AY3_BC1                 = %00010000
AY3_BDIR                = %00100000
AY4_BC1                 = %01000000
AY4_BDIR                = %10000000

;Arduino SPI Communication
SPI_ARD_CMD_RESET           = 00        
SPI_ARD_CMD_GETSTATUS       = 01        
SPI_ARD_CMD_GETTWOBYTES     = 02
SPI_ARD_CMD_PRINTSCREEN     = 03
SPI_ARD_CMD_GETSOUNDINFO    = 04


;.org $8000         ;comment here for outlining in Visual Studio editor
  .org $8000
reset:
  sei
  cld
  ldx #$ff          ;initialize stack
  txs

  ;Reset variables
  lda #$00
  sta mouseFillRegionStarted

  ; ******* LCD *******
  ;see page 42 of https://eater.net/datasheets/HD44780.pdf
  ;when running 6502 at ~5.0 MHz (versus 1.0 MHz), sometimes init needs additional call or delay
  jsr lcd_init
  lda #%00101000 ; Set 4-bit mode; 2-line display; 5x8 font     ;See page 24 of HD44780.pdf
  jsr lcd_instruction
  ;call again for higher clock speed setup
  lda #%00101000 ; Set 4-bit mode; 2-line display; 5x8 font     ;See page 24 of HD44780.pdf
  jsr lcd_instruction
  lda #%00001110 ; Display on; cursor on; blink off
  jsr lcd_instruction
  lda #%00000110 ; Increment and shift cursor; don't shift display
  jsr lcd_instruction
  lda #%00000001 ; Clear display
  jsr lcd_instruction
  lda #%00001110 ; Display on; cursor on; blink off
  jsr lcd_instruction


  ; ******* INTERRUPTS *******
  lda #$01	    ;positive edge (in code from Ben)
  sta PCR1		;Set CA1 to positive edge
  
  lda #$00     ;edge negative
  sta PCR2
  sta PCR3
  sta PCR4
  sta PCR5

  ;** Set/Clear   Timer1   Timer2   CB1   CB2   ShiftRegister   CA1   CA2 **
  lda #%10000010	;Enables interrupt CA1 (PS2 keyboard), disables everything else. Set/Clear Timer1 Timer2 CB1 CB2 ShiftRegister CA1 CA2 
  sta IER1

  lda #%10010000    ;Enable CB1 (mouse), disable others. Set/Clear Timer1 Timer2 CB1 CB2 ShiftRegister CA1 CA2 
  sta IER2

  lda #%10001000	;Used to enable CB2 SPI Nano , and disables everything else. Set/Clear Timer1 Timer2 CB1 CB2 ShiftRegister CA1 CA2 
  sta IER3

  lda #%01111111    ;Disable all interrupt for this VIA -- SPI master, so interrupts are not being used
  sta IER4

  lda #%01111111    ;Disable all interrupts for this VIA - FPGA VGA output
  sta IER5
  

  ;set VIA ports input/output
  lda #%11111111 ; Set all pins on port B to output
  sta DDR1B
  lda #%00000000 ; Set all pins on port A to input
  sta DDR1A

  lda #$00      ; Set all pins to input
  ;lda #$ff     ;set as output
  sta DDR2B
  sta DDR2A
  sta DDR3B
  sta DDR3A
  sta DDR4B
  sta DDR4A
  
  lda #$FF       ; Output for FPGA VGA
  sta DDR5B
  sta DDR5A

  ; ******* KEYBOARD *******    init keyboard handling memory
  lda #$00
  sta kb_flags
  sta kb_flags2
  sta kb_wptr
  sta kb_rptr

  ; ******* VGA *******
  jsr InitVideoMemory
  jsr FillBlack

  ;*** Display string to VGA ***
  ;where to place chars and char color - change these locations before calling PrintChar/PrintString
  ;lda #$28
  ;sta char_vp_p1
  ;lda #$80
  ;sta char_vp
  ;lda #$3F  ;white
  ;sta char_color
  ;lda #$5
  ;sta char_y_offset
  ;Display pre-defined message #1
  ;lda #$01
  ;sta message_to_process
  ;jsr PrintString
  
  ;Set message_to_process to 0 when transitioning to dynamic strings/chars (vs. pre-defined, stored messages)
  lda #$00  ;done processing pre-defined strings
  sta message_to_process


  ;jsr LoadScreen       ;Windows logo screen
  jsr InitVideoMemory
  jsr FillBlack
  jsr StartScreen       

  jsr PlayWindowsStartSound
  
  lda #$00
  sta audio_data_to_write
  jsr LoadDynamicSound

  ;starting center pixel for drawing
  lda #50
  sta fill_region_start_x
  lda #31
  sta fill_region_start_y
  lda #%00111100  ;blue green
  sta fill_region_color
  lda #$00
  sta pixel_prev_color
  lda #$00
  sta currently_drawing
  
  jsr DrawPixel
  
  ;jsr SetupTemperatureTimer    ;Call to start a timer interrupt -- Not used, but leaving here as a reminder for future use

  ;jsr spi_led_init              ;Initializes SPI 7-segment display

  ;jsr StartSerial               ;Initializes serial on ACIA
  
  ;lda #$3E  ;>
  ;jsr print_char_lcd
  ;jsr SPI_Ard_GetStatus
  ;jsr SPI_Ard_PrintScreen       ;this will take some time...
  ;lda #$3C  ;<
  ;jsr print_char_lcd
  ;lda #%10101000 ; put cursor at position 40 (next line)
  ;jsr lcd_instruction
  ;lda #$3E  ;>
  ;jsr print_char_lcd
  ;jsr SPI_Ard_GetTwoBytes
  ;lda #$3C  ;<
  ;jsr print_char_lcd

  lda #%00000001 ; Clear display
  jsr lcd_instruction

  lda #$A0  ;start counting up at this value; higher # = shorter delay
  sta delayDurationHighByte

  cli           ;enable interrupts

  lda #%00000001 ; Clear display
  jsr lcd_instruction

  jsr PrintStringLCD   ;Finished message

  ;lda #$00  ;start counting up at this value; higher # = shorter delay
  ;sta delayDurationHighByte

  ;jsr PlayFromROM  ;**to do: need to finish this routine so code continues to the next line

  jmp loop
;timer interrupt vars
    ticks:      .byte 0
    max_ticks:  .byte 0
Sound:
    PlayFromROM:
        ;load the data from ROM in variables
        ;only using 8 bits for address, so only 256kbit available (not using the last 3 bits)
        ;R7 EnableB     --bit7=IOB (IN low Out high) - set low so we can read ROM data on PSG:B             01000000=40
        ;               --bit6=IOA (IN low Out high) - set high so we can write out ROM address on PSG:A
        ;R14(hex) PSG I/O Port A    --write address of ROM  to access
        ;R15(hex) PSG I/O Port B    --read data from ROM at supplied ROM address

        pha ;a to stack
        phx ;x to stack
        phy ;y to stack



        ;update to read 64 bytes and store in vars, then repeat until FF is read
        
            ;lda #$0E    ;Register = I/O port A - write ROM address to be read 
            ;jsr AY1_setreg
            ;lda #$00    ;start at beginning of ROM
            ;jsr AY1_writedata
            ;lda #$0F    ;Register = I/O port B - read address at previously specified ROM address
            ;jsr AY1_setreg
            ;jsr AY1_readdata    ;result in A register
            ;jsr print_hex_lcd  ;show it on LCD
        
       
        ;loop through memory and write to variables
        ;last byte of 64 of end marker (FF if no more data for this item)
        ;start at TonePeriodCourseLA and +1 each iteration

        lda #$07    ;Register = Enable
        jsr AY1_setreg
        lda #%01111000    ;B in (low), A out (high), others enabled (low) = 01000000=40
        jsr AY1_writedata

        lda #$07    ;Register = Enable
        jsr AY2_setreg
        lda #%00111000    ;B in (low), A out (high), others enabled (low) = 01000000=40
        jsr AY2_writedata

        lda #$07    ;Register = Enable
        jsr AY3_setreg
        lda #%00111000    ;B in (low), A out (high), others enabled (low) = 01000000=40
        jsr AY3_writedata

        lda #$07    ;Register = Enable
        jsr AY4_setreg
        lda #%00111000    ;B in (low), A out (high), others enabled (low) = 01000000=40
        jsr AY4_writedata

        ldx #$00
        lda #$00
        sta Sound_ROW   ;start at row 0
        PlayFromROMLoop:

            lda #$0E    ;Register = I/O port A - write ROM address to be read 
            jsr AY1_setreg
            txa ;use x as counter to iterate through ROM
            clc
            adc Sound_ROW   ;starts at 0, will increment if more than one sound row
            jsr print_hex_lcd       ;*******************************************
            jsr AY1_writedata
            ;jsr Delay

            lda #$0F    ;Register = I/O port B - read address at previously specified ROM address
            jsr AY1_setreg
            jsr AY1_readdata    ;result in A register
            sta TonePeriodCourseLA, x

            jsr print_hex_lcd       ;*******************************************
            ;jsr Delay
            
            txa
            jsr print_hex_lcd       ;*******************************************
            ;jsr Delay

            inx
            txa     ;1-63
            
            cmp #$40    ;done with this sequence row
            bne PlayFromROMLoop
            
            ;if done with column loop, play the sound
            jsr UpdateSoundConfig
            

            ;TO DO Delay based on sequence Data
            ;For now, just do a simple delay
            jsr Delay
            jsr Delay
            jsr Delay
            jsr Delay
            jsr Delay
            jsr Delay
            jsr Delay
            jsr Delay
            jsr Delay
            jsr Delay
            jsr Delay
            jsr Delay
            jsr Delay
            jsr Delay
            jsr Delay
            jsr Delay
            jsr Delay
            jsr Delay
            jsr Delay

            ;check if EOF flag is FF, otherwise, loop to next 'row'
            clc
            lda Sound_ROW
            adc #$40            ;increment by 64 to get to the next row in the sequence ;if last row fails to have FF to terminate, will loop around;
                                ;Current implementation - only using 8 bits of address line on ROM, so can only use first 256 addresses - more learn functionality than anything
            sta Sound_ROW
            ldx #$00            ;start at first value in new row
            
            
            lda Sound_EOF ;63 from above
            cmp #$FF
            bne PlayFromROMLoop     ;if FF, we are done with last row.            
            

            ;*************** sound off ***************
            lda #<SND_OFF_ALL
            sta TUNE_PTR_LO
            lda #>SND_OFF_ALL
            sta TUNE_PTR_HI
            jsr AY1_PlayTune
            jsr AY2_PlayTune
            jsr AY3_PlayTune
            jsr AY4_PlayTune

        ply ;stack to y
        plx ;stack to x
        pla ;stack to a
        rts
    PlayWindowsStartSound:
        lda #$60
        sta delayDurationHighByte

        ;init VIA
        lda #$FF
        sta DDR4A
        sta DDR4B

        ;init AY38910 #1
        ;lda #(AY2_A9_B) ;AY1_A9_B not set, therefore AY active. AY2_A9_B set, therefore AY2 disabled
        ;lda #0
        ;sta PORT4B

        ;*************** sound to AY1_2 (SND_RESET) ***************
            lda #<SND_RESET
            sta TUNE_PTR_LO
            lda #>SND_RESET
            sta TUNE_PTR_HI
            jsr AY1_PlayTune
            jsr AY2_PlayTune

        ;*************** sound to AY1_2 (SND_TONE_E6_FLAT_A) ***************
            lda #<SND_TONE_E6_FLAT_A
            sta TUNE_PTR_LO
            lda #>SND_TONE_E6_FLAT_A
            sta TUNE_PTR_HI
            jsr AY1_PlayTune
            jsr AY2_PlayTune
        ;*************** sound to AY1_2 (SND_TONE_F1_C) ***************
            lda #<SND_TONE_F1_C
            sta TUNE_PTR_LO
            lda #>SND_TONE_F1_C
            sta TUNE_PTR_HI
            jsr AY1_PlayTune
            jsr AY2_PlayTune
        ;*************** delay 3 ticks ***************
            jsr Delay
            jsr Delay
            jsr Delay

        ;*************** sound to AY1_2 (SND_OFF_A) ***************
            lda #<SND_OFF_A
            sta TUNE_PTR_LO
            lda #>SND_OFF_A
            sta TUNE_PTR_HI
            jsr AY1_PlayTune
            jsr AY2_PlayTune
        ;*************** sound to AY1_2 (SND_TONE_E5_FLAT_A) ***************
            lda #<SND_TONE_E5_FLAT_A
            sta TUNE_PTR_LO
            lda #>SND_TONE_E5_FLAT_A
            sta TUNE_PTR_HI
            jsr AY1_PlayTune
            jsr AY2_PlayTune
        ;*************** delay 2 ticks ***************
            jsr Delay
            jsr Delay

        ;*************** sound to AY1_2 (SND_TONE_B6_FLAT_A) ***************
            lda #<SND_TONE_B6_FLAT_A
            sta TUNE_PTR_LO
            lda #>SND_TONE_B6_FLAT_A
            sta TUNE_PTR_HI
            jsr AY1_PlayTune
            jsr AY2_PlayTune
        ;*************** delay 3 ticks ***************
            jsr Delay
            jsr Delay
            jsr Delay

        ;*************** sound to AY1_2 (SND_OFF_ALL) ***************
            lda #<SND_OFF_ALL
            sta TUNE_PTR_LO
            lda #>SND_OFF_ALL
            sta TUNE_PTR_HI
            jsr AY1_PlayTune
            jsr AY2_PlayTune
        ;*************** sound to AY1_2 (SND_TONE_A6_FLAT_A) ***************
            lda #<SND_TONE_A6_FLAT_A
            sta TUNE_PTR_LO
            lda #>SND_TONE_A6_FLAT_A
            sta TUNE_PTR_HI
            jsr AY1_PlayTune
            jsr AY2_PlayTune
        ;*************** sound to AY1_2 (SND_OFF_C) ***************
            lda #<SND_OFF_C
            sta TUNE_PTR_LO
            lda #>SND_OFF_C
            sta TUNE_PTR_HI
            jsr AY1_PlayTune
            jsr AY2_PlayTune
        ;*************** sound to AY1_2 (SND_TONE_A2_FLAT_C) ***************
            lda #<SND_TONE_A2_FLAT_C
            sta TUNE_PTR_LO
            lda #>SND_TONE_A2_FLAT_C
            sta TUNE_PTR_HI
            jsr AY1_PlayTune
            jsr AY2_PlayTune
        ;*************** delay 5 ticks ***************
            jsr Delay
            jsr Delay
            jsr Delay
            jsr Delay
            jsr Delay

        ;*************** sound to AY1_2 (SND_OFF_A) ***************
            lda #<SND_OFF_A
            sta TUNE_PTR_LO
            lda #>SND_OFF_A
            sta TUNE_PTR_HI
            jsr AY1_PlayTune    
            jsr AY2_PlayTune
        ;*************** sound to AY1_2 (SND_TONE_E6_FLAT_A) ***************
            lda #<SND_TONE_E6_FLAT_A
            sta TUNE_PTR_LO
            lda #>SND_TONE_E6_FLAT_A
            sta TUNE_PTR_HI
            jsr AY1_PlayTune
            jsr AY2_PlayTune
        ;*************** delay 3 ticks ***************
            jsr Delay
            jsr Delay
            jsr Delay

        ;*************** sound to AY1_2 (SND_OFF_ALL) ***************
            lda #<SND_OFF_ALL
            sta TUNE_PTR_LO
            lda #>SND_OFF_ALL
            sta TUNE_PTR_HI
            jsr AY1_PlayTune
            jsr AY2_PlayTune
        ;*************** sound to AY1_2 (SND_TONE_B6_FLAT_A) ***************
            lda #<SND_TONE_B6_FLAT_A
            sta TUNE_PTR_LO
            lda #>SND_TONE_B6_FLAT_A
            sta TUNE_PTR_HI
            jsr AY1_PlayTune
            jsr AY2_PlayTune
        ;*************** sound to AY1_2 (SND_TONE_E3_FLAT_B) ***************
            lda #<SND_TONE_E3_FLAT_B
            sta TUNE_PTR_LO
            lda #>SND_TONE_E3_FLAT_B
            sta TUNE_PTR_HI
            jsr AY2_PlayTune
            jsr AY1_PlayTune
        ;*************** sound to AY1_2 (SND_TONE_B3_FLAT_C) ***************
            lda #<SND_TONE_B3_FLAT_C
            sta TUNE_PTR_LO
            lda #>SND_TONE_B3_FLAT_C
            sta TUNE_PTR_HI
            jsr AY1_PlayTune
            jsr AY2_PlayTune
        ;*************** delay 8 ticks ***************
            jsr Delay
            jsr Delay
            jsr Delay
            jsr Delay
            jsr Delay
            jsr Delay
            jsr Delay
            jsr Delay

        ;*************** sound to AY1_2 (off) ***************
            lda #<SND_OFF_ALL
            sta TUNE_PTR_LO
            lda #>SND_OFF_ALL
            sta TUNE_PTR_HI
            jsr AY1_PlayTune
            jsr AY2_PlayTune

        rts

        ;temporary testing ****************************************
            ;*************** delay 8 ticks ***************
                jsr Delay
                jsr Delay
                jsr Delay
                jsr Delay
                jsr Delay
                jsr Delay
                jsr Delay
                jsr Delay
            PlayWindowsStartSound_LeftOnly:
                lda #$60
                sta delayDurationHighByte

                ;init VIA
                lda #$FF
                sta DDR4A
                sta DDR4B

                ;init AY38910 #1
                ;lda #(AY2_A9_B) ;AY1_A9_B not set, therefore AY active. AY2_A9_B set, therefore AY2 disabled
                ;lda #0
                ;sta PORT4B

                ;*************** sound to AY1_2 (SND_RESET) ***************
                    lda #<SND_RESET
                    sta TUNE_PTR_LO
                    lda #>SND_RESET
                    sta TUNE_PTR_HI
                    jsr AY1_PlayTune
                    ;jsr AY2_PlayTune

                ;*************** sound to AY1_2 (SND_TONE_E6_FLAT_A) ***************
                    lda #<SND_TONE_E6_FLAT_A
                    sta TUNE_PTR_LO
                    lda #>SND_TONE_E6_FLAT_A
                    sta TUNE_PTR_HI
                    jsr AY1_PlayTune
                    ;jsr AY2_PlayTune
                ;*************** sound to AY1_2 (SND_TONE_F1_C) ***************
                    lda #<SND_TONE_F1_C
                    sta TUNE_PTR_LO
                    lda #>SND_TONE_F1_C
                    sta TUNE_PTR_HI
                    jsr AY1_PlayTune
                    ;jsr AY2_PlayTune
                ;*************** delay 3 ticks ***************
                    jsr Delay
                    jsr Delay
                    jsr Delay

                ;*************** sound to AY1_2 (SND_OFF_A) ***************
                    lda #<SND_OFF_A
                    sta TUNE_PTR_LO
                    lda #>SND_OFF_A
                    sta TUNE_PTR_HI
                    jsr AY1_PlayTune
                    ;jsr AY2_PlayTune
                ;*************** sound to AY1_2 (SND_TONE_E5_FLAT_A) ***************
                    lda #<SND_TONE_E5_FLAT_A
                    sta TUNE_PTR_LO
                    lda #>SND_TONE_E5_FLAT_A
                    sta TUNE_PTR_HI
                    jsr AY1_PlayTune
                    ;jsr AY2_PlayTune
                ;*************** delay 2 ticks ***************
                    jsr Delay
                    jsr Delay

                ;*************** sound to AY1_2 (SND_TONE_B6_FLAT_A) ***************
                    lda #<SND_TONE_B6_FLAT_A
                    sta TUNE_PTR_LO
                    lda #>SND_TONE_B6_FLAT_A
                    sta TUNE_PTR_HI
                    jsr AY1_PlayTune
                    ;jsr AY2_PlayTune
                ;*************** delay 3 ticks ***************
                    jsr Delay
                    jsr Delay
                    jsr Delay

                ;*************** sound to AY1_2 (SND_OFF_ALL) ***************
                    lda #<SND_OFF_ALL
                    sta TUNE_PTR_LO
                    lda #>SND_OFF_ALL
                    sta TUNE_PTR_HI
                    jsr AY1_PlayTune
                    ;jsr AY2_PlayTune
                ;*************** sound to AY1_2 (SND_TONE_A6_FLAT_A) ***************
                    lda #<SND_TONE_A6_FLAT_A
                    sta TUNE_PTR_LO
                    lda #>SND_TONE_A6_FLAT_A
                    sta TUNE_PTR_HI
                    jsr AY1_PlayTune
                    ;jsr AY2_PlayTune
                ;*************** sound to AY1_2 (SND_OFF_C) ***************
                    lda #<SND_OFF_C
                    sta TUNE_PTR_LO
                    lda #>SND_OFF_C
                    sta TUNE_PTR_HI
                    jsr AY1_PlayTune
                    ;jsr AY2_PlayTune
                ;*************** sound to AY1_2 (SND_TONE_A2_FLAT_C) ***************
                    lda #<SND_TONE_A2_FLAT_C
                    sta TUNE_PTR_LO
                    lda #>SND_TONE_A2_FLAT_C
                    sta TUNE_PTR_HI
                    jsr AY1_PlayTune
                    ;jsr AY2_PlayTune
                ;*************** delay 5 ticks ***************
                    jsr Delay
                    jsr Delay
                    jsr Delay
                    jsr Delay
                    jsr Delay

                ;*************** sound to AY1_2 (SND_OFF_A) ***************
                    lda #<SND_OFF_A
                    sta TUNE_PTR_LO
                    lda #>SND_OFF_A
                    sta TUNE_PTR_HI
                    jsr AY1_PlayTune    
                    ;jsr AY2_PlayTune
                ;*************** sound to AY1_2 (SND_TONE_E6_FLAT_A) ***************
                    lda #<SND_TONE_E6_FLAT_A
                    sta TUNE_PTR_LO
                    lda #>SND_TONE_E6_FLAT_A
                    sta TUNE_PTR_HI
                    jsr AY1_PlayTune
                    ;jsr AY2_PlayTune
                ;*************** delay 3 ticks ***************
                    jsr Delay
                    jsr Delay
                    jsr Delay

                ;*************** sound to AY1_2 (SND_OFF_ALL) ***************
                    lda #<SND_OFF_ALL
                    sta TUNE_PTR_LO
                    lda #>SND_OFF_ALL
                    sta TUNE_PTR_HI
                    jsr AY1_PlayTune
                    ;jsr AY2_PlayTune
                ;*************** sound to AY1_2 (SND_TONE_B6_FLAT_A) ***************
                    lda #<SND_TONE_B6_FLAT_A
                    sta TUNE_PTR_LO
                    lda #>SND_TONE_B6_FLAT_A
                    sta TUNE_PTR_HI
                    jsr AY1_PlayTune
                    ;jsr AY2_PlayTune
                ;*************** sound to AY1_2 (SND_TONE_E3_FLAT_B) ***************
                    lda #<SND_TONE_E3_FLAT_B
                    sta TUNE_PTR_LO
                    lda #>SND_TONE_E3_FLAT_B
                    sta TUNE_PTR_HI
                    jsr AY2_PlayTune
                    ;jsr AY1_PlayTune
                ;*************** sound to AY1_2 (SND_TONE_B3_FLAT_C) ***************
                    lda #<SND_TONE_B3_FLAT_C
                    sta TUNE_PTR_LO
                    lda #>SND_TONE_B3_FLAT_C
                    sta TUNE_PTR_HI
                    jsr AY1_PlayTune
                    ;jsr AY2_PlayTune
                ;*************** delay 8 ticks ***************
                    jsr Delay
                    jsr Delay
                    jsr Delay
                    jsr Delay
                    jsr Delay
                    jsr Delay
                    jsr Delay
                    jsr Delay

                ;*************** sound to AY1 (off) ***************
                    lda #<SND_OFF_ALL
                    sta TUNE_PTR_LO
                    lda #>SND_OFF_ALL
                    sta TUNE_PTR_HI
                    jsr AY1_PlayTune
                    jsr AY2_PlayTune
            ;*************** delay 8 ticks ***************
                jsr Delay
                jsr Delay
                jsr Delay
                jsr Delay
                jsr Delay
                jsr Delay
                jsr Delay
                jsr Delay
            PlayWindowsStartSound_RighttOnly:
                lda #$60
                sta delayDurationHighByte

                ;init VIA
                lda #$FF
                sta DDR4A
                sta DDR4B

                ;init AY38910 #1
                ;lda #(AY2_A9_B) ;AY1_A9_B not set, therefore AY active. AY2_A9_B set, therefore AY2 disabled
                ;lda #0
                ;sta PORT4B

                ;*************** sound to AY1_2 (SND_RESET) ***************
                    lda #<SND_RESET
                    sta TUNE_PTR_LO
                    lda #>SND_RESET
                    sta TUNE_PTR_HI
                    ;jsr AY1_PlayTune
                    jsr AY2_PlayTune

                ;*************** sound to AY1_2 (SND_TONE_E6_FLAT_A) ***************
                    lda #<SND_TONE_E6_FLAT_A
                    sta TUNE_PTR_LO
                    lda #>SND_TONE_E6_FLAT_A
                    sta TUNE_PTR_HI
                    ;jsr AY1_PlayTune
                    jsr AY2_PlayTune
                ;*************** sound to AY1_2 (SND_TONE_F1_C) ***************
                    lda #<SND_TONE_F1_C
                    sta TUNE_PTR_LO
                    lda #>SND_TONE_F1_C
                    sta TUNE_PTR_HI
                    ;jsr AY1_PlayTune
                    jsr AY2_PlayTune
                ;*************** delay 3 ticks ***************
                    jsr Delay
                    jsr Delay
                    jsr Delay

                ;*************** sound to AY1_2 (SND_OFF_A) ***************
                    lda #<SND_OFF_A
                    sta TUNE_PTR_LO
                    lda #>SND_OFF_A
                    sta TUNE_PTR_HI
                    ;jsr AY1_PlayTune
                    jsr AY2_PlayTune
                ;*************** sound to AY1_2 (SND_TONE_E5_FLAT_A) ***************
                    lda #<SND_TONE_E5_FLAT_A
                    sta TUNE_PTR_LO
                    lda #>SND_TONE_E5_FLAT_A
                    sta TUNE_PTR_HI
                    ;jsr AY1_PlayTune
                    jsr AY2_PlayTune
                ;*************** delay 2 ticks ***************
                    jsr Delay
                    jsr Delay

                ;*************** sound to AY1_2 (SND_TONE_B6_FLAT_A) ***************
                    lda #<SND_TONE_B6_FLAT_A
                    sta TUNE_PTR_LO
                    lda #>SND_TONE_B6_FLAT_A
                    sta TUNE_PTR_HI
                    ;jsr AY1_PlayTune
                    jsr AY2_PlayTune
                ;*************** delay 3 ticks ***************
                    jsr Delay
                    jsr Delay
                    jsr Delay

                ;*************** sound to AY1_2 (SND_OFF_ALL) ***************
                    lda #<SND_OFF_ALL
                    sta TUNE_PTR_LO
                    lda #>SND_OFF_ALL
                    sta TUNE_PTR_HI
                    ;jsr AY1_PlayTune
                    jsr AY2_PlayTune
                ;*************** sound to AY1_2 (SND_TONE_A6_FLAT_A) ***************
                    lda #<SND_TONE_A6_FLAT_A
                    sta TUNE_PTR_LO
                    lda #>SND_TONE_A6_FLAT_A
                    sta TUNE_PTR_HI
                    ;jsr AY1_PlayTune
                    jsr AY2_PlayTune
                ;*************** sound to AY1_2 (SND_OFF_C) ***************
                    lda #<SND_OFF_C
                    sta TUNE_PTR_LO
                    lda #>SND_OFF_C
                    sta TUNE_PTR_HI
                    ;jsr AY1_PlayTune
                    jsr AY2_PlayTune
                ;*************** sound to AY1_2 (SND_TONE_A2_FLAT_C) ***************
                    lda #<SND_TONE_A2_FLAT_C
                    sta TUNE_PTR_LO
                    lda #>SND_TONE_A2_FLAT_C
                    sta TUNE_PTR_HI
                    ;jsr AY1_PlayTune
                    jsr AY2_PlayTune
                ;*************** delay 5 ticks ***************
                    jsr Delay
                    jsr Delay
                    jsr Delay
                    jsr Delay
                    jsr Delay

                ;*************** sound to AY1_2 (SND_OFF_A) ***************
                    lda #<SND_OFF_A
                    sta TUNE_PTR_LO
                    lda #>SND_OFF_A
                    sta TUNE_PTR_HI
                    ;jsr AY1_PlayTune    
                    jsr AY2_PlayTune
                ;*************** sound to AY1_2 (SND_TONE_E6_FLAT_A) ***************
                    lda #<SND_TONE_E6_FLAT_A
                    sta TUNE_PTR_LO
                    lda #>SND_TONE_E6_FLAT_A
                    sta TUNE_PTR_HI
                    ;jsr AY1_PlayTune
                    jsr AY2_PlayTune
                ;*************** delay 3 ticks ***************
                    jsr Delay
                    jsr Delay
                    jsr Delay

                ;*************** sound to AY1_2 (SND_OFF_ALL) ***************
                    lda #<SND_OFF_ALL
                    sta TUNE_PTR_LO
                    lda #>SND_OFF_ALL
                    sta TUNE_PTR_HI
                    ;jsr AY1_PlayTune
                    jsr AY2_PlayTune
                ;*************** sound to AY1_2 (SND_TONE_B6_FLAT_A) ***************
                    lda #<SND_TONE_B6_FLAT_A
                    sta TUNE_PTR_LO
                    lda #>SND_TONE_B6_FLAT_A
                    sta TUNE_PTR_HI
                    ;jsr AY1_PlayTune
                    jsr AY2_PlayTune
                ;*************** sound to AY1_2 (SND_TONE_E3_FLAT_B) ***************
                    lda #<SND_TONE_E3_FLAT_B
                    sta TUNE_PTR_LO
                    lda #>SND_TONE_E3_FLAT_B
                    sta TUNE_PTR_HI
                    ;jsr AY2_PlayTune
                    jsr AY1_PlayTune
                ;*************** sound to AY1_2 (SND_TONE_B3_FLAT_C) ***************
                    lda #<SND_TONE_B3_FLAT_C
                    sta TUNE_PTR_LO
                    lda #>SND_TONE_B3_FLAT_C
                    sta TUNE_PTR_HI
                    ;jsr AY1_PlayTune
                    jsr AY2_PlayTune
                ;*************** delay 8 ticks ***************
                    jsr Delay
                    jsr Delay
                    jsr Delay
                    jsr Delay
                    jsr Delay
                    jsr Delay
                    jsr Delay
                    jsr Delay

                ;*************** sound to AY1 (off) ***************
                    lda #<SND_OFF_ALL
                    sta TUNE_PTR_LO
                    lda #>SND_OFF_ALL
                    sta TUNE_PTR_HI
                    jsr AY1_PlayTune
                    jsr AY2_PlayTune
            ;*************** delay 8 ticks ***************
                jsr Delay
                jsr Delay
                jsr Delay
                jsr Delay
                jsr Delay
                jsr Delay
                jsr Delay
                jsr Delay
            PlayWindowsStartSound_Split:
                lda #$60
                sta delayDurationHighByte

                ;init VIA
                lda #$FF
                sta DDR4A
                sta DDR4B

                ;init AY38910 #1
                ;lda #(AY2_A9_B) ;AY1_A9_B not set, therefore AY active. AY2_A9_B set, therefore AY2 disabled
                ;lda #0
                ;sta PORT4B

                ;*************** sound to AY1_2 (SND_RESET) ***************
                    lda #<SND_RESET
                    sta TUNE_PTR_LO
                    lda #>SND_RESET
                    sta TUNE_PTR_HI
                    jsr AY1_PlayTune
                    ;jsr AY2_PlayTune

                ;*************** sound to AY1_2 (SND_TONE_E6_FLAT_A) ***************
                    lda #<SND_TONE_E6_FLAT_A
                    sta TUNE_PTR_LO
                    lda #>SND_TONE_E6_FLAT_A
                    sta TUNE_PTR_HI
                    ;jsr AY1_PlayTune
                    jsr AY2_PlayTune
                ;*************** sound to AY1_2 (SND_TONE_F1_C) ***************
                    lda #<SND_TONE_F1_C
                    sta TUNE_PTR_LO
                    lda #>SND_TONE_F1_C
                    sta TUNE_PTR_HI
                    jsr AY1_PlayTune
                    ;jsr AY2_PlayTune
                ;*************** delay 3 ticks ***************
                    jsr Delay
                    jsr Delay
                    ;jsr Delay

                ;*************** sound to AY1_2 (SND_OFF_A) ***************
                    lda #<SND_OFF_A
                    sta TUNE_PTR_LO
                    lda #>SND_OFF_A
                    sta TUNE_PTR_HI
                    ;jsr AY1_PlayTune
                    jsr AY2_PlayTune
                ;*************** sound to AY1_2 (SND_TONE_E5_FLAT_A) ***************
                    lda #<SND_TONE_E5_FLAT_A
                    sta TUNE_PTR_LO
                    lda #>SND_TONE_E5_FLAT_A
                    sta TUNE_PTR_HI
                    ;jsr AY1_PlayTune
                    jsr AY2_PlayTune
                ;*************** delay 2 ticks ***************
                    jsr Delay
                    jsr Delay

                ;*************** sound to AY1_2 (SND_TONE_B6_FLAT_A) ***************
                    lda #<SND_TONE_B6_FLAT_A
                    sta TUNE_PTR_LO
                    lda #>SND_TONE_B6_FLAT_A
                    sta TUNE_PTR_HI
                    ;jsr AY1_PlayTune
                    jsr AY2_PlayTune
                ;*************** delay 3 ticks ***************
                    jsr Delay
                    jsr Delay
                    jsr Delay

                ;*************** sound to AY1_2 (SND_OFF_ALL) ***************
                    lda #<SND_OFF_ALL
                    sta TUNE_PTR_LO
                    lda #>SND_OFF_ALL
                    sta TUNE_PTR_HI
                    jsr AY1_PlayTune
                    ;jsr AY2_PlayTune
                ;*************** sound to AY1_2 (SND_TONE_A6_FLAT_A) ***************
                    lda #<SND_TONE_A6_FLAT_A
                    sta TUNE_PTR_LO
                    lda #>SND_TONE_A6_FLAT_A
                    sta TUNE_PTR_HI
                    ;jsr AY1_PlayTune
                    jsr AY2_PlayTune
                ;*************** sound to AY1_2 (SND_OFF_C) ***************
                    lda #<SND_OFF_C
                    sta TUNE_PTR_LO
                    lda #>SND_OFF_C
                    sta TUNE_PTR_HI
                    jsr AY1_PlayTune
                    ;jsr AY2_PlayTune
                ;*************** sound to AY1_2 (SND_TONE_A2_FLAT_C) ***************
                    lda #<SND_TONE_A2_FLAT_C
                    sta TUNE_PTR_LO
                    lda #>SND_TONE_A2_FLAT_C
                    sta TUNE_PTR_HI
                    jsr AY1_PlayTune
                    ;jsr AY2_PlayTune
                ;*************** delay 5 ticks ***************
                    jsr Delay
                    jsr Delay
                    jsr Delay
                    jsr Delay
                    jsr Delay

                ;*************** sound to AY1_2 (SND_OFF_A) ***************
                    lda #<SND_OFF_A
                    sta TUNE_PTR_LO
                    lda #>SND_OFF_A
                    sta TUNE_PTR_HI
                    ;jsr AY1_PlayTune    
                    jsr AY2_PlayTune
                ;*************** sound to AY1_2 (SND_TONE_E6_FLAT_A) ***************
                    lda #<SND_TONE_E6_FLAT_A
                    sta TUNE_PTR_LO
                    lda #>SND_TONE_E6_FLAT_A
                    sta TUNE_PTR_HI
                    ;jsr AY1_PlayTune
                    jsr AY2_PlayTune
                ;*************** delay 3 ticks ***************
                    jsr Delay
                    jsr Delay
                    jsr Delay

                ;*************** sound to AY1_2 (SND_OFF_ALL) ***************
                    lda #<SND_OFF_ALL
                    sta TUNE_PTR_LO
                    lda #>SND_OFF_ALL
                    sta TUNE_PTR_HI
                    jsr AY1_PlayTune
                    jsr AY2_PlayTune
                ;*************** sound to AY1_2 (SND_TONE_B6_FLAT_A) ***************
                    lda #<SND_TONE_B6_FLAT_A
                    sta TUNE_PTR_LO
                    lda #>SND_TONE_B6_FLAT_A
                    sta TUNE_PTR_HI
                    ;jsr AY1_PlayTune
                    jsr AY2_PlayTune
                ;*************** sound to AY1_2 (SND_TONE_E3_FLAT_B) ***************
                    lda #<SND_TONE_E3_FLAT_B
                    sta TUNE_PTR_LO
                    lda #>SND_TONE_E3_FLAT_B
                    sta TUNE_PTR_HI
                    jsr AY2_PlayTune
                    ;jsr AY1_PlayTune
                ;*************** sound to AY1_2 (SND_TONE_B3_FLAT_C) ***************
                    lda #<SND_TONE_B3_FLAT_C
                    sta TUNE_PTR_LO
                    lda #>SND_TONE_B3_FLAT_C
                    sta TUNE_PTR_HI
                    jsr AY1_PlayTune
                    ;jsr AY2_PlayTune
                ;*************** delay 8 ticks ***************
                    jsr Delay
                    jsr Delay
                    jsr Delay
                    jsr Delay
                    jsr Delay
                    jsr Delay
                    jsr Delay
                    jsr Delay

                ;*************** sound to AY1 (off) ***************
                    lda #<SND_OFF_ALL
                    sta TUNE_PTR_LO
                    lda #>SND_OFF_ALL
                    sta TUNE_PTR_HI
                    jsr AY1_PlayTune
                    jsr AY2_PlayTune
            ;*************** delay 8 ticks ***************
                jsr Delay
                jsr Delay
                jsr Delay
                jsr Delay
                jsr Delay
                jsr Delay
                jsr Delay
                jsr Delay
            PlayWindowsStartSound_Full:
                lda #$60
                sta delayDurationHighByte

                ;init VIA
                lda #$FF
                sta DDR4A
                sta DDR4B

                ;init AY38910 #1
                ;lda #(AY2_A9_B) ;AY1_A9_B not set, therefore AY active. AY2_A9_B set, therefore AY2 disabled
                ;lda #0
                ;sta PORT4B

                ;*************** sound to AY1_2 (SND_RESET) ***************
                    lda #<SND_RESET
                    sta TUNE_PTR_LO
                    lda #>SND_RESET
                    sta TUNE_PTR_HI
                    jsr AY1_PlayTune
                    jsr AY2_PlayTune

                ;*************** sound to AY1_2 (SND_TONE_E6_FLAT_A) ***************
                    lda #<SND_TONE_E6_FLAT_A
                    sta TUNE_PTR_LO
                    lda #>SND_TONE_E6_FLAT_A
                    sta TUNE_PTR_HI
                    jsr AY1_PlayTune
                    jsr AY2_PlayTune
                ;*************** sound to AY1_2 (SND_TONE_F1_C) ***************
                    lda #<SND_TONE_F1_C
                    sta TUNE_PTR_LO
                    lda #>SND_TONE_F1_C
                    sta TUNE_PTR_HI
                    jsr AY1_PlayTune
                    jsr AY2_PlayTune
                ;*************** delay 3 ticks ***************
                    jsr Delay
                    jsr Delay
                    jsr Delay

                ;*************** sound to AY1_2 (SND_OFF_A) ***************
                    lda #<SND_OFF_A
                    sta TUNE_PTR_LO
                    lda #>SND_OFF_A
                    sta TUNE_PTR_HI
                    jsr AY1_PlayTune
                    jsr AY2_PlayTune
                ;*************** sound to AY1_2 (SND_TONE_E5_FLAT_A) ***************
                    lda #<SND_TONE_E5_FLAT_A
                    sta TUNE_PTR_LO
                    lda #>SND_TONE_E5_FLAT_A
                    sta TUNE_PTR_HI
                    jsr AY1_PlayTune
                    jsr AY2_PlayTune
                ;*************** delay 2 ticks ***************
                    jsr Delay
                    jsr Delay

                ;*************** sound to AY1_2 (SND_TONE_B6_FLAT_A) ***************
                    lda #<SND_TONE_B6_FLAT_A
                    sta TUNE_PTR_LO
                    lda #>SND_TONE_B6_FLAT_A
                    sta TUNE_PTR_HI
                    jsr AY1_PlayTune
                    jsr AY2_PlayTune
                ;*************** delay 3 ticks ***************
                    jsr Delay
                    jsr Delay
                    jsr Delay

                ;*************** sound to AY1_2 (SND_OFF_ALL) ***************
                    lda #<SND_OFF_ALL
                    sta TUNE_PTR_LO
                    lda #>SND_OFF_ALL
                    sta TUNE_PTR_HI
                    jsr AY1_PlayTune
                    jsr AY2_PlayTune
                ;*************** sound to AY1_2 (SND_TONE_A6_FLAT_A) ***************
                    lda #<SND_TONE_A6_FLAT_A
                    sta TUNE_PTR_LO
                    lda #>SND_TONE_A6_FLAT_A
                    sta TUNE_PTR_HI
                    jsr AY1_PlayTune
                    jsr AY2_PlayTune
                ;*************** sound to AY1_2 (SND_OFF_C) ***************
                    lda #<SND_OFF_C
                    sta TUNE_PTR_LO
                    lda #>SND_OFF_C
                    sta TUNE_PTR_HI
                    jsr AY1_PlayTune
                    jsr AY2_PlayTune
                ;*************** sound to AY1_2 (SND_TONE_A2_FLAT_C) ***************
                    lda #<SND_TONE_A2_FLAT_C
                    sta TUNE_PTR_LO
                    lda #>SND_TONE_A2_FLAT_C
                    sta TUNE_PTR_HI
                    jsr AY1_PlayTune
                    jsr AY2_PlayTune
                ;*************** delay 5 ticks ***************
                    jsr Delay
                    jsr Delay
                    jsr Delay
                    jsr Delay
                    jsr Delay

                ;*************** sound to AY1_2 (SND_OFF_A) ***************
                    lda #<SND_OFF_A
                    sta TUNE_PTR_LO
                    lda #>SND_OFF_A
                    sta TUNE_PTR_HI
                    jsr AY1_PlayTune    
                    jsr AY2_PlayTune
                ;*************** sound to AY1_2 (SND_TONE_E6_FLAT_A) ***************
                    lda #<SND_TONE_E6_FLAT_A
                    sta TUNE_PTR_LO
                    lda #>SND_TONE_E6_FLAT_A
                    sta TUNE_PTR_HI
                    jsr AY1_PlayTune
                    jsr AY2_PlayTune
                ;*************** delay 3 ticks ***************
                    jsr Delay
                    jsr Delay
                    jsr Delay

                ;*************** sound to AY1_2 (SND_OFF_ALL) ***************
                    lda #<SND_OFF_ALL
                    sta TUNE_PTR_LO
                    lda #>SND_OFF_ALL
                    sta TUNE_PTR_HI
                    jsr AY1_PlayTune
                    jsr AY2_PlayTune
                ;*************** sound to AY1_2 (SND_TONE_B6_FLAT_A) ***************
                    lda #<SND_TONE_B6_FLAT_A
                    sta TUNE_PTR_LO
                    lda #>SND_TONE_B6_FLAT_A
                    sta TUNE_PTR_HI
                    jsr AY1_PlayTune
                    jsr AY2_PlayTune
                ;*************** sound to AY1_2 (SND_TONE_E3_FLAT_B) ***************
                    lda #<SND_TONE_E3_FLAT_B
                    sta TUNE_PTR_LO
                    lda #>SND_TONE_E3_FLAT_B
                    sta TUNE_PTR_HI
                    jsr AY2_PlayTune
                    jsr AY1_PlayTune
                ;*************** sound to AY1_2 (SND_TONE_B3_FLAT_C) ***************
                    lda #<SND_TONE_B3_FLAT_C
                    sta TUNE_PTR_LO
                    lda #>SND_TONE_B3_FLAT_C
                    sta TUNE_PTR_HI
                    jsr AY1_PlayTune
                    jsr AY2_PlayTune
                ;*************** delay 8 ticks ***************
                    jsr Delay
                    jsr Delay
                    jsr Delay
                    jsr Delay
                    jsr Delay
                    jsr Delay
                    jsr Delay
                    jsr Delay

                ;*************** sound to AY1 (off) ***************
                    lda #<SND_OFF_ALL
                    sta TUNE_PTR_LO
                    lda #>SND_OFF_ALL
                    sta TUNE_PTR_HI
                    jsr AY1_PlayTune
                    jsr AY2_PlayTune
            ;end temporary testing ************************************
        ;rts
    LoadDynamicSound:
        lda #$60
        sta delayDurationHighByte

        ;init VIA
        lda #$FF
        sta DDR4A
        sta DDR4B

        ;init AY38910 #1 --is this needed??
        ;lda #(AY2_A9_B) ;AY1_A9_B not set, therefore AY active. AY2_A9_B set, therefore AY2 disabled
        ;lda #0
        ;sta PORT4B

        ;*************** sound to AY1_2 (SND_RESET) ***************
            lda #<SND_RESET
            sta TUNE_PTR_LO
            lda #>SND_RESET
            sta TUNE_PTR_HI
            jsr AY1_PlayTune
            jsr AY2_PlayTune

        ;*************** sound to AY1_2 (SND_OFF_ALL) ***************
        lda #<SND_OFF_ALL
        sta TUNE_PTR_LO
        lda #>SND_OFF_ALL
        sta TUNE_PTR_HI
        jsr AY1_PlayTune
        jsr AY2_PlayTune

        rts 
    UpdateSoundConfig:

        pha ;a to stack
        phx ;x to stack
        phy ;y to stack

        ;***** LEFT AY1 *****

            lda #$00
            jsr AY1_setreg
            lda TonePeriodFineLA
            jsr AY1_writedata

            lda #$01
            jsr AY1_setreg
            lda TonePeriodCourseLA
            jsr AY1_writedata

            lda #$02
            jsr AY1_setreg
            lda TonePeriodFineLB
            jsr AY1_writedata

            lda #$03
            jsr AY1_setreg
            lda TonePeriodCourseLB
            jsr AY1_writedata

            lda #$04
            jsr AY1_setreg
            lda TonePeriodFineLC
            jsr AY1_writedata

            lda #$05
            jsr AY1_setreg
            lda TonePeriodCourseLC
            jsr AY1_writedata

            lda #$06
            jsr AY1_setreg
            lda NoisePeriodL1
            jsr AY1_writedata

            lda #$07
            jsr AY1_setreg
            lda EnableLeft1
            jsr AY1_writedata

            lda #$08
            jsr AY1_setreg
            lda VolumeLA
            jsr AY1_writedata

            lda #$09
            jsr AY1_setreg
            lda VolumeLB
            jsr AY1_writedata

            lda #$0A
            jsr AY1_setreg
            lda VolumeLC
            jsr AY1_writedata

            lda #$0B
            jsr AY1_setreg
            lda EnvelopePeriodFineL1
            jsr AY1_writedata
        
            lda #$0C
            jsr AY1_setreg
            lda EnvelopePeriodCourseL1
            jsr AY1_writedata

            lda #$0D
            jsr AY1_setreg
            lda EnvelopeShapeCycleL1
            jsr AY1_writedata

            ;#$0E - IO Port A
            ;#$0F - IO Port B
        ;***** RIGHT AY2 *****
            lda #$00
            jsr AY2_setreg
            lda TonePeriodFineRA
            jsr AY2_writedata

            lda #$01
            jsr AY2_setreg
            lda TonePeriodCourseRA
            jsr AY2_writedata

            lda #$02
            jsr AY2_setreg
            lda TonePeriodFineRB
            jsr AY2_writedata

            lda #$03
            jsr AY2_setreg
            lda TonePeriodCourseRB
            jsr AY2_writedata

            lda #$04
            jsr AY2_setreg
            lda TonePeriodFineRC
            jsr AY2_writedata

            lda #$05
            jsr AY2_setreg
            lda TonePeriodCourseRC
            jsr AY2_writedata

            lda #$06
            jsr AY2_setreg
            lda NoisePeriodR1
            jsr AY2_writedata

            lda #$07
            jsr AY2_setreg
            lda EnableRight1
            jsr AY2_writedata

            lda #$08
            jsr AY2_setreg
            lda VolumeRA
            jsr AY2_writedata

            lda #$09
            jsr AY2_setreg
            lda VolumeRB
            jsr AY2_writedata

            lda #$0A
            jsr AY2_setreg
            lda VolumeRC
            jsr AY2_writedata

            lda #$0B
            jsr AY2_setreg
            lda EnvelopePeriodFineR1
            jsr AY2_writedata
        
            lda #$0C
            jsr AY2_setreg
            lda EnvelopePeriodCourseR1
            jsr AY2_writedata

            lda #$0D
            jsr AY2_setreg
            lda EnvelopeShapeCycleR1
            jsr AY2_writedata

            ;#$0E - IO Port A
            ;#$0F - IO Port B
        ;***** LEFT AY3 *****

            lda #$00
            jsr AY3_setreg
            lda TonePeriodFineLD
            jsr AY3_writedata

            lda #$01
            jsr AY3_setreg
            lda TonePeriodCourseLD
            jsr AY3_writedata

            lda #$02
            jsr AY3_setreg
            lda TonePeriodFineLE
            jsr AY3_writedata

            lda #$03
            jsr AY3_setreg
            lda TonePeriodCourseLE
            jsr AY3_writedata

            lda #$04
            jsr AY3_setreg
            lda TonePeriodFineLF
            jsr AY3_writedata

            lda #$05
            jsr AY3_setreg
            lda TonePeriodCourseLF
            jsr AY3_writedata

            lda #$06
            jsr AY3_setreg
            lda NoisePeriodL2
            jsr AY3_writedata

            lda #$07
            jsr AY3_setreg
            lda EnableLeft2
            jsr AY3_writedata

            lda #$08
            jsr AY3_setreg
            lda VolumeLD
            jsr AY3_writedata

            lda #$09
            jsr AY3_setreg
            lda VolumeLE
            jsr AY3_writedata

            lda #$0A
            jsr AY3_setreg
            lda VolumeLF
            jsr AY3_writedata

            lda #$0B
            jsr AY3_setreg
            lda EnvelopePeriodFineL2
            jsr AY3_writedata
        
            lda #$0C
            jsr AY3_setreg
            lda EnvelopePeriodCourseL2
            jsr AY3_writedata

            lda #$0D
            jsr AY3_setreg
            lda EnvelopeShapeCycleL2
            jsr AY3_writedata

            ;#$0E - IO Port A
            ;#$0F - IO Port B
        ;***** RIGHT AY4 *****
            lda #$00
            jsr AY4_setreg
            lda TonePeriodFineRD
            jsr AY4_writedata

            lda #$01
            jsr AY4_setreg
            lda TonePeriodCourseRD
            jsr AY4_writedata

            lda #$02
            jsr AY4_setreg
            lda TonePeriodFineRE
            jsr AY4_writedata

            lda #$03
            jsr AY4_setreg
            lda TonePeriodCourseRE
            jsr AY4_writedata

            lda #$04
            jsr AY4_setreg
            lda TonePeriodFineRF
            jsr AY4_writedata

            lda #$05
            jsr AY4_setreg
            lda TonePeriodCourseRF
            jsr AY4_writedata

            lda #$06
            jsr AY4_setreg
            lda NoisePeriodR2
            jsr AY4_writedata

            lda #$07
            jsr AY4_setreg
            lda EnableRight2
            jsr AY4_writedata

            lda #$08
            jsr AY4_setreg
            lda VolumeRD
            jsr AY4_writedata

            lda #$09
            jsr AY4_setreg
            lda VolumeRE
            jsr AY4_writedata

            lda #$0A
            jsr AY4_setreg
            lda VolumeRF
            jsr AY4_writedata

            lda #$0B
            jsr AY4_setreg
            lda EnvelopePeriodFineR2
            jsr AY4_writedata
        
            lda #$0C
            jsr AY4_setreg
            lda EnvelopePeriodCourseR2
            jsr AY4_writedata

            lda #$0D
            jsr AY4_setreg
            lda EnvelopeShapeCycleR2
            jsr AY4_writedata

            ;#$0E - IO Port A
            ;#$0F - IO Port B

        lda #$00
        sta audio_data_to_write
           
        ply ;stack to y
        plx ;stack to x
        pla ;stack to a
    
        rts

    ;The following four AYx sections could be consolidated and more dynamic, using a parameter to specify which AY is active (rather than having four unique sets of routines).
    AY1:
        AY1_PlayTune:
           ldy #0
        AY1_play_loop:
           lda (TUNE_PTR_LO), Y
           cmp #$FF
           bne AY1_play_next
           rts
        AY1_play_next:
           jsr AY1_setreg
           iny
           lda (TUNE_PTR_LO), Y         ;y+1, so this is TUNE_PTR_HIGH
           cmp #$FF
           bne AY1_play_next2
           rts
        AY1_play_next2:
           jsr AY1_writedata
           iny
           jmp AY1_play_loop
           rts
        AY1_setreg:
            jsr AY1_inactive     ; NACT
            sta PORT4A      
            jsr AY1_latch        ; INTAK
            jsr AY1_inactive     ; NACT
            rts
        AY1_writedata:
            jsr AY1_inactive     ; NACT
            sta PORT4A
            jsr AY1_write           ; DWS
            jsr AY1_inactive
            rts
        AY1_inactive:        ; NACT
            ; BDIR  LOW
            ; BC1   LOW
            phx         
            ldx #0     ;A9 high to disable AY -- when adding second AY, will need to set its A9 low (on different port)
            stx PORT4B
            plx         
            rts
        AY1_latch:           ; INTAK
            ; BDIR  HIGH
            ; BC1   HIGH
            phx         
            ldx #(AY1_BDIR | AY1_BC1);  AY_A9_B low to enable AY -- when adding second AY, will need to set its A9 high here to disable it (on different port)
            stx PORT4B
            plx         
            rts
        AY1_write:           ; DWS
            ; BDIR  HIGH
            ; BC1   LOW
            phx         
            ldx #(AY1_BDIR) ;AY_A9_B low to enable AY -- when adding second AY, will need to set its A9 high here to disable it (on different port)
            stx PORT4B
            plx         
            rts
        AY1_readdata:
            phx
            jsr AY1_inactive
            ldx #$00    ;Read
            stx DDR4A
            jsr AY1_read

            lda PORT4A          ;value retrieved from PSG
            ldx #$FF    ;Write
            stx DDR4A
            jsr AY1_inactive
            plx
            rts
        AY1_read:           ; DTB
            ; BDIR  LOW
            ; BC1   HIGH
            phx
            ldx #(AY1_BC1)
            stx PORT4B
            plx
            rts
    AY2:
        AY2_PlayTune:
           ldy #0
        AY2_play_loop:
           lda (TUNE_PTR_LO), Y
           cmp #$FF
           bne AY2_play_next
           rts
        AY2_play_next:
           jsr AY2_setreg
           iny
           lda (TUNE_PTR_LO), Y
           cmp #$FF
           bne AY2_play_next2
           rts
        AY2_play_next2:
           jsr AY2_writedata
           iny
           jmp AY2_play_loop
           rts
        AY2_setreg:
            jsr AY2_inactive     ; NACT
            sta PORT4A      
            jsr AY2_latch        ; INTAK
            jsr AY2_inactive     ; NACT
            rts
        AY2_writedata:
            jsr AY2_inactive     ; NACT
            sta PORT4A
            jsr AY2_write           ; DWS
            jsr AY2_inactive
            rts
        AY2_inactive:        ; NACT
            ; BDIR  LOW
            ; BC1   LOW
            phx         
            ldx #0     ;A9 high to disable AY -- when adding second AY, will need to set its A9 low (on different port)
            stx PORT4B
            plx         
            rts
        AY2_latch:           ; INTAK
            ; BDIR  HIGH
            ; BC1   HIGH
            phx         
            ldx #(AY2_BDIR | AY2_BC1);  AY_A9_B low to enable AY -- when adding second AY, will need to set its A9 high here to disable it (on different port)
            stx PORT4B
            plx         
            rts
        AY2_write:           ; DWS
            ; BDIR  HIGH
            ; BC1   LOW
            phx         
            ldx #(AY2_BDIR) ;AY_A9_B low to enable AY -- when adding second AY, will need to set its A9 high here to disable it (on different port)
            stx PORT4B
            plx         
            rts
        AY2_readdata:
            phx
            jsr AY2_inactive
            ldx #$00    ;Read
            stx DDR4A
            jsr AY2_read

            lda PORT4A
            ;jsr print_dec_lcd
            ldx #$FF    ;Write
            stx DDR4A
            jsr AY2_inactive
            plx
            rts
        AY2_read:           ; DTB
            ; BDIR  LOW
            ; BC1   HIGH
            phx
            ;ldx #(AY2_BC1 | AY1_A9_B)
            ldx #(AY2_BC1)
            stx PORT4B
            plx
            rts
    AY3:
        AY3_PlayTune:
           ldy #0
        AY3_play_loop:
           lda (TUNE_PTR_LO), Y
           cmp #$FF
           bne AY3_play_next
           rts
        AY3_play_next:
           jsr AY3_setreg
           iny
           lda (TUNE_PTR_LO), Y
           cmp #$FF
           bne AY3_play_next2
           rts
        AY3_play_next2:
           jsr AY3_writedata
           iny
           jmp AY3_play_loop
           rts
        AY3_setreg:
            jsr AY3_inactive     ; NACT
            sta PORT4A      
            jsr AY3_latch        ; INTAK
            jsr AY3_inactive     ; NACT
            rts
        AY3_writedata:
            jsr AY3_inactive     ; NACT
            sta PORT4A
            jsr AY3_write           ; DWS
            jsr AY3_inactive
            rts
        AY3_inactive:        ; NACT
            ; BDIR  LOW
            ; BC1   LOW
            phx         
            ldx #0     ;A9 high to disable AY -- when adding second AY, will need to set its A9 low (on different port)
            stx PORT4B
            plx         
            rts
        AY3_latch:           ; INTAK
            ; BDIR  HIGH
            ; BC1   HIGH
            phx         
            ldx #(AY3_BDIR | AY3_BC1);  AY_A9_B low to enable AY -- when adding second AY, will need to set its A9 high here to disable it (on different port)
            stx PORT4B
            plx         
            rts
        AY3_write:           ; DWS
            ; BDIR  HIGH
            ; BC1   LOW
            phx         
            ldx #(AY3_BDIR) ;AY_A9_B low to enable AY -- when adding second AY, will need to set its A9 high here to disable it (on different port)
            stx PORT4B
            plx         
            rts
        AY3_readdata:
            phx
            jsr AY3_inactive
            ldx #$00    ;Read
            stx DDR4A
            jsr AY3_read

            lda PORT4A
            ;jsr print_dec_lcd
            ldx #$FF    ;Write
            stx DDR4A
            jsr AY3_inactive
            plx
            rts
        AY3_read:           ; DTB
            ; BDIR  LOW
            ; BC1   HIGH
            phx
            ;ldx #(AY3_BC1 | AY2_A9_B)
            ldx #(AY3_BC1)
            stx PORT4B
            plx
            rts
    AY4:
        AY4_PlayTune:
           ldy #0
        AY4_play_loop:
           lda (TUNE_PTR_LO), Y
           cmp #$FF
           bne AY4_play_next
           rts
        AY4_play_next:
           jsr AY4_setreg
           iny
           lda (TUNE_PTR_LO), Y
           cmp #$FF
           bne AY4_play_next2
           rts
        AY4_play_next2:
           jsr AY4_writedata
           iny
           jmp AY4_play_loop
           rts
        AY4_setreg:
            jsr AY4_inactive     ; NACT
            sta PORT4A      
            jsr AY4_latch        ; INTAK
            jsr AY4_inactive     ; NACT
            rts
        AY4_writedata:
            jsr AY4_inactive     ; NACT
            sta PORT4A
            jsr AY4_write           ; DWS
            jsr AY4_inactive
            rts
        AY4_inactive:        ; NACT
            ; BDIR  LOW
            ; BC1   LOW
            phx         
            ldx #0     ;A9 high to disable AY -- when adding second AY, will need to set its A9 low (on different port)
            stx PORT4B
            plx         
            rts
        AY4_latch:           ; INTAK
            ; BDIR  HIGH
            ; BC1   HIGH
            phx         
            ldx #(AY4_BDIR | AY4_BC1);  AY_A9_B low to enable AY -- when adding second AY, will need to set its A9 high here to disable it (on different port)
            stx PORT4B
            plx         
            rts
        AY4_write:           ; DWS
            ; BDIR  HIGH
            ; BC1   LOW
            phx         
            ldx #(AY4_BDIR) ;AY_A9_B low to enable AY -- when adding second AY, will need to set its A9 high here to disable it (on different port)
            stx PORT4B
            plx         
            rts
        AY4_readdata:
            phx
            jsr AY4_inactive
            ldx #$00    ;Read
            stx DDR4A
            jsr AY4_read

            lda PORT4A
            ;jsr print_dec_lcd
            ldx #$FF    ;Write
            stx DDR4A
            jsr AY4_inactive
            plx
            rts
        AY4_read:           ; DTB
            ; BDIR  LOW
            ; BC1   HIGH
            phx
            ;ldx #(AY4_BC1 | AY1_A9_B)
            ldx #(AY4_BC1)
            stx PORT4B
            plx
            rts
    WonderfulSounds:    ;)
        SND_RESET:
           .BYTE $00, $00           ;ChanA tone period fine tune
           .BYTE $01, $00           ;ChanA tone period coarse tune
           .BYTE $02, $00           ;ChanB tone period fine tune      
           .BYTE $03, $00           ;ChanB tone period coarse tune
           .BYTE $04, $00           ;ChanC tone period fine tune  
           .BYTE $05, $00           ;ChanC tone period coarse tune
           .BYTE $06, $00           ;Noise Period
           .BYTE $07, $38           ;EnableB        ;all channels enabled, IO set to read for both ports
           .BYTE $08, $0F           ;ChanA amplitude    0F = fixed, max
           .BYTE $09, $0F           ;ChanB amplitude
           .BYTE $0A, $0F           ;ChanC amplitude
           .BYTE $0B, $00           ;Envelope period fine tune
           .BYTE $0C, $00           ;Envelope period coarse tune
           .BYTE $0D, $00           ;Envelope shape cycle
           .BYTE $0E, $00           ;IO Port A
           .BYTE $0F, $00           ;IO Port B
           .BYTE $FF, $FF           ; EOF
        SND_OFF_ALL:
           .BYTE $08, $00           ;ChanA amplitude    0F = fixed, max
           .BYTE $09, $00           ;ChanB amplitude
           .BYTE $0A, $00           ;ChanC amplitude
           .BYTE $FF, $FF                ; EOF
        SND_OFF_A:
           .BYTE $08, $00           ;ChanA amplitude    0F = fixed, max
           .BYTE $FF, $FF           ; EOF
        SND_OFF_B:
           .BYTE $09, $00           ;ChanB amplitude
           .BYTE $FF, $FF           ; EOF
        SND_OFF_C:
           .BYTE $0A, $00           ;ChanC amplitude
           .BYTE $FF, $FF           ; EOF
        SND_TONE_100:
           .BYTE $00, $E2           ;ChanA tone period fine tune
           .BYTE $01, $04           ;ChanA tone period coarse tune
           .BYTE $02, $E2           ;ChanB tone period fine tune      
           .BYTE $03, $04           ;ChanB tone period coarse tune
           .BYTE $04, $E2           ;ChanC tone period fine tune  
           .BYTE $05, $04           ;ChanC tone period coarse tune
           .BYTE $07, $38           ;EnableB
           .BYTE $0A, $0F           ;ChanA amplitude    0F = fixed, max
           .BYTE $0B, $0F           ;ChanB amplitude
           .BYTE $0C, $0F           ;ChanC amplitude
           .BYTE $FF, $FF           ; EOF
        SND_TONE_500:
           .BYTE $00, $FA           ;ChanA tone period fine tune
           .BYTE $01, $00           ;ChanA tone period coarse tune
           .BYTE $02, $FA           ;ChanB tone period fine tune      
           .BYTE $03, $00           ;ChanB tone period coarse tune
           .BYTE $04, $FA           ;ChanC tone period fine tune  
           .BYTE $05, $00           ;ChanC tone period coarse tune
           .BYTE $07, $38           ;EnableB
           .BYTE $08, $0F           ;ChanA amplitude    0F = fixed, max
           .BYTE $09, $0F           ;ChanB amplitude
           .BYTE $0A, $00           ;ChanC amplitude
           .BYTE $FF, $FF           ; EOF
        SND_TONE_1K:
           .BYTE $00, $7D           ;ChanA tone period fine tune
           .BYTE $01, $00           ;ChanA tone period coarse tune
           .BYTE $02, $7D           ;ChanB tone period fine tune      
           .BYTE $03, $00           ;ChanB tone period coarse tune
           .BYTE $04, $7D           ;ChanC tone period fine tune  
           .BYTE $05, $00           ;ChanC tone period coarse tune
           .BYTE $07, $38           ;EnableB
           .BYTE $0A, $0F           ;ChanA amplitude    0F = fixed, max
           .BYTE $0B, $0F           ;ChanB amplitude
           .BYTE $0C, $0F           ;ChanC amplitude
           .BYTE $FF, $FF           ; EOF
        SND_TONE_5K:
           .BYTE $00, $19           ;ChanA tone period fine tune
           .BYTE $01, $00           ;ChanA tone period coarse tune
           .BYTE $02, $19           ;ChanB tone period fine tune      
           .BYTE $03, $00           ;ChanB tone period coarse tune
           .BYTE $04, $19           ;ChanC tone period fine tune  
           .BYTE $05, $00           ;ChanC tone period coarse tune
           .BYTE $07, $38           ;EnableB
           .BYTE $0A, $0F           ;ChanA amplitude    0F = fixed, max
           .BYTE $0B, $0F           ;ChanB amplitude
           .BYTE $0C, $0F           ;ChanC amplitude
           .BYTE $FF, $FF           ; EOF
        SND_TONE_10K:
           .BYTE $00, $0C           ;ChanA tone period fine tune
           .BYTE $01, $00           ;ChanA tone period coarse tune
           .BYTE $02, $0C           ;ChanB tone period fine tune      
           .BYTE $03, $00           ;ChanB tone period coarse tune
           .BYTE $04, $0C           ;ChanC tone period fine tune  
           .BYTE $05, $00           ;ChanC tone period coarse tune
           .BYTE $07, $38           ;EnableB
           .BYTE $0A, $0F           ;ChanA amplitude    0F = fixed, max
           .BYTE $0B, $0F           ;ChanB amplitude
           .BYTE $0C, $0F           ;ChanC amplitude
           .BYTE $FF, $FF           ; EOF
        SND_TONE_15K:
           .BYTE $00, $08           ;ChanA tone period fine tune
           .BYTE $01, $00           ;ChanA tone period coarse tune
           .BYTE $02, $08           ;ChanB tone period fine tune      
           .BYTE $03, $00           ;ChanB tone period coarse tune
           .BYTE $04, $08           ;ChanC tone period fine tune  
           .BYTE $05, $00           ;ChanC tone period coarse tune
           .BYTE $07, $38           ;EnableB
           .BYTE $0A, $0F           ;ChanA amplitude    0F = fixed, max
           .BYTE $0B, $0F           ;ChanB amplitude
           .BYTE $0C, $0F           ;ChanC amplitude
           .BYTE $FF, $FF           ; EOF
        ;Win95 Start
            SND_TONE_B6_FLAT_A:
               .BYTE $00, $43           ;ChanA tone period fine tune
               .BYTE $01, $00           ;ChanA tone period coarse tune
               .BYTE $08, $0F           ;ChanA amplitude    0F = fixed, max
               .BYTE $FF, $FF                ; EOF
            SND_TONE_A6_FLAT_A:
               .BYTE $00, $4B           ;ChanA tone period fine tune
               .BYTE $01, $00           ;ChanA tone period coarse tune
               .BYTE $08, $0F           ;ChanA amplitude    0F = fixed, max
               .BYTE $FF, $FF           ; EOF
            SND_TONE_E6_FLAT_A:
               .BYTE $00, $64           ;ChanA tone period fine tune
               .BYTE $01, $00           ;ChanA tone period coarse tune
               .BYTE $08, $0F           ;ChanA amplitude    0F = fixed, max
               .BYTE $FF, $FF           ; EOF
            ;SND_TONE_G5_A:
            ;    .BYTE $00, $9F           ;ChanA tone period fine tune
            ;    .BYTE $01, $00           ;ChanA tone period coarse tune
            ;    .BYTE $08, $0F           ;ChanA amplitude    0F = fixed, max
            ;    .BYTE $FF, $FF           ; EOF
            SND_TONE_E5_FLAT_A:
               .BYTE $00, $C8           ;ChanA tone period fine tune
               .BYTE $01, $00           ;ChanA tone period coarse tune
               .BYTE $08, $0F           ;ChanA amplitude    0F = fixed, max
               .BYTE $FF, $FF           ; EOF
            SND_TONE_B3_FLAT_C:
               .BYTE $04, $18           ;ChanC tone period fine tune  
               .BYTE $05, $02           ;ChanC tone period coarse tune
               .BYTE $0A, $0F           ;ChanC amplitude
               .BYTE $FF, $FF           ; EOF
            SND_TONE_E3_FLAT_B:
               .BYTE $02, $23           ;ChanB tone period fine tune      
               .BYTE $03, $03           ;ChanB tone period coarse tune
               .BYTE $09, $0F           ;ChanB amplitude
               .BYTE $FF, $FF           ; EOF
            SND_TONE_A2_FLAT_C:
               .BYTE $04, $B3           ;ChanA tone period fine tune
               .BYTE $05, $04           ;ChanA tone period coarse tune
               .BYTE $0A, $0F           ;ChanC amplitude    0F = fixed, max
               .BYTE $FF, $FF           ; EOF
            SND_TONE_F1_C:
               .BYTE $04, $2F           ;ChanC tone period fine tune  
               .BYTE $05, $0B           ;ChanC tone period coarse tune
               .BYTE $0A, $0F           ;ChanC amplitude
               .BYTE $FF, $FF           ; EOF

SPI_Ard_StartSession:
    lda #$FE    ;FE works
    sta delayDurationHighByte

    lda #%11111111    ;all pins output - control
    sta DDR3B
    sta DDR2A         ;VIA2, PORTA added for additional clock/control options

    lda #%11111111    ;all pins output - data
    sta DDR3A

    lda #(OE | SCK | RCK_OUT | SPI_DEV0) ;#%00000111      ;dev0 to toggle others off
    sta PORT3B

    lda #%00000000
    sta PORT3B

    rts
SPI_Ard_EndSession:


    lda #(SLOAD)
    sta PORT3B

    lda #(SLOAD | SCK)
    sta PORT3B

    rts
SPI_Ard_SendCommand:
    jsr Delay

    ;Get the data shifted into the outbound shift register
    lda #(SCK)   ;shift clock and receive/latch clock
    sta PORT3B

    lda #(SLOAD)
    sta PORT3B
  
    lda SPI_ARD_Next_Command    ;data to send (i.e., instruction #)
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

    ;Data is in the shift register, now shift it out
    ;;;;;

    lda #(SCK)
    sta PORT3B


    lda #(SLOAD | SPI_DEV1_DUE | SCK)
    sta PORT3B
    lda #(SPI_SCK)
    sta PORT2A

    lda #(SLOAD | SPI_DEV1_DUE)
    sta PORT3B
    lda #0
    sta PORT2A

    lda #(SLOAD | SPI_DEV1_DUE | SCK)
    sta PORT3B
    lda #(SPI_SCK)
    sta PORT2A

    lda #(SLOAD | SPI_DEV1_DUE)
    sta PORT3B
    lda #0
    sta PORT2A

    lda #(SLOAD | SPI_DEV1_DUE | SCK)
    sta PORT3B
    lda #(SPI_SCK)
    sta PORT2A

    lda #(SLOAD | SPI_DEV1_DUE)
    sta PORT3B
    lda #0
    sta PORT2A

    lda #(SLOAD | SPI_DEV1_DUE | SCK)
    sta PORT3B
    lda #(SPI_SCK)
    sta PORT2A

    lda #(SLOAD | SPI_DEV1_DUE)
    sta PORT3B
    lda #0
    sta PORT2A

    lda #(SLOAD | SPI_DEV1_DUE | SCK)
    sta PORT3B
    lda #(SPI_SCK)
    sta PORT2A

    lda #(SLOAD | SPI_DEV1_DUE)
    sta PORT3B
    lda #0
    sta PORT2A

    lda #(SLOAD | SPI_DEV1_DUE | SCK)
    sta PORT3B
    lda #(SPI_SCK)
    sta PORT2A

    lda #(SLOAD | SPI_DEV1_DUE)
    sta PORT3B
    lda #0
    sta PORT2A

    lda #(SLOAD | SPI_DEV1_DUE | SCK)
    sta PORT3B
    lda #(SPI_SCK)
    sta PORT2A

    lda #(SLOAD | SPI_DEV1_DUE)
    sta PORT3B
    lda #0
    sta PORT2A

    lda #(SLOAD | SPI_DEV1_DUE | SCK)
    sta PORT3B
    lda #(SPI_SCK)
    sta PORT2A

    lda #(SLOAD | SPI_DEV1_DUE)
    sta PORT3B
    lda #0
    sta PORT2A

    ;******

    ;lda #(SLOAD | OE | SCK| SPI_DEV1_DUE)
    ;sta PORT3B

    ;lda #(SLOAD | OE| SPI_DEV1_DUE)
    ;sta PORT3B

    ;lda #(SLOAD | OE | SCK | RCK_OUT| SPI_DEV1_DUE)
    ;sta PORT3B

    ;lda #(SLOAD | OE| SPI_DEV1_DUE)
    ;sta PORT3B

    ;lda #(SLOAD | OE | SCK| SPI_DEV1_DUE)
    ;sta PORT3B

    rts
SPI_Ard_SendByte:
    jsr Delay

    ;Get the data shifted into the outbound shift register
    lda #(SCK)   ;shift clock and receive/latch clock
    sta PORT3B

    lda #(SLOAD)
    sta PORT3B
  
    lda SPI_ARD_Send_Next_Byte    ;byte of data to send
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

    ;Data is in the shift register, now shift it out
    ;;;;;

    lda #(SCK)
    sta PORT3B


    lda #(SLOAD | SPI_DEV1_DUE | SCK)
    sta PORT3B
    lda #(SPI_SCK)
    sta PORT2A

    lda #(SLOAD | SPI_DEV1_DUE)
    sta PORT3B
    lda #0
    sta PORT2A

    lda #(SLOAD | SPI_DEV1_DUE | SCK)
    sta PORT3B
    lda #(SPI_SCK)
    sta PORT2A

    lda #(SLOAD | SPI_DEV1_DUE)
    sta PORT3B
    lda #0
    sta PORT2A

    lda #(SLOAD | SPI_DEV1_DUE | SCK)
    sta PORT3B
    lda #(SPI_SCK)
    sta PORT2A

    lda #(SLOAD | SPI_DEV1_DUE)
    sta PORT3B
    lda #0
    sta PORT2A

    lda #(SLOAD | SPI_DEV1_DUE | SCK)
    sta PORT3B
    lda #(SPI_SCK)
    sta PORT2A

    lda #(SLOAD | SPI_DEV1_DUE)
    sta PORT3B
    lda #0
    sta PORT2A

    lda #(SLOAD | SPI_DEV1_DUE | SCK)
    sta PORT3B
    lda #(SPI_SCK)
    sta PORT2A

    lda #(SLOAD | SPI_DEV1_DUE)
    sta PORT3B
    lda #0
    sta PORT2A

    lda #(SLOAD | SPI_DEV1_DUE | SCK)
    sta PORT3B
    lda #(SPI_SCK)
    sta PORT2A

    lda #(SLOAD | SPI_DEV1_DUE)
    sta PORT3B
    lda #0
    sta PORT2A

    lda #(SLOAD | SPI_DEV1_DUE | SCK)
    sta PORT3B
    lda #(SPI_SCK)
    sta PORT2A

    lda #(SLOAD | SPI_DEV1_DUE)
    sta PORT3B
    lda #0
    sta PORT2A

    lda #(SLOAD | SPI_DEV1_DUE | SCK)
    sta PORT3B
    lda #(SPI_SCK)
    sta PORT2A

    lda #(SLOAD | SPI_DEV1_DUE)
    sta PORT3B
    lda #0
    sta PORT2A

    ;******

    ;lda #(SLOAD | OE | SCK| SPI_DEV1_DUE)
    ;sta PORT3B

    ;lda #(SLOAD | OE| SPI_DEV1_DUE)
    ;sta PORT3B

    ;lda #(SLOAD | OE | SCK | RCK_OUT| SPI_DEV1_DUE)
    ;sta PORT3B

    ;lda #(SLOAD | OE| SPI_DEV1_DUE)
    ;sta PORT3B

    ;lda #(SLOAD | OE | SCK| SPI_DEV1_DUE)
    ;sta PORT3B

    rts 
SPI_Ard_ReceiveByte:

    ;lda #$FE        ;FE works
    ;sta delayDurationHighByte

    ;data is latched for out, can now switch to input
    ;read it back in from the receiving SPI to parallel
    ;set VIA PORTA to input
    
    jsr Delay

    
    lda #%00000000    ;all pins input - data
    sta DDR3A

    lda #(SCK| SPI_DEV1_DUE)
    sta PORT3B

    lda #(SLOAD | SPI_DEV1_DUE | SCK)
    sta PORT3B
    lda #(SPI_SCK)
    sta PORT2A

    lda #(SLOAD | SPI_DEV1_DUE | RCK_IN)
    sta PORT3B
    lda #0
    sta PORT2A

    lda #(SLOAD | SPI_DEV1_DUE | SCK)
    sta PORT3B
    lda #(SPI_SCK)
    sta PORT2A

    lda #(SLOAD | SPI_DEV1_DUE | RCK_IN)
    sta PORT3B
    lda #0
    sta PORT2A

    lda #(SLOAD | SPI_DEV1_DUE | SCK)
    sta PORT3B
    lda #(SPI_SCK)
    sta PORT2A

    lda #(SLOAD | SPI_DEV1_DUE | RCK_IN)
    sta PORT3B
    lda #0
    sta PORT2A

    lda #(SLOAD | SPI_DEV1_DUE | SCK)
    sta PORT3B
    lda #(SPI_SCK)
    sta PORT2A

    lda #(SLOAD | SPI_DEV1_DUE | RCK_IN)
    sta PORT3B
    lda #0
    sta PORT2A

    lda #(SLOAD | SPI_DEV1_DUE | SCK)
    sta PORT3B
    lda #(SPI_SCK)
    sta PORT2A

    lda #(SLOAD | SPI_DEV1_DUE | RCK_IN)
    sta PORT3B
    lda #0
    sta PORT2A

    lda #(SLOAD | SPI_DEV1_DUE | SCK)
    sta PORT3B
    lda #(SPI_SCK)
    sta PORT2A

    lda #(SLOAD | SPI_DEV1_DUE | RCK_IN)
    sta PORT3B
    lda #0
    sta PORT2A

    lda #(SLOAD | SPI_DEV1_DUE | SCK)
    sta PORT3B
    lda #(SPI_SCK)
    sta PORT2A

    lda #(SLOAD | SPI_DEV1_DUE | RCK_IN)
    sta PORT3B
    lda #0
    sta PORT2A

    lda #(SLOAD | SPI_DEV1_DUE | SCK)
    sta PORT3B
    lda #(SPI_SCK)
    sta PORT2A

    lda #(SLOAD | SPI_DEV1_DUE | RCK_IN)
    sta PORT3B
    lda #0
    sta PORT2A

    lda #(SLOAD | SCK)  ;enable inbound shift register''s data output       ; | SPI_DEV7 (now OE595 on PORT2A)
    sta PORT3B

    lda #(OEB595)
    sta PORT2A

    lda #(SLOAD)     ; | SPI_DEV7 (now OE595 on PORT2A)
    sta PORT3B


    lda #(SCK)    ; | SPI_DEV7 (now OE595 on PORT2A)
    sta PORT3B

    lda #(SLOAD | SPI_DEV1_DUE)
    sta PORT3B

    ;lda #$F0
    ;sta delayDurationHighByte

    ;load result into A register. calling procedure can use it.
    lda PORT3A
    


    rts
SPI_Ard_GetStatus:
    jsr SPI_Ard_StartSession
    lda #SPI_ARD_CMD_GETSTATUS
    sta SPI_ARD_Next_Command
    jsr SPI_Ard_SendCommand

    jsr SPI_Ard_ReceiveByte
    jsr print_hex_lcd
    jsr SPI_Ard_EndSession
    rts 
SPI_Ard_GetTwoBytes:
    jsr SPI_Ard_StartSession
    lda #SPI_ARD_CMD_GETTWOBYTES
    sta SPI_ARD_Next_Command
    jsr SPI_Ard_SendCommand

    ;expecting two bytes back       -0 (status)
    jsr SPI_Ard_ReceiveByte
    jsr print_hex_lcd

    ;expecting two bytes back       -1
    jsr SPI_Ard_ReceiveByte
    jsr print_hex_lcd

    ;expecting two bytes back       -2
    jsr SPI_Ard_ReceiveByte
    jsr print_hex_lcd

    jsr SPI_Ard_EndSession
    rts
SPI_Ard_PrintScreen:
    lda #$7D;
    jsr print_char_lcd

    jsr SPI_Ard_StartSession

    lda #SPI_ARD_CMD_PRINTSCREEN
    sta SPI_ARD_Next_Command
    jsr SPI_Ard_SendCommand

    jsr GetPixelColors

    jsr SPI_Ard_EndSession

    lda #$7B;
    jsr print_char_lcd
    rts 
GetPixelColors:
        ;start at beginning of video memory - first row/page
        lda #$20
        sta vidpage + 1
        lda #$00
        sta vidpage
  
        ldx #$20 ; X will count down how many pages of video RAM to go
        ldy #$0 ;Start at first column

        jsr GetRowData	;2000 stored as 00 20
        lda #$20
        sta vidpage + 1
        lda #$80
        sta vidpage
        ldy #$0
        jsr GetRowData
        dex
        GetPixelColorsLoop:
            ;Go to the next page, first column
            inc vidpage + 1
            lda #$00
            sta vidpage
            ldy #$0
  
            jsr GetRowData

            ;Go to the next page, first column
            lda #$80
            sta vidpage
            ldy #$0
  
            jsr GetRowData

            dex		;decrement X, which is used to track how many pages are left to be processed
            bne GetPixelColorsLoop	
            rts
            GetRowData:
                ;get color of pixel at location
                lda (vidpage), y
                sta SPI_ARD_Send_Next_Byte
                jsr SPI_Ard_SendByte
                iny
                tya	;transfer Y to accumulator
                cmp #$64 ; if we cycled through 100 columns	compare A to 0x63 (99)		have worked 0-99 = 100 columns
                bne GetRowData	
                rts
StartSerial:
    ;TO DO - cleanup this procedure - registers A,X,Y
    lda #$A0  ;start counting up at this value; higher # = shorter delay
    sta delayDurationHighByte

    ;RS1            RS0             RWB=low (0)                                 RWB=high (1)
    ; L (0)         L (0)           Write transmit data/shift register          Read receiver data register
    ; L (0)         H (1)           Programmed reset                            Read status register
    ; H (1)         L (0)           Write command register                      Read command register
    ; H (1)         H (1)           Write control register                      Read control register

    ;Command register   7&6=parity, 5=parity mode, 4=echo, 3&2=trx int ctl, 1=irq diabled; 0=data term ready
    lda #%00001001				;No parity, no echo, interrupt
       ;#%00001001
    sta ACIA_COMMAND
    
    ;Control register   7=stop bit, 6&5=world len, 4=recv clk src, 5-7=baud
    ;lda #%00011110				;1 stop bit, 8 data bits, 9600
    ;lda #%00011111				;1 stop bit, 8 data bits, 19200
    lda #%00010000				;1 stop bit, 8 data bits, 115200
    sta ACIA_CONTROL

    writeSerial:
        ldx #0
    next_char:
    wait_txd_empty:  
        lda ACIA_STATUS
        and #$10
        beq wait_txd_empty

        lda serialText,x
        beq serialOut   ;if no more characters to process, jump down
        sta ACIA_DATA
        jsr print_char_lcd
        jsr Delay
        inx
        jmp next_char
    serialOut:
        rts

serialText db "serial init... ", 0

LoadScreen:
  jsr LoadImage

  ;*** Display string to VGA ***
  ;where to place chars and char color - change these locations before calling PrintChar/PrintString
  lda #$37
  sta char_vp_p1
  lda #$00
  sta char_vp

  lda #%00110000  ;blue
  sta char_color
  lda #$0C
  sta char_y_offset
  ;Display pre-defined message #2
  lda #$02
  sta message_to_process
  jsr PrintString

  ;Set to 0 when transitioning to dynamic strings/chars (vs. pre-defined, stored messages)
  lda #$00  ;done processing pre-defined strings
  sta message_to_process

  lda #$A0  ;start counting up at this value; higher # = shorter delay
  sta delayDurationHighByte
  jsr Delay
  jsr LoadAnimate
  jsr LoadAnimate
  jsr LoadAnimate
  rts
LoadAnimate:
      lda #15
      sta fill_region_start_x
      lda #57
      sta fill_region_start_y
      lda #25
      sta fill_region_end_x
      lda #58
      sta fill_region_end_y
      lda #%00010101  ;color
      sta fill_region_color
      jsr FillRegion

      jsr Delay

      lda #27
      sta fill_region_start_x
      lda #57
      sta fill_region_start_y
      lda #37
      sta fill_region_end_x
      lda #58
      sta fill_region_end_y
      lda #%00010101  ;color
      sta fill_region_color
      jsr FillRegion

      jsr Delay

          lda #15
          sta fill_region_start_x
          lda #57
          sta fill_region_start_y
          lda #25
          sta fill_region_end_x
          lda #58
          sta fill_region_end_y
          lda #%00101010  ;color
          sta fill_region_color
          jsr FillRegion

      jsr Delay

      lda #39
      sta fill_region_start_x
      lda #57
      sta fill_region_start_y
      lda #49
      sta fill_region_end_x
      lda #58
      sta fill_region_end_y
      lda #%00010101  ;color
      sta fill_region_color
      jsr FillRegion

      jsr Delay

              lda #15
              sta fill_region_start_x
              lda #57
              sta fill_region_start_y
              lda #25
              sta fill_region_end_x
              lda #58
              sta fill_region_end_y
              lda #%00111111  ;color
              sta fill_region_color
              jsr FillRegion

      jsr Delay

          lda #27
          sta fill_region_start_x
          lda #57
          sta fill_region_start_y
          lda #37
          sta fill_region_end_x
          lda #58
          sta fill_region_end_y
          lda #%00101010  ;color
          sta fill_region_color
          jsr FillRegion

      jsr Delay

      lda #51
      sta fill_region_start_x
      lda #57
      sta fill_region_start_y
      lda #61
      sta fill_region_end_x
      lda #58
      sta fill_region_end_y
      lda #%00010101  ;color
      sta fill_region_color
      jsr FillRegion

      jsr Delay

              lda #27
              sta fill_region_start_x
              lda #57
              sta fill_region_start_y
              lda #37
              sta fill_region_end_x
              lda #58
              sta fill_region_end_y
              lda #%00111111  ;color
              sta fill_region_color
              jsr FillRegion

      jsr Delay

          lda #39
          sta fill_region_start_x
          lda #57
          sta fill_region_start_y
          lda #49
          sta fill_region_end_x
          lda #58
          sta fill_region_end_y
          lda #%00101010  ;color
          sta fill_region_color
          jsr FillRegion

      jsr Delay

      lda #63
      sta fill_region_start_x
      lda #57
      sta fill_region_start_y
      lda #73
      sta fill_region_end_x
      lda #58
      sta fill_region_end_y
      lda #%00010101  ;color
      sta fill_region_color
      jsr FillRegion

      jsr Delay

              lda #39
              sta fill_region_start_x
              lda #57
              sta fill_region_start_y
              lda #49
              sta fill_region_end_x
              lda #58
              sta fill_region_end_y
              lda #%00111111  ;color
              sta fill_region_color
              jsr FillRegion

      jsr Delay

          lda #51
          sta fill_region_start_x
          lda #57
          sta fill_region_start_y
          lda #61
          sta fill_region_end_x
          lda #58
          sta fill_region_end_y
          lda #%00101010  ;color
          sta fill_region_color
          jsr FillRegion

      jsr Delay

      lda #75
      sta fill_region_start_x
      lda #57
      sta fill_region_start_y
      lda #85
      sta fill_region_end_x
      lda #58
      sta fill_region_end_y
      lda #%00010101  ;color
      sta fill_region_color
      jsr FillRegion

      jsr Delay

              lda #51
              sta fill_region_start_x
              lda #57
              sta fill_region_start_y
              lda #61
              sta fill_region_end_x
              lda #58
              sta fill_region_end_y
              lda #%00111111  ;color
              sta fill_region_color
              jsr FillRegion

      jsr Delay

          lda #63
          sta fill_region_start_x
          lda #57
          sta fill_region_start_y
          lda #73
          sta fill_region_end_x
          lda #58
          sta fill_region_end_y
          lda #%00101010  ;color
          sta fill_region_color
          jsr FillRegion

      jsr Delay

          lda #75
          sta fill_region_start_x
          lda #57
          sta fill_region_start_y
          lda #85
          sta fill_region_end_x
          lda #58
          sta fill_region_end_y
          lda #%00101010  ;color
          sta fill_region_color
          jsr FillRegion

      jsr Delay

              lda #63
              sta fill_region_start_x
              lda #57
              sta fill_region_start_y
              lda #73
              sta fill_region_end_x
              lda #58
              sta fill_region_end_y
              lda #%00111111  ;color
              sta fill_region_color
              jsr FillRegion

      jsr Delay

                  lda #75
                  sta fill_region_start_x
                  lda #57
                  sta fill_region_start_y
                  lda #85
                  sta fill_region_end_x
                  lda #58
                  sta fill_region_end_y
                  lda #%00111111  ;color
                  sta fill_region_color
                  jsr FillRegion
  
      jsr Delay
      rts
StartScreen:
  ;fill region test 1 - top left bar
  lda #02
  sta fill_region_start_x
  lda #00
  sta fill_region_start_y
  lda #49
  sta fill_region_end_x
  lda #00
  sta fill_region_end_y
  lda #$03  ;bright red
  sta fill_region_color
  jsr FillRegion

  ;fill region test 2 - top right bar
  lda #50
  sta fill_region_start_x
  lda #00
  sta fill_region_start_y
  lda #98
  sta fill_region_end_x
  lda #00
  sta fill_region_end_y
  lda #$0c  ;bright green
  sta fill_region_color
  jsr FillRegion

  ;fill region test 3 - bottom left bar
  lda #02
  sta fill_region_start_x
  lda #63
  sta fill_region_start_y
  lda #49
  sta fill_region_end_x
  lda #63
  sta fill_region_end_y
  lda #$30  ;bright blue
  sta fill_region_color
  jsr FillRegion

  ;fill region test 4 - bottom right bar
  lda #50
  sta fill_region_start_x
  lda #63
  sta fill_region_start_y
  lda #98
  sta fill_region_end_x
  lda #63
  sta fill_region_end_y
  lda #$3f  ;white
  sta fill_region_color
  jsr FillRegion

  ;fill region test 5  ;left border
  lda #02   ;noise on first columns, so starting at third column (2)
  sta fill_region_start_x
  lda #01
  sta fill_region_start_y
  lda #02
  sta fill_region_end_x
  lda #62
  sta fill_region_end_y
  lda #%00111100        ;teal
  sta fill_region_color
  jsr FillRegion

  ;fill region test 5   ;right border
  lda #98   ;video capture does not pick up column index 99, but LCD does. ??
  sta fill_region_start_x
  lda #01
  sta fill_region_start_y
  lda #98
  sta fill_region_end_x
  lda #62
  sta fill_region_end_y
  lda #%00001111    ;yellow
  sta fill_region_color
  jsr FillRegion

  rts
Handle_Arrow_Up:
  ;put items on stack, so we can return them
  pha ;a to stack
  phx ;x to stack
  ;phy ;y to stack

  ;put old pixel data in current pixel, since the cursor is moving out
  jsr RestoreCurrentPixelInfo

  ;subtract from fill_region_start_y to move the pixel up
  ldx fill_region_start_y
  dex   ;need to dex 80 and manage carry
  stx fill_region_start_y

  sec
  lda vidpage
  sbc #$80
  sta vidpage    
  lda vidpage + 1   ;do not clc... need the carry bit to roll to the second (high) byte
  sbc #$00          ;subtract carry
  sta vidpage + 1

  jsr StorePrevPixelInfo
  jsr DrawPixel

  lda kb_flags
  eor #ARROW_UP  ; flip the arrow bit
  sta kb_flags

  ;return items from stack
  ;ply ;stack to y
  plx ;stack to x
  pla ;stack to a
  jmp loop
Handle_Arrow_Left:

  pha ;a to stack
  phx ;x to stack
  ;phy ;y to stack

  ;put old pixel data in current pixel, since the pointer is moving out
  jsr RestoreCurrentPixelInfo
  ;subtract from fill_region_start_x to move the pixel left
  ldx fill_region_start_x
  dex
  stx fill_region_start_x
  jsr StorePrevPixelInfo
  jsr DrawPixel

  lda kb_flags
  eor #ARROW_LEFT  ; flip the left arrow bit
  sta kb_flags

  ;return items from stack
  ;ply ;stack to y
  plx ;stack to x
  pla ;stack to a

  jmp loop
Handle_Arrow_Right:

  ;put items on stack, so we can return them
  pha ;a to stack
  phx ;x to stack
  ;phy ;y to stack

  ;put old pixel data in current pixel, since the pointer is moving out
  jsr RestoreCurrentPixelInfo
  ;add to fill_region_start_x to move the pixel right
  ldx fill_region_start_x
  inx
  stx fill_region_start_x
  jsr StorePrevPixelInfo
  jsr DrawPixel

  lda kb_flags
  eor #ARROW_RIGHT  ; flip the arrow bit
  sta kb_flags

  ;return items from stack
  ;ply ;stack to y
  plx ;stack to x
  pla ;stack to a

  jmp loop
Handle_KB_flags:
  ;TOOD :?: pha   ;remember A

  ;process arrow keys (would not have been handled in code above, as not ASCII codes)
  lda kb_flags
  bit #ARROW_UP   
  bne Handle_Arrow_Up
  
  bit #ARROW_LEFT 
  bne Handle_Arrow_Left
  
  bit #ARROW_RIGHT  
  bne Handle_Arrow_Right

  bit #ARROW_DOWN   
  bne Handle_Arrow_Down

  bit #NKP5      
  bne Handle_NKP5

  bit #NKP_PLUS
  bne Handle_NKP_Plus
  jmp Handle_KB_flags2
Handle_Arrow_Down:

  ;put items on stack, so we can return them
  pha ;a to stack
  phx ;x to stack
  ;phy ;y to stack

  ;put old pixel data in current pixel, since the pointer is moving out
  jsr RestoreCurrentPixelInfo
  
  ;add to fill_region_start_y to move the pixel down
  ldx fill_region_start_y
  inx   ;need to inx 80 and manage carry
  stx fill_region_start_y

  clc
  lda vidpage
  adc #$80
  sta vidpage    
  lda vidpage + 1   ;do not clc... need the carry bit to roll to the second (high) byte
  adc #$00          ;add carry
  sta vidpage + 1

  jsr StorePrevPixelInfo
  jsr DrawPixel

  lda kb_flags
  eor #ARROW_DOWN  ; flip the arrow bit
  sta kb_flags

  ;return items from stack
  ;ply ;stack to y
  plx ;stack to x
  pla ;stack to a

  jmp loop
Handle_NKP5:
  lda currently_drawing
  cmp #$01
  beq turnDrawingOff
  lda #$01   ;otherwise, turn it on
  jmp handleNKP5_out
  turnDrawingOff:
  lda #$00
  handleNKP5_out:
      sta currently_drawing
      lda kb_flags
      eor #NKP5  ; flip the left arrow bit
      sta kb_flags
      jmp loop
Handle_KB_flags2:
  lda kb_flags2
  bit #NKP_INSERT
  bne Handle_NKP_Insert

  bit #NKP_DELETE
  bne Handle_NKP_Delete

  bit #NKP_MINUS
  bne Handle_NKP_Minus

  bit #NKP_ASTERISK
  bne Handle_NKP_Asterisk

  bit #PRINTSCREEN
  bne Handle_PrintScreen
  
  jmp loop
Handle_NKP_Plus:
    inc fill_region_color
    lda fill_region_color
    cmp #$40
    beq resetColorToZero
    jmp handleNKP_Plus_out
    resetColorToZero:
    lda #$00
    handleNKP_Plus_out:
      sta fill_region_color
      jsr DrawPixel
      lda kb_flags
      eor #NKP_PLUS  ; flip the left arrow bit
      sta kb_flags
      jmp loop
Handle_NKP_Insert:
    lda fill_region_color
    sta pixel_prev_color
    jsr DrawPixel
    lda kb_flags2
    eor #NKP_INSERT
    sta kb_flags2
    jmp loop
Handle_NKP_Delete:
    lda fill_region_color   ;first, save current color
    sta $71
    lda #$00                ;set to black
    sta pixel_prev_color
    jsr DrawPixel
    lda $71
    sta fill_region_color   ;set pixel active color back
    lda kb_flags2
    eor #NKP_DELETE
    sta kb_flags2
    jmp loop
Handle_NKP_Minus:
    ;record region start
    lda fill_region_start_x
    sta fill_region_clk_start_x
    lda fill_region_start_y
    sta fill_region_clk_start_y
    
    lda kb_flags2
    eor #NKP_MINUS
    sta kb_flags2
    jmp loop
Handle_NKP_Asterisk:
    ;draw region   
    ;currently, start of region must be upper left point, with end of region at lower right point (cannot use reverse, or other corners)

    lda fill_region_start_x   ;end shape at current position
    sta fill_region_end_x     ;end is hard-coded for now
    lda fill_region_start_y
    sta fill_region_end_y

    lda fill_region_clk_start_x
    sta fill_region_start_x
    lda fill_region_clk_start_y
    sta fill_region_start_y
      
    lda fill_region_color
    ;sta fill_region_color    ;user current color - should not need to modify
    sta pixel_prev_color      
    jsr FillRegion

    lda kb_flags2
    eor #NKP_ASTERISK
    sta kb_flags2
    jmp loop
Handle_PrintScreen:
    ;sei     //turn off interrupts
    jsr SPI_Ard_PrintScreen
    lda kb_flags2
    eor #PRINTSCREEN
    sta kb_flags2
    ;cli
    jmp loop
key_pressed:
  ;put items on stack, so we can return them
  pha ;a to stack
  phx ;x to stack
  phy ;y to stack

  ldx kb_rptr
  lda kb_buffer, x

  cmp #$0a           ; enter - go to next line
  beq enter_pressed
  cmp #$1b           ; escape - clear display
  beq esc_pressed

  jsr print_char_lcd

  lda kb_buffer, x  ;the char to be displayed
  jsr print_char_vga

  inc kb_rptr

    ;return items from stack
    ply ;stack to y
    plx ;stack to x
    pla ;stack to a
  bra loop
Finished:
  jmp Finished  ;end of the program if sent to this subroutine... sit and spin
loop:
  ;sit here and loop, process key presses via interrupts as they come in

  ;see if there is incoming data config to send to PSGs
  lda audio_data_to_write
  cmp #$01
  bne loopCont; UpdateSoundConfig     ; loopCont ;if no audio config updates, move down to loopCont:, otherwise, jsr to update audio config
    jsr UpdateSoundConfig
  loopCont:
  sei                   ;Set the interrupt disable flag to one.
  lda kb_rptr
  cmp kb_wptr
  cli                   ;Clear Interrupt Disable
  bne key_pressed

  ;Handle KB flags
  jmp Handle_KB_flags
  ;bra loop
enter_pressed:
  ;*** vga ***
  lda vidpage
  sta char_vp
  lda vidpage + 1
  sta char_vp_p1
  lda #$4
  sta char_y_offset

  ;*** lcd ***
  lda #%10101000 ; put cursor at position 40
  jsr lcd_instruction
  inc kb_rptr
  jmp loop
esc_pressed:
  ;*** vga ***
  jsr InitVideoMemory
  jsr FillBlack

  ;*** lcd ***
  lda #%00000001 ; Clear display
  jsr lcd_instruction
  
  inc kb_rptr
  jmp loop
SerialSendByte:
  ;TO DO - cleanup this procedure - registers A,X,Y
  sta $7A
  lda #$A0  ;start counting up at this value; higher # = shorter delay
  sta delayDurationHighByte
  waitTxd_empty:  
    lda ACIA_STATUS
    and #$10
    beq waitTxd_empty
    lda $7A;    char to send
    sta ACIA_DATA
    ;jsr print_char_lcd
    jsr Delay
    rts
StorePrevPixelInfo:
    ;put items on stack, so we can return them
    pha ;a to stack
    phx ;x to stack
    phy ;y to stack

    lda fill_region_start_x
    sta pixel_prev_x
    lda fill_region_start_y
    sta pixel_prev_y
    ldy pixel_prev_x
    ;need the color of the pixel at the location - convert x,y position to memory location 
    lda (vidpage), y        ;issue line
    sta pixel_prev_color

    ;return items from stack
    ply ;stack to y
    plx ;stack to x
    pla ;stack to a
    rts
RestoreCurrentPixelInfo:
    ;put items on stack, so we can return them
    pha ;a to stack
    phx ;x to stack
    phy ;y to stack

    lda fill_region_start_y
    sta jump_to_line_y
    jsr JumpToLine
    ldy fill_region_start_x     ;horizontal pixel location, 0 to 99
    
    ;if not currently drawing, restore pixel, otherwise, paint new color for pixel
    lda currently_drawing
    cmp #$01
    beq newColor
    lda pixel_prev_color
    jmp restoreCurrentPixelExit
    newColor:
      lda fill_region_color
    restoreCurrentPixelExit:
        sta (vidpage), y; write A register (color) to address vidpage + y
        ;return items from stack
    
        ply ;stack to y
        plx ;stack to x
        pla ;stack to a
        rts
lcd_wait:
  pha
  lda #%11110000  ; LCD data is input
  sta DDR1B
lcdbusy:
  lda #RW
  sta PORT1B
  lda #(RW | E)
  sta PORT1B
  lda PORT1B       ; Read high nibble
  pha             ; and put on stack since it has the busy flag
  lda #RW
  sta PORT1B
  lda #(RW | E)
  sta PORT1B
  lda PORT1B       ; Read low nibble
  pla             ; Get high nibble off stack
  and #%00001000
  bne lcdbusy

  lda #RW
  sta PORT1B
  lda #%11111111  ; LCD data is output
  sta DDR1B
  pla
  rts
lcd_init:
  ;wait a bit before initializing the screen - helpful at higher 6502 clock speeds
  jsr  Delay
  jsr  Delay

  ;see page 42 of https://eater.net/datasheets/HD44780.pdf
  lda #%00000010 ; Set 4-bit mode
  sta PORT1B
  jsr  Delay
  ora #E
  sta PORT1B
  jsr  Delay
  and #%00001111
  sta PORT1B

  rts
lcd_instruction:
  ;send an instruction to the 2-line LCD
  jsr lcd_wait
  pha
  lsr
  lsr
  lsr
  lsr            ; Send high 4 bits
  sta PORT1B
  ora #E         ; Set E bit to send instruction
  sta PORT1B
  eor #E         ; Clear E bit
  sta PORT1B
  pla
  and #%00001111 ; Send low 4 bits
  sta PORT1B
  ora #E         ; Set E bit to send instruction
  sta PORT1B
  eor #E         ; Clear E bit
  sta PORT1B
  rts
print_char_lcd:
  ;print a character on the 2-line LCD
  jsr lcd_wait
  pha
  lsr
  lsr
  lsr
  lsr             ; Send high 4 bits
  ora #RS         ; Set RS
  sta PORT1B
  ora #E          ; Set E bit to send instruction
  sta PORT1B
  eor #E          ; Clear E bit
  sta PORT1B
  pla
  and #%00001111  ; Send low 4 bits
  ora #RS         ; Set RS
  sta PORT1B
  ora #E          ; Set E bit to send instruction
  sta PORT1B
  eor #E          ; Clear E bit
  sta PORT1B
  rts
print_hex_lcd:
    ;convert scancode/ascii value/other hex to individual chars and display
    ;e.g., scancode = #$12 (left shift) but want to show '0x12' on LCD
    ;accumulator has the value of the scancode

    ;put items on stack, so we can return them
    pha ;a to stack
    phx ;x to stack
    phy ;y to stack

    sta $65     ;store A so we can keep using original value
    
    ;lda #$30    ;'0'
    ;jsr print_char_lcd
    lda #$78    ;'x'
    jsr print_char_lcd

    ;high nibble
    lda $65
    and #%11110000
    lsr ;shift high nibble to low nibble
    lsr
    lsr
    lsr
    tay
    lda hexOutLookup, y
    jsr print_char_lcd

    ;low nibble
    lda $65
    and #%00001111
    tay
    lda hexOutLookup, y
    jsr print_char_lcd

    ;return items from stack
    ply ;stack to y
    plx ;stack to x
    pla ;stack to a
    rts
print_hex_vga:
    ;convert scancode/ascii value/other hex to individual chars and display
    ;e.g., scancode = #$12 (left shift) but want to show '0x12' on LCD
    ;accumulator has the value of the scancode

    ;put items on stack, so we can return them
    pha ;a to stack
    phx ;x to stack
    phy ;y to stack

    sta $65     ;store A so we can keep using original value
    lda #$30    ;'0'
    jsr print_char_vga
    lda #$78    ;'x'
    jsr print_char_vga

    ;high nibble
    lda $65
    and #%11110000
    lsr ;shift high nibble to low nibble
    lsr
    lsr
    lsr
    tay
    lda hexOutLookup, y
    jsr print_char_vga

    ;low nibble
    lda $65
    and #%00001111
    tay
    lda hexOutLookup, y
    jsr print_char_vga

    ;return items from stack
    ply ;stack to y
    plx ;stack to x
    pla ;stack to a
    rts
print_dec_lcd:
    ;convert scancode/ascii value/other hex to individual chars (as decimals) and display
    ;e.g., scancode = #$12 (left shift) but want to show '018' on LCD
    ;accumulator has the value of the scancode

    ;put items on stack, so we can return them
    pha ;a to stack
    phx ;x to stack
    phy ;y to stack

    sta $65     ;store A so we can keep using original value
    lda #0
    sta $66     ;100s
    sta $67     ;10s
    sta $68     ;1s

    HundredsLoop:
        lda $65
        cmp #100             ; compare 100
        bcc TensLoop         ; if binary < 100, all done with hundreds digit
        lda $65
        sec
        sbc #100
        sta $65             ; subtract 100 and store remainder
        inc $66             ; increment the digit result
        jmp HundredsLoop

    TensLoop:
        lda $65
        cmp #10              ; compare 10
        bcc OnesLoop         ; if binary < 10, all done with tens digit
        lda $65
        sec
        sbc #10
        sta $65              ; subtract 10, store remainder
        inc $67              ; increment the digit result
        jmp TensLoop

    OnesLoop:
        lda $65
        sta $68        ; copy what is remaining for singles digit

    ;output the three digits
    ldy $66
    lda hexOutLookup, y
    jsr print_char_lcd
    ldy $67
    lda hexOutLookup, y
    jsr print_char_lcd
    ldy $68
    lda hexOutLookup, y
    jsr print_char_lcd
    
    ;return items from stack
    ply ;stack to y
    plx ;stack to x
    pla ;stack to a
    rts
print_stats:
    ;put items on stack, so we can return them
    pha ;a to stack
    phx ;x to stack
    phy ;y to stack
    sta $49     ;A

    lda vidpage
    sta $4A
    lda vidpage+1
    sta $4B
    lda char_color
    sta $4C

    lda fill_region_start_x
    sta $5A
    lda fill_region_start_y
    sta $5B
    lda fill_region_end_x
    sta $5C
    lda fill_region_end_y
    sta $5D
    lda fill_region_color
    sta $5E

    ;clear the stats area
    lda #80
    sta fill_region_start_x
    lda #55
    sta fill_region_start_y
    lda #97
    sta fill_region_end_x     ;end is hard-coded for now
    lda #62
    sta fill_region_end_y
    lda #$00  ;black
    sta fill_region_color
    jsr FillRegion

    ;where to place chars and char color - change these locations before calling PrintChar
    lda #$3B
    sta char_vp_p1
    lda #$00
    sta char_vp
    lda #%00101010  ;the color for stats
    sta char_color
    lda #$4A
    sta char_y_offset
    lda $49     ;get value of A coming into this routine
    jsr print_hex_vga   ;print it to the screen

    lda $5A
    sta fill_region_start_x
    lda $5B
    sta fill_region_start_y
    lda $5C
    sta fill_region_end_x
    lda $5D
    sta fill_region_end_y
    lda $5E
    sta fill_region_color

    lda $4A
    sta vidpage
    lda $4B
    sta vidpage+1
    lda $4C
    sta char_color
    ;return items from stack
    ply ;stack to y
    plx ;stack to x
    pla ;stack to a

    rts
irq_done:
  ;return items from stack
  ply ;stack to y
  plx ;stack to x
  pla ;stack to a
  rti
VIA2_CB1_handler2:
  lda $6A
  eor #MOUSE_LEFT_UP
  beq Handle_Mouse_Left_Up

  lda $6A
  eor #MOUSE_RIGHT_UP
  beq Handle_Mouse_Right_Up
  
  lda $6A
  eor #MOUSE_RIGHT_DOWN
  beq Handle_Mouse_Right_Down

  lda $6A
  eor #MOUSE_LEFT_DOWN
  beq Handle_Mouse_Left_Down

  jmp VIA2_CB1_handler3
Handle_Mouse_Left_Up:
    jsr RestoreCurrentPixelInfo
    ldx fill_region_start_x
    dex
    stx fill_region_start_x
    jsr StorePrevPixelInfo  ;can this be skipped?
    ;jsr DrawPixel           ;can this be skipped?
    

    ;put old pixel data in current pixel, since the cursor is moving out
    jsr RestoreCurrentPixelInfo

    ;subtract from fill_region_start_y to move the pixel up
    ldx fill_region_start_y
    dex   ;need to dex 80 and manage carry
    stx fill_region_start_y

    sec
    lda vidpage
    sbc #$80
    sta vidpage    
    lda vidpage + 1   ;do not clc... need the carry bit to roll to the second (high) byte
    sbc #$00          ;subtract carry
    sta vidpage + 1

    jsr StorePrevPixelInfo
    jsr DrawPixel

    jmp VIA2_CB1_handler3
    ;jmp VIA2_IRQ_OUT
Handle_Mouse_Right_Up:
    ;put old pixel data in current pixel, since the pointer is moving out
    jsr RestoreCurrentPixelInfo
    ;add to fill_region_start_x to move the pixel right
    ldx fill_region_start_x
    inx
    stx fill_region_start_x
    jsr StorePrevPixelInfo
    ;jsr DrawPixel

    ;put old pixel data in current pixel, since the cursor is moving out
    jsr RestoreCurrentPixelInfo

    ;subtract from fill_region_start_y to move the pixel up
    ldx fill_region_start_y
    dex   ;need to dex 80 and manage carry
    stx fill_region_start_y

    sec
    lda vidpage
    sbc #$80
    sta vidpage    
    lda vidpage + 1   ;do not clc... need the carry bit to roll to the second (high) byte
    sbc #$00          ;subtract carry
    sta vidpage + 1

    jsr StorePrevPixelInfo
    jsr DrawPixel

    jmp VIA2_CB1_handler3
    ;jmp VIA2_IRQ_OUT
Handle_Mouse_Right_Down:
    ;put old pixel data in current pixel, since the pointer is moving out
    jsr RestoreCurrentPixelInfo
    ;add to fill_region_start_x to move the pixel right
    ldx fill_region_start_x
    inx
    stx fill_region_start_x
    jsr StorePrevPixelInfo
    ;jsr DrawPixel

    ;put old pixel data in current pixel, since the pointer is moving out
    jsr RestoreCurrentPixelInfo
  
    ;add to fill_region_start_y to move the pixel down
    ldx fill_region_start_y
    inx   ;need to inx 80 and manage carry
    stx fill_region_start_y

    clc
    lda vidpage
    adc #$80
    sta vidpage    
    lda vidpage + 1   ;do not clc... need the carry bit to roll to the second (high) byte
    adc #$00          ;add carry
    sta vidpage + 1

    jsr StorePrevPixelInfo
    jsr DrawPixel

    jmp VIA2_CB1_handler3
    ;jmp VIA2_IRQ_OUT
Handle_Mouse_Left_Down:
    jsr RestoreCurrentPixelInfo
    ldx fill_region_start_x
    dex
    stx fill_region_start_x
    jsr StorePrevPixelInfo
    ;jsr DrawPixel

    ;put old pixel data in current pixel, since the pointer is moving out
    jsr RestoreCurrentPixelInfo
  
    ;add to fill_region_start_y to move the pixel down
    ldx fill_region_start_y
    inx   ;need to inx 80 and manage carry
    stx fill_region_start_y

    clc
    lda vidpage
    adc #$80
    sta vidpage    
    lda vidpage + 1   ;do not clc... need the carry bit to roll to the second (high) byte
    adc #$00          ;add carry
    sta vidpage + 1

    jsr StorePrevPixelInfo
    jsr DrawPixel

    jmp VIA2_CB1_handler3
    ;jmp VIA2_IRQ_OUT
VIA2_IRQ:               ;USB mouse.  Timer stub.
  ;check interrupt source on VIA IER (T1, T2, CB1, CB2, SR, CA1, CA2) and jump to appropriate handler
  lda IFR2
  and IER2
  asl
  ;BMI T1_handler
  asl
  ;BMI T2_handler
  asl
  ;BMI CB1_handler
  bmi VIA2_CB1_handler      ;USB mouse
  asl
  ;bmi CB2_handler
  asl
  ;bmi SR_handler
  asl
  ;bmi CA1_handler
  asl
  ;bmi CA2_handler

  jmp irq_done      ;should not get to this line if handlers above are setup
irq:
  ;put items on stack, so we can return them
  pha ;a to stack
  phx ;x to stack
  phy ;y to stack

  ;check interrupts in order of priority
  BIT  IFR1				; Check status register for VIA1        ; PS2 keyboard
  BMI  VIA1_IRQ			; Branch if VIA1 is interrupt source
  
  BIT  IFR3				; Check status register for VIA3        ; SPI
  BMI  VIA3_IRQ			; Branch if VIA3 is interrupt source
  
  BIT  IFR2				; Check status register for VIA2        ; USB mouse
  BMI  VIA2_IRQ			; Branch if VIA2 is interrupt source

  ;Currently, no interrupts on VIA4 or VIA5
  ;BIT IFR4              ; Check status register for VIA4       ; Sound Card
  ;BMI VIA4_IRQ
  ;BIT IFR5              ; Check status register for VIA5       ; FPGQ VGA
  ;BMI VIA5_IRQ

  ;Should never get here unless missing a BIT/BMI for the interrupt source
  jmp irq_done
VIA1_IRQ:               ;keyboard
  ;to do -- check interrupt source on VIA IER (CB1, CB2, CA1, CA2)
  jmp keyboard_interrupt
VIA2_CB1_handler:       ;USB mouse handler
  jmp VIA2_CB1_handler1
VIA3_CB1_handler:       ;Counter for temperature sensor refresh
  bit PORT3B        ;reset VIA interrupts CA1, CB1
  jmp irq_done
VIA3_CA1_handler:       ;ACIA
    lda ACIA_DATA     
    CA1_handler_out:
        bit ACIA_STATUS   ;reset interrupt of ACIA
        bit PORT3A        ;reset VIA interrupt    ;if running ACIA interrupt direct to 6502 (i.e., no VIA), this step is not necessary
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
  bmi VIA3_CB2_handler
  asl
  ;bmi SR_handler
  asl
  bmi VIA3_CA1_handler  ;ACIA
  asl
  ;bmi CA2_handler

  jmp irq_done      ;should not get to this line if handlers above are setup
VIA3_CB2_handler:       ;Arduino with SPI connection to 6502
    ;used to receive audio data

    ;lda #%00000001 ; Clear display
    ;jsr lcd_instruction
    ;lda #%10101000 ; put cursor at position 40
    ;jsr lcd_instruction

    jsr SPI_Ard_StartSession
    lda #SPI_ARD_CMD_GETSOUNDINFO
    sta SPI_ARD_Next_Command
    jsr SPI_Ard_SendCommand

    ;expecting eight bytes back       -0 (status)
    jsr SPI_Ard_ReceiveByte
    ;jsr print_hex_lcd

    ;** expecting 44 bytes of data **
    ;1
    jsr SPI_Ard_ReceiveByte
    sta TonePeriodCourseLA
    ;jsr print_hex_lcd

    ;2
    jsr SPI_Ard_ReceiveByte
    sta TonePeriodCourseLB
    ;jsr print_hex_lcd

    ;TO DO fill out the rest of these
    ;3
    jsr SPI_Ard_ReceiveByte
    sta TonePeriodCourseLC
    ;jsr print_hex_lcd

    ;4
    jsr SPI_Ard_ReceiveByte
    sta TonePeriodCourseLD
    ;jsr print_hex_lcd

    ;5
    jsr SPI_Ard_ReceiveByte
    sta TonePeriodCourseLE
    ;jsr print_hex_lcd

    ;6
    jsr SPI_Ard_ReceiveByte
    sta TonePeriodCourseLF
    ;jsr print_hex_lcd

    ;7
    jsr SPI_Ard_ReceiveByte
    sta TonePeriodFineLA
    ;jsr print_hex_lcd

    ;8
    jsr SPI_Ard_ReceiveByte
    sta TonePeriodFineLB
    ;jsr print_hex_lcd

    ;9
    jsr SPI_Ard_ReceiveByte
    sta TonePeriodFineLC
    ;jsr print_hex_lcd

    ;10
    jsr SPI_Ard_ReceiveByte
    sta TonePeriodFineLD
    ;jsr print_hex_lcd

    ;11
    jsr SPI_Ard_ReceiveByte
    sta TonePeriodFineLE
    ;jsr print_hex_lcd

    ;12
    jsr SPI_Ard_ReceiveByte
    sta TonePeriodFineLF
    ;jsr print_hex_lcd

    ;13
    jsr SPI_Ard_ReceiveByte
    sta VolumeLA
    ;jsr print_hex_lcd

    ;14
    jsr SPI_Ard_ReceiveByte
    sta VolumeLB
    ;jsr print_hex_lcd

    ;15
    jsr SPI_Ard_ReceiveByte
    sta VolumeLC
    ;jsr print_hex_lcd

    ;16
    jsr SPI_Ard_ReceiveByte
    sta VolumeLD
    ;jsr print_hex_lcd

    ;17
    jsr SPI_Ard_ReceiveByte
    sta VolumeLE
    ;jsr print_hex_lcd

    ;18
    jsr SPI_Ard_ReceiveByte
    sta VolumeLF
    ;jsr print_hex_lcd

    ;19
    jsr SPI_Ard_ReceiveByte
    sta TonePeriodCourseRA
    ;jsr print_hex_lcd

    ;20
    jsr SPI_Ard_ReceiveByte
    sta TonePeriodCourseRB
    ;jsr print_hex_lcd

    ;21
    jsr SPI_Ard_ReceiveByte
    sta TonePeriodCourseRC
    ;jsr print_hex_lcd

    ;22
    jsr SPI_Ard_ReceiveByte
    sta TonePeriodCourseRD
    ;jsr print_hex_lcd

    ;23
    jsr SPI_Ard_ReceiveByte
    sta TonePeriodCourseRE
    ;jsr print_hex_lcd

    ;24
    jsr SPI_Ard_ReceiveByte
    sta TonePeriodCourseRF
    ;jsr print_hex_lcd

    ;25
    jsr SPI_Ard_ReceiveByte
    sta TonePeriodFineRA
    ;jsr print_hex_lcd

    ;26
    jsr SPI_Ard_ReceiveByte
    sta TonePeriodFineRB
    ;jsr print_hex_lcd

    ;27
    jsr SPI_Ard_ReceiveByte
    sta TonePeriodFineRC
    ;jsr print_hex_lcd

    ;28
    jsr SPI_Ard_ReceiveByte
    sta TonePeriodFineRD
    ;jsr print_hex_lcd

    ;29
    jsr SPI_Ard_ReceiveByte
    sta TonePeriodFineRE
    ;jsr print_hex_lcd

    ;30
    jsr SPI_Ard_ReceiveByte
    sta TonePeriodFineRF
    ;jsr print_hex_lcd

    ;31
    jsr SPI_Ard_ReceiveByte
    sta VolumeRA
    ;jsr print_hex_lcd

    ;32
    jsr SPI_Ard_ReceiveByte
    sta VolumeRB
    ;jsr print_hex_lcd

    ;33
    jsr SPI_Ard_ReceiveByte
    sta VolumeRC
    ;jsr print_hex_lcd

    ;34
    jsr SPI_Ard_ReceiveByte
    sta VolumeRD
    ;jsr print_hex_lcd

    ;35
    jsr SPI_Ard_ReceiveByte
    sta VolumeRE
    ;jsr print_hex_lcd

    ;36
    jsr SPI_Ard_ReceiveByte
    sta VolumeRF
    ;jsr print_hex_lcd

    ;37
    jsr SPI_Ard_ReceiveByte
    sta NoisePeriodL1
    ;jsr print_hex_lcd

    ;38
    jsr SPI_Ard_ReceiveByte
    sta EnvelopePeriodCourseL1
    ;jsr print_hex_lcd

    ;39
    jsr SPI_Ard_ReceiveByte
    sta EnvelopePeriodFineL1
    ;jsr print_hex_lcd

    ;40
    jsr SPI_Ard_ReceiveByte
    sta EnvelopeShapeCycleL1
    ;jsr print_hex_lcd

    ;41*
    jsr SPI_Ard_ReceiveByte
    sta EnableLeft1
    ;jsr print_hex_lcd

    ;42
    jsr SPI_Ard_ReceiveByte
    sta EnableRight1
    ;jsr print_hex_lcd

    ;43
    jsr SPI_Ard_ReceiveByte
    sta EnableLeft2
    ;jsr print_hex_lcd

    ;44
    jsr SPI_Ard_ReceiveByte
    sta EnableRight2
    ;jsr print_hex_lcd

    ; ***** added *****

    ;45
    jsr SPI_Ard_ReceiveByte
    sta NoisePeriodR1
    ;jsr print_hex_lcd

    ;46
    jsr SPI_Ard_ReceiveByte
    sta EnvelopePeriodCourseR1
    ;jsr print_hex_lcd

    ;47
    jsr SPI_Ard_ReceiveByte
    sta EnvelopePeriodFineR1
    ;jsr print_hex_lcd

    ;48
    jsr SPI_Ard_ReceiveByte
    sta EnvelopeShapeCycleR1
    ;jsr print_hex_lcd


    ;49
    jsr SPI_Ard_ReceiveByte
    sta NoisePeriodL2
    ;jsr print_hex_lcd

    ;50
    jsr SPI_Ard_ReceiveByte
    sta EnvelopePeriodCourseL2
    ;jsr print_hex_lcd

    ;51
    jsr SPI_Ard_ReceiveByte
    sta EnvelopePeriodFineL2
    ;jsr print_hex_lcd

    ;52
    jsr SPI_Ard_ReceiveByte
    sta EnvelopeShapeCycleL2
    ;jsr print_hex_lcd


    ;53
    jsr SPI_Ard_ReceiveByte
    sta NoisePeriodR2
    ;jsr print_hex_lcd

    ;54
    jsr SPI_Ard_ReceiveByte
    sta EnvelopePeriodCourseR2
    ;jsr print_hex_lcd

    ;55
    jsr SPI_Ard_ReceiveByte
    sta EnvelopePeriodFineR2
    ;jsr print_hex_lcd

    ;56
    jsr SPI_Ard_ReceiveByte
    sta EnvelopeShapeCycleR2
    ;jsr print_hex_lcd


    jsr SPI_Ard_EndSession

    bit PORT3B

    lda #$01
    sta audio_data_to_write

    jmp irq_done
VIA2_CB1_handler1:

    lda #%00000001 ; Clear display
    jsr lcd_instruction

    lda PORT2B    ;clear interrupt
    sta $69 ;store original value read from port
    and #%00111100  ;the bits used for mouse move
    sta $6A ;store masked portion for mouse move

    eor #MOUSE_LEFT
    beq Handle_Mouse_Left

    lda $6A
    eor #MOUSE_UP
    beq Handle_Mouse_Up
    
    lda $6A
    eor #MOUSE_RIGHT
    beq Handle_Mouse_Right
    
    lda $6A
    eor #MOUSE_DOWN
    beq Handle_Mouse_Down

    jmp VIA2_CB1_handler2
Handle_Mouse_Left:
    jsr RestoreCurrentPixelInfo
    ldx fill_region_start_x
    dex
    stx fill_region_start_x
    jsr StorePrevPixelInfo
    jsr DrawPixel
    
    jmp VIA2_CB1_handler3
    ;jmp VIA2_IRQ_OUT
Handle_Mouse_Up:
  ;jsr print_dec_lcd

  ;put old pixel data in current pixel, since the cursor is moving out
  jsr RestoreCurrentPixelInfo

  ;subtract from fill_region_start_y to move the pixel up
  ldx fill_region_start_y
  dex   ;need to dex 80 and manage carry
  stx fill_region_start_y

  sec
  lda vidpage
  sbc #$80
  sta vidpage    
  lda vidpage + 1   ;do not clc... need the carry bit to roll to the second (high) byte
  sbc #$00          ;subtract carry
  sta vidpage + 1

  jsr StorePrevPixelInfo
  jsr DrawPixel

  jmp VIA2_CB1_handler3
  ;jmp VIA2_IRQ_OUT   
Handle_Mouse_Right:
    ;jsr print_dec_lcd

    ;put old pixel data in current pixel, since the pointer is moving out
    jsr RestoreCurrentPixelInfo
    ;add to fill_region_start_x to move the pixel right
    ldx fill_region_start_x
    inx
    stx fill_region_start_x
    jsr StorePrevPixelInfo
    jsr DrawPixel

    jmp VIA2_CB1_handler3
    ;jmp VIA2_IRQ_OUT
Handle_Mouse_Down:
  ;jsr print_dec_lcd

  ;put old pixel data in current pixel, since the pointer is moving out
  jsr RestoreCurrentPixelInfo
  
  ;add to fill_region_start_y to move the pixel down
  ldx fill_region_start_y
  inx   ;need to inx 80 and manage carry
  stx fill_region_start_y

  clc
  lda vidpage
  adc #$80
  sta vidpage    
  lda vidpage + 1   ;do not clc... need the carry bit to roll to the second (high) byte
  adc #$00          ;add carry
  sta vidpage + 1

  jsr StorePrevPixelInfo
  jsr DrawPixel

  jmp VIA2_CB1_handler3
  ;jmp VIA2_IRQ_OUT
VIA2_CB1_handler3:
    lda $69 ;get original info from port read - need to check for mouse buttons

    jsr print_hex_lcd

    and #%00000011      ;mouse button mask
    jsr print_hex_lcd
    sta $6A

    eor #MOUSE_CLICK_LEFT
    beq Handle_Mouse_Click_Left
    
    lda $6A
    eor #MOUSE_CLICK_MIDDLE
    beq Handle_Mouse_Click_Middle

    lda $6A
    eor #MOUSE_CLICK_RIGHT
    beq Handle_Mouse_Click_Right
    
    jmp irq_done
    ;jmp VIA2_CB1_handler3
Handle_Mouse_Click_Left:
    ;jsr print_dec_lcd
    lda #$00  ;start counting up at this value; higher # = shorter delay
    sta delayDurationHighByte
    jsr Delay
    lda currently_drawing
    cmp #$01
    beq JS_turnDrawingOff_MouseL
    lda #$01   ;otherwise, turn it on
    jmp handleJSpress_out_MouseL
    JS_turnDrawingOff_MouseL:
    lda #$00
    handleJSpress_out_MouseL:
    sta currently_drawing

    bit PORT2B      ;reset interrupt
    jmp irq_done
Handle_Mouse_Click_Middle:
    inc fill_region_color
    lda fill_region_color
    cmp #$40
    beq resetColorToZero_hmcm
    jmp handleNKP_Plus_out_hmcm
    resetColorToZero_hmcm:
    lda #$00
    handleNKP_Plus_out_hmcm:
    sta fill_region_color
    jsr DrawPixel
    bit PORT2B      ;reset interrupt
    jmp irq_done
Handle_Mouse_Click_Right:

    lda mouseFillRegionStarted
    cmp #$01
    beq clickRightFill  ;if we know region start already, jump to filling. otherwise, capture current location as start position.

    ;record region start
    lda fill_region_start_x
    sta fill_region_clk_start_x
    lda fill_region_start_y
    sta fill_region_clk_start_y
    lda #$01
    sta mouseFillRegionStarted
    bra clickRightOut

    clickRightFill:
        ;currently, start of region must be upper left point, with end of region at lower right point (cannot use reverse, or other corners)

        lda fill_region_start_x   ;end shape at current position
        sta fill_region_end_x     ;end is hard-coded for now
        lda fill_region_start_y
        sta fill_region_end_y

        lda fill_region_clk_start_x
        sta fill_region_start_x
        lda fill_region_clk_start_y
        sta fill_region_start_y
      
        lda fill_region_color
        ;sta fill_region_color    ;user current color - should not need to modify
        sta pixel_prev_color      
        jsr FillRegion
        lda #$00
        sta mouseFillRegionStarted
    clickRightOut:
    bit PORT2B      ;reset interrupt
    jmp irq_done
VIA2_IRQ_OUT:
  jmp irq_done
VIA5_T1_handler:
    rts   ;unused for now
    ;timer event happens far too quickly to be usable for a temp refresh interval -- causes issues with other interrupts on 6502
    ;lda ticks
    ;clc
    ;adc #1
    ;sta ticksmouse
    ;cmp max_ticks
    ;bne VIA5_IRQ_OUT
    ;lda #0
    ;sta ticks
    ;rts
shift_up:
  lda kb_flags
  eor #SHIFT  ; flip the shift bit
  sta kb_flags
  jmp irq_done
keyboard_interrupt:
  lda kb_flags
  and #RELEASE   ; check if we're releasing a key
  beq read_key   ; otherwise, read the key

  lda kb_flags
  eor #RELEASE   ; flip the releasing bit
  sta kb_flags

  lda PORT1A      ; read key value that is being released
  
  cmp #$12       ; left shift
  beq shift_up
  cmp #$59       ; right shift
  beq shift_up 

  jmp irq_done
key_release:
  lda kb_flags
  ora #RELEASE
  sta kb_flags
  jmp irq_done
shift_down:
  lda kb_flags
  ora #SHIFT
  sta kb_flags
  jmp irq_done
read_key:
  lda PORT1A
  
  ;jsr print_dec_lcd ;***

  cmp #$f0        ; if releasing a key
  beq key_release ; set the releasing bit
  cmp #$12        ; left shift
  beq shift_down
  cmp #$59        ; right shift
  beq shift_down
  cmp #$6b           ; left arrow
  beq arrow_left_down
  cmp #$74           ; right arrow
  beq arrow_right_down
  cmp #$75           ; up arrow
  beq arrow_up_down
  cmp #$72           ; down arrow
  beq arrow_down_down
  cmp #$73           ; numberic keypad '5'
  beq nkp5_down
  cmp #$79           ; numeric keypad '+'
  beq nkpplus_down
  cmp #$70           ; numeric keypad insert
  beq nkpinsert_down
  cmp #$71           ; numeric keypad delete
  beq nkpdelete_down
  cmp #$7b           ; numeric keypay minus
  beq nkpminus_down
  cmp #$7c           ; numeric keypad asterisk
  beq nkpasterisk_down
  cmp #$07           ; F12
  beq printscreen_down
  cmp #$e0           ;trying to filter out '?' 0xe0 from printscreen key
  beq keyscan_ignore

  tax
  lda kb_flags
  and #SHIFT
  bne shifted_key

  lda keymap, x   ; map to character code
  bra push_key
shifted_key:
  lda keymap_shifted, x   ; map to character code
  ;fall into push_key
push_key:
  ldx kb_wptr
  sta kb_buffer, x
  inc kb_wptr
  jmp irq_done
arrow_left_down:
  lda kb_flags
  ora #ARROW_LEFT
  sta kb_flags
  jmp irq_done
arrow_right_down:
  lda kb_flags
  ora #ARROW_RIGHT
  sta kb_flags
  jmp irq_done
arrow_up_down:
  lda kb_flags
  ora #ARROW_UP
  sta kb_flags
  jmp irq_done
arrow_down_down:
  lda kb_flags
  ora #ARROW_DOWN
  sta kb_flags
  jmp irq_done
nkp5_down:
  lda kb_flags
  ora #NKP5
  sta kb_flags
  jmp irq_done
nkpplus_down:
  lda kb_flags
  ora #NKP_PLUS
  sta kb_flags
  jmp irq_done
nkpinsert_down:
  lda kb_flags2
  ora #NKP_INSERT
  sta kb_flags2
  jmp irq_done
nkpdelete_down:
  lda kb_flags2
  ora #NKP_DELETE
  sta kb_flags2
  jmp irq_done
nkpminus_down:
  lda kb_flags2
  ora #NKP_MINUS
  sta kb_flags2
  jmp irq_done
nkpasterisk_down:
  lda kb_flags2
  ora #NKP_ASTERISK
  sta kb_flags2
  jmp irq_done
printscreen_down:
  lda kb_flags2
  ora #PRINTSCREEN
  sta kb_flags2
  jmp irq_done
keyscan_ignore:
  jmp irq_done
ClearChar:
  ;erase a char from the screen 
  ;TO DO Implement ClearChar
  rts
;SelectMessge subroutines
    NoMessage:
      ldx $40   ;set x back to orig value
      rts
    SelectMessage1:
      lda message1,x
      jmp PrintStringLoopCont
    SelectMessage2:
      lda message2,x
      jmp PrintStringLoopCont
    SelectMessage3:
      lda message3,x
      jmp PrintStringLoopCont
    SelectMessage4:
      lda message4,x
      jmp PrintStringLoopCont
    SelectMessage5:
      lda message5,x
      jmp PrintStringLoopCont
    SelectMessage6:
      lda message6,x
      jmp PrintStringLoopCont
    SelectMessage7:
      lda message7,x
      jmp PrintStringLoopCont
    SelectMessage8:
      lda message8,x
      jmp PrintStringLoopCont
PrintStringLCD_readTemp:
  ;TO DO Make more dynamic, to support many different pre-defined strings
  ldx #0
  psLCDtop2:
    lda message3,x
    beq psLCDout2
    jsr print_char_lcd
    inx
    jmp psLCDtop2
  psLCDout2:
  rts
PrintStringLCD:
  ;TO DO Make more dynamic, to support many different pre-defined strings
  ldx #0
  psLCDtop:
    lda message1,x
    beq psLCDout
    jsr print_char_lcd
    inx
    jmp psLCDtop
  psLCDout:
    rts
PrintString:
  stx $40   ;store x
  ldx #$00
  stx $54   ;printstring current char tracking
  ;falls into PrintStringLoop
    PrintStringLoop:
      lda message_to_process
      cmp #$00
        beq NoMessage
      cmp #$01
        beq SelectMessage1
      cmp #$02
        beq SelectMessage2
      cmp #$03
        beq SelectMessage3
      cmp #$04
        beq SelectMessage4
      cmp #$05
        beq SelectMessage5
      cmp #$06
        beq SelectMessage6
      cmp #$07
        beq SelectMessage7
      cmp #$08
        beq SelectMessage8
     ;falls into PrintStringLoopCont
PrintStringLoopCont:
  bne print_char_vga    ;where to go when there are chars to process
  ldx $40   ;set x back to orig value
  rts
print_char_vga:
  ; TO DO safety code... this function assumes a valid ascii char that is supported

  ;current char is in A(ccumulator)
  sta char_current_val
  
  ;Current ASCII character support starts with ASCII 0x20 SPACE key
  ;Each charmap supports 16 characters, so 3 charmaps are needed

  lda char_vp_p1
  sta vidpage + 1
  lda char_vp
  sta vidpage
      
  ldy char_y_offset  ;column start
  sty $44   ;remember this offset, so we can come back each row

  ldx #$00
  stx $52   ;character pixel row loop counter

  ; https://www.asc.ohio-state.edu/demarneffe.1/LING5050/material/ASCII-Table.png
  ; Mask first three bits of ASCII code to determine which charmap is needed

  lda char_current_val
  and #ASCII_CHARMAP ;look at first three bits of ascii code
  cmp #%01100000    ;charmap3
  beq GetCharMap3
  cmp #%01000000    ;charmap2
  beq GetCharMap2
  cmp #%00100000    ;charmap1
  beq GetCharMap1
  ;cmp #%00000000    ;charmap0   ;not implemented
  ;beq GetCharMap0
  ;no match in first three charmaps... grab a '?'
  lda #$3f
  jmp CharMap_Selected
GetCharMap1:
  ;supports ASCII chars from 0x20 to 0x3F
  clc
  lda char_current_val
  sbc #$20  ;translate from ASCII value to address in ROM   ;example: 'a' 0x61 minus 0x20 = 0x41 for location in charmap
  ;multiply by 8 (8 bits per byte)
  asl   ;double
  asl   ;double again
  asl   ;double a third time
  clc
  adc $52   ;for each loop through rows of pixel, increase this by one, so that following logic fetches the correct char pixel row
  clc
  adc #$07 ;advance to the next char
  tax   ;transfer A to X        ;what about when x!=0 -- e.g., when in row two of a char
  lda charmap1, x
  sta $50
  jmp CharMap_Selected
GetCharMap2:
  ;supports ASCII chars from 0x40 to 0x5F
  clc
  lda char_current_val
  sbc #$40  ;example: 'a' 0x61 minus 0x20 = 0x41 for location in charmap
  ;multiply by 8 bits
  asl   ;double
  asl   ;double again
  asl   ;double a third time
  clc
  adc $52   ;for each loop through rows of pixel, increase this by one, so that following logics fetches the correct char pixel row
  clc
  adc #$07 ;next char
  tax   ;transfer A to X
  lda charmap2, x
  sta $50
  jmp CharMap_Selected
GetCharMap3:
  ;supports ASCII chars from 0x60 to 0x7F
  clc
  ;sec needed here?
  lda char_current_val
  sbc #$60  ;example: 'a' 0x61 minus 0x20 = 0x41 for location in charmap
  ;multiply by 8 bits
  asl   ;double
  asl   ;double again
  asl   ;double a third time
  clc
  adc $52   ;for each loop through rows of pixel, increase this by one, so that following logics fetches the correct char pixel row
  clc
  adc #$07 ;next char
  tax   ;transfer A to X
  ;set row stop
  lda charmap3, x
  sta $50
  jmp CharMap_Selected
NextRow:
  lda char_current_val
  and #ASCII_CHARMAP ;look at first three bits of ascii code
  cmp #%01100000    ;charmap3
  beq GetCharMap3
  cmp #%01000000    ;charmap2
  beq GetCharMap2
  cmp #%00100000    ;charmap1
  beq GetCharMap1
  ;cmp #%00000000    ;charmap0   ;not implemented
  ;beq GetCharMap0
  jmp Finished  ;should not get here
CharMap_Selected:
    charpix_col1:
      lda $50   ;stored current char from appropriate charmap
      and #PIXEL_COL1   ;look at the first column of the pixel row and see if the pixel should be set
      beq charpix_col2  ;if the first bit is not a 1 go to the next pixel, otherwise, continue and print the pixel
      lda char_color	;load color stored above
      sta (vidpage), y ; write A register to address vidpage + y
    charpix_col2:
      iny   ;shift pixel writing location one to the right
      lda $50
      and #PIXEL_COL2
      beq charpix_col3
      lda char_color	;load color stored above
      sta (vidpage), y ; write A register to address vidpage + y
    charpix_col3:
      iny
      ;lda charmap1, x
      lda $50
      and #PIXEL_COL3
      beq charpix_col4
      lda char_color	;load color stored above
      sta (vidpage), y ; write A register to address vidpage + y
    charpix_col4:
      iny
      lda $50
      and #PIXEL_COL4
      beq charpix_col5
      lda char_color	;load color stored above
      sta (vidpage), y ; write A register to address vidpage + y
    charpix_col5:
      iny
      lda $50
      and #PIXEL_COL5
      beq charpix_rowdone
      lda char_color	;load color stored above
      sta (vidpage), y ; write A register to address vidpage + y
    ;could expand support beyond 5 colums (up to 8, based on charmap)
    charpix_rowdone:
      jsr NextVGALine   ;shift pixel writing location down one pixel
      ldy $44   ;back to first column

      ;check if we are through the 7 rows. if so, jump out. otherwise, start next row of font character.
      inc $52   ;inc row loop counter
      lda $52
      cmp #$08  ;see if we have made it through all 7 rows
      bne NextRow  ;if we have not processed all 7 rows, branch to repeat. otherwise, go to next line

      ;no more rows to process in this character
      ldx #$00
      stx $52   ;row loop counter
      jmp Next  
Next:
  ;move the 'cursor' to the right by 6 pixels
  inc char_y_offset
  inc char_y_offset
  inc char_y_offset
  inc char_y_offset
  inc char_y_offset
  inc char_y_offset
  inc $54   ;string char# tracker
  ldx $54
  jmp PrintStringLoop
NextVGALine:
    ;move the location for writing to the screen down one line. Example:
    ;vidpage+1    20      vidpage 80
    ;next line
    ;vidpage+1   21      vidpage 00
    ;next line
    ;vidpage+1   21      vidpage 80
    clc
    lda vidpage
    adc #$80
    sta vidpage    
    lda vidpage + 1   ;do not clc... need the carry bit to roll to the second (high) byte
    adc #$00          ;add carry
    sta vidpage + 1
    rts
JumpToLine:
    ;start at top
    lda #$20
    sta vidpage + 1
    lda #$00
    sta vidpage

    ldx jump_to_line_y
    ;if jump_to_line_y is 0, we are done
    cpx #$00
    beq JumpToLineDone

    JumpToLineLoop:
    jsr NextVGALine     ;there has to be a better way that to call this loop -- more of a direct calculation -- TBD
    dex
    bne JumpToLineLoop
    
    JumpToLineDone:
        rts
FillBlack:
    ;clear video memory (set it all to black)
    ;start at beginning of video memory - first row/page
    lda #$20
    sta vidpage + 1
    lda #$00
    sta vidpage
  
    ldx #$20 ; X will count down how many pages of video RAM to go
    ldy #$0 ;Start at first column

    jsr FillRowBlack	;2000 stored as 00 20
    lda #$20
    sta vidpage + 1
    lda #$80
    sta vidpage
    ldy #$0
    jsr FillRowBlack
    dex
    FillBlackLoop:
      ;Go to the next page, first column
      inc vidpage + 1
      lda #$00
      sta vidpage
      ldy #$0
  
      jsr FillRowBlack

      ;Go to the next page, first column
      lda #$80
      sta vidpage
      ldy #$0
  
      jsr FillRowBlack

      dex		;decrement X, which is used to track how many pages are left to be processed
      bne FillBlackLoop	
      rts
    FillRowBlack:
      lda #$00	;color 
      sta (vidpage), y ; write A register to address vidpage + y
      iny
      tya	;transfer Y to accumulator
      cmp #$64 ; if we cycled through 100 columns	compare A to 0x63 (99)		have worked 0-99 = 100 columns
      bne FillRowBlack	
      rts
DrawPixel:

  ;put items on stack, so we can return them
  pha ;a to stack
  phx ;x to stack
  phy ;y to stack

  ;should already be filled in with desired pixel location:
  ;sta fill_region_start_x
  ;sta fill_region_start_y
  ;push registers to stack?

  ;store current 'cursor' location
  lda vidpage + 1
  sta $60
  lda vidpage
  sta $61
  tya
  sty $62

  lda fill_region_start_y
  sta jump_to_line_y
  jsr JumpToLine

  ldy fill_region_start_x     ;horizontal pixel location, 0 to 99
  lda fill_region_color
    
  sta (vidpage), y; write A register (color) to address vidpage + y

  ;put things back and return to sender
  lda $60
  sta vidpage + 1
  lda $61
  sta vidpage
  lda $62
  tay

  ;return items from stack
  ply ;stack to y
  plx ;stack to x
  pla ;stack to a

  rts
FillRegion:
    ;TO DO verify register management is correct (storing/restoring)
    ;put items on stack, so we can return them
    ;pha ;a to stack
    ;phx ;x to stack
    ;phy ;y to stack
    
    ;store current 'cursor' location
    lda vidpage + 1
    sta $60
    lda vidpage
    sta $61
    tya
    sty $62
FillRegionLoopStart:
    ;start location
    lda fill_region_start_y
    sta jump_to_line_y
    jsr JumpToLine

    ldx fill_region_end_x
    inx
    stx $63 ; columns end comparison
        
    lda fill_region_end_y
    sec
    sbc fill_region_start_y
    sta $64 ; rows remaining
    inc $64 ; add one to get count of rows to process

    FillRegionLoopYloop:
        ldy fill_region_start_x     ;horizontal pixel location, 0 to 99
        lda fill_region_color
            
        FillRegionLoopXloop:
            sta (vidpage), y; write A register (color) to address vidpage + y
            iny
            cpy $63
            beq FRLX_done    ;done with this row
            jmp FillRegionLoopXloop
        FRLX_done:
        ;move on to next row
            dec $64
            beq FRLY_done
            lda vidpage
            clc
            adc #$80
            sta vidpage    
            lda vidpage + 1   ;do not clc... need the carry bit to roll to the second (high) byte
            adc #$00          ;add carry
            sta vidpage + 1                  
            jmp FillRegionLoopYloop
            FRLY_done:

    ;put things back and return to sender
    lda $60
    sta vidpage + 1
    lda $61
    sta vidpage
    lda $61
    tay

    ;put items on stack, so we can return them
    ;pha ;a to stack
    ;phx ;x to stack
    ;phy ;y to stack

    rts
Delay:
  ;Simple delay routine. Counts from 0 to 65535 for the delay.  
  ;https://gist.github.com/superjamie/fd80fabadf39199c97de400213f614e9
  sta $40       ;save current accumulator
  ;lda #$C0	    ;counter start - increase number to shorten delay
  lda delayDurationHighByte	;counter start - increase number to shorten delay
  sta $41       ; store high byte
Delayloop:
  adc #01
  ; usually adding 1 into A will not set the Zero bit. when the reigster
  ; overflows and the value of A becomes #$00, the Zero flag will be
  ; set. BNE jumps when the Z bit is not set
  bne Delayloop
  ; so we only land here after we have counted past #$FF
  ; clear carry flag so we do not add it next ADC
  clc
  inc $41
  ; same strategy is used here, we jump unless the INC overflowed
  ; back to zero
  bne Delayloop
  ; clear carry flag so we do nt add it next ADC
  clc
  ; exit
  ; restore state of the A register
  lda $40
  rts
InitVideoMemory:
  ; initialize to point vidpage to beginning of video ram $2000
  lda #$20
  sta char_vp_p1
  sta vidpage + 1
  lda #$80  ;leaving one row cushion at top
  sta char_vp
  sta vidpage
  lda #$3F
  sta char_color
  lda #$4
  sta char_y_offset

  ldx #$20 ; X will count down how many pages of video RAM to go
  ldy #$0 ; populate a page starting at 0
  rts
LoadImage:

  ldy #00
  lda #00
  sta jump_to_line_y
  jsr JumpToLine
  jsr LoadImageRow_0
  
  ldy #00
  lda #01
  sta jump_to_line_y
  jsr JumpToLine
  jsr LoadImageRow_1

  ldy #00
  lda #02
  sta jump_to_line_y
  jsr JumpToLine
  jsr LoadImageRow_2

  ldy #00
  lda #03
  sta jump_to_line_y
  jsr JumpToLine
  jsr LoadImageRow_3

  ldy #00
  lda #04
  sta jump_to_line_y
  jsr JumpToLine
  jsr LoadImageRow_4
  
  ldy #00
  lda #05
  sta jump_to_line_y
  jsr JumpToLine
  jsr LoadImageRow_5

  ldy #00
  lda #06
  sta jump_to_line_y
  jsr JumpToLine
  jsr LoadImageRow_6

  ldy #00
  lda #07
  sta jump_to_line_y
  jsr JumpToLine
  jsr LoadImageRow_7

  ldy #00
  lda #8
  sta jump_to_line_y
  jsr JumpToLine
  jsr LoadImageRow_8

  ldy #00
  lda #9
  sta jump_to_line_y
  jsr JumpToLine
  jsr LoadImageRow_9

  ldy #00
  lda #10
  sta jump_to_line_y
  jsr JumpToLine
  jsr LoadImageRow_10
  
  ldy #00
  lda #11
  sta jump_to_line_y
  jsr JumpToLine
  jsr LoadImageRow_11

  ldy #00
  lda #12
  sta jump_to_line_y
  jsr JumpToLine
  jsr LoadImageRow_12

  ldy #00
  lda #13
  sta jump_to_line_y
  jsr JumpToLine
  jsr LoadImageRow_13

  ldy #00
  lda #14
  sta jump_to_line_y
  jsr JumpToLine
  jsr LoadImageRow_14
  
  ldy #00
  lda #15
  sta jump_to_line_y
  jsr JumpToLine
  jsr LoadImageRow_15

  ldy #00
  lda #16
  sta jump_to_line_y
  jsr JumpToLine
  jsr LoadImageRow_16

  ldy #00
  lda #17
  sta jump_to_line_y
  jsr JumpToLine
  jsr LoadImageRow_17

  ldy #00
  lda #18
  sta jump_to_line_y
  jsr JumpToLine
  jsr LoadImageRow_18

  ldy #00
  lda #19
  sta jump_to_line_y
  jsr JumpToLine
  jsr LoadImageRow_19

  ldy #00
  lda #20
  sta jump_to_line_y
  jsr JumpToLine
  jsr LoadImageRow_20
  
  ldy #00
  lda #21
  sta jump_to_line_y
  jsr JumpToLine
  jsr LoadImageRow_21

  ldy #00
  lda #22
  sta jump_to_line_y
  jsr JumpToLine
  jsr LoadImageRow_22

  ldy #00
  lda #23
  sta jump_to_line_y
  jsr JumpToLine
  jsr LoadImageRow_23

  ldy #00
  lda #24
  sta jump_to_line_y
  jsr JumpToLine
  jsr LoadImageRow_24
  
  ldy #00
  lda #25
  sta jump_to_line_y
  jsr JumpToLine
  jsr LoadImageRow_25

  ldy #00
  lda #26
  sta jump_to_line_y
  jsr JumpToLine
  jsr LoadImageRow_26

  ldy #00
  lda #27
  sta jump_to_line_y
  jsr JumpToLine
  jsr LoadImageRow_27

  ldy #00
  lda #28
  sta jump_to_line_y
  jsr JumpToLine
  jsr LoadImageRow_28

  ldy #00
  lda #29
  sta jump_to_line_y
  jsr JumpToLine
  jsr LoadImageRow_29

  ldy #00
  lda #30
  sta jump_to_line_y
  jsr JumpToLine
  jsr LoadImageRow_30
  
  ldy #00
  lda #31
  sta jump_to_line_y
  jsr JumpToLine
  jsr LoadImageRow_31

  ldy #00
  lda #32
  sta jump_to_line_y
  jsr JumpToLine
  jsr LoadImageRow_32

  ldy #00
  lda #33
  sta jump_to_line_y
  jsr JumpToLine
  jsr LoadImageRow_33

  ldy #00
  lda #34
  sta jump_to_line_y
  jsr JumpToLine
  jsr LoadImageRow_34
  
  ldy #00
  lda #35
  sta jump_to_line_y
  jsr JumpToLine
  jsr LoadImageRow_35

  ldy #00
  lda #36
  sta jump_to_line_y
  jsr JumpToLine
  jsr LoadImageRow_36

  ldy #00
  lda #37
  sta jump_to_line_y
  jsr JumpToLine
  jsr LoadImageRow_37

  ldy #00
  lda #38
  sta jump_to_line_y
  jsr JumpToLine
  jsr LoadImageRow_38

  ldy #00
  lda #39
  sta jump_to_line_y
  jsr JumpToLine
  jsr LoadImageRow_39

  ldy #00
  lda #40
  sta jump_to_line_y
  jsr JumpToLine
  jsr LoadImageRow_40
  
  ldy #00
  lda #41
  sta jump_to_line_y
  jsr JumpToLine
  jsr LoadImageRow_41

  ldy #00
  lda #42
  sta jump_to_line_y
  jsr JumpToLine
  jsr LoadImageRow_42

  ldy #00
  lda #43
  sta jump_to_line_y
  jsr JumpToLine
  jsr LoadImageRow_43

  ldy #00
  lda #44
  sta jump_to_line_y
  jsr JumpToLine
  jsr LoadImageRow_44
  
  ldy #00
  lda #45
  sta jump_to_line_y
  jsr JumpToLine
  jsr LoadImageRow_45

  ldy #00
  lda #46
  sta jump_to_line_y
  jsr JumpToLine
  jsr LoadImageRow_46

  ldy #00
  lda #47
  sta jump_to_line_y
  jsr JumpToLine
  jsr LoadImageRow_47

  ldy #00
  lda #48
  sta jump_to_line_y
  jsr JumpToLine
  jsr LoadImageRow_48

  ldy #00
  lda #49
  sta jump_to_line_y
  jsr JumpToLine
  jsr LoadImageRow_49

  ldy #00
  lda #50
  sta jump_to_line_y
  jsr JumpToLine
  jsr LoadImageRow_50
  
  ldy #00
  lda #51
  sta jump_to_line_y
  jsr JumpToLine
  jsr LoadImageRow_51

  ldy #00
  lda #52
  sta jump_to_line_y
  jsr JumpToLine
  jsr LoadImageRow_52

  ldy #00
  lda #53
  sta jump_to_line_y
  jsr JumpToLine
  jsr LoadImageRow_53

  ldy #00
  lda #54
  sta jump_to_line_y
  jsr JumpToLine
  jsr LoadImageRow_54
  
  ldy #00
  lda #55
  sta jump_to_line_y
  jsr JumpToLine
  jsr LoadImageRow_55

  ldy #00
  lda #56
  sta jump_to_line_y
  jsr JumpToLine
  jsr LoadImageRow_56

  ldy #00
  lda #57
  sta jump_to_line_y
  jsr JumpToLine
  jsr LoadImageRow_57

  ldy #00
  lda #58
  sta jump_to_line_y
  jsr JumpToLine
  jsr LoadImageRow_58

  ldy #00
  lda #59
  sta jump_to_line_y
  jsr JumpToLine
  jsr LoadImageRow_59

  ldy #00
  lda #60
  sta jump_to_line_y
  jsr JumpToLine
  jsr LoadImageRow_60
  
  ldy #00
  lda #61
  sta jump_to_line_y
  jsr JumpToLine
  jsr LoadImageRow_61

  ldy #00
  lda #62
  sta jump_to_line_y
  jsr JumpToLine
  jsr LoadImageRow_62

  ldy #00
  lda #63
  sta jump_to_line_y
  jsr JumpToLine
  jsr LoadImageRow_63

  rts
;LoadImageRow calls
    ;Need to find a more efficient way to do this.... brute force for now. How to copy an entire memory region, efficiently, in an 8-bit system?
    LoadImageRow_0:
      lda win11_0, y
      sta (vidpage), y ; write A register to address vidpage + y
      iny
      tya	;transfer Y to accumulator
      cmp #$64 ; if we cycled through 100 columns	compare A to 0x63 (99)		have worked 0-99 = 100 columns
      bne LoadImageRow_0	
      rts
    LoadImageRow_1:
      lda win11_1, y
      sta (vidpage), y ; write A register to address vidpage + y
      iny
      tya	;transfer Y to accumulator
      cmp #$64 ; if we cycled through 100 columns	compare A to 0x63 (99)		have worked 0-99 = 100 columns
      bne LoadImageRow_1	
      rts
    LoadImageRow_2:
      lda win11_2, y
      sta (vidpage), y ; write A register to address vidpage + y
      iny
      tya	;transfer Y to accumulator
      cmp #$64 ; if we cycled through 100 columns	compare A to 0x63 (99)		have worked 0-99 = 100 columns
      bne LoadImageRow_2	
      rts
    LoadImageRow_3:
      lda win11_3, y
      sta (vidpage), y ; write A register to address vidpage + y
      iny
      tya	;transfer Y to accumulator
      cmp #$64 ; if we cycled through 100 columns	compare A to 0x63 (99)		have worked 0-99 = 100 columns
      bne LoadImageRow_3	
      rts
    LoadImageRow_4:
      lda win11_4, y
      sta (vidpage), y ; write A register to address vidpage + y
      iny
      tya	;transfer Y to accumulator
      cmp #$64 ; if we cycled through 100 columns	compare A to 0x63 (99)		have worked 0-99 = 100 columns
      bne LoadImageRow_4
      rts
    LoadImageRow_5:
      lda win11_5, y
      sta (vidpage), y ; write A register to address vidpage + y
      iny
      tya	;transfer Y to accumulator
      cmp #$64 ; if we cycled through 100 columns	compare A to 0x63 (99)		have worked 0-99 = 100 columns
      bne LoadImageRow_5	
      rts
    LoadImageRow_6:
      lda win11_6, y
      sta (vidpage), y ; write A register to address vidpage + y
      iny
      tya	;transfer Y to accumulator
      cmp #$64 ; if we cycled through 100 columns	compare A to 0x63 (99)		have worked 0-99 = 100 columns
      bne LoadImageRow_6	
      rts
    LoadImageRow_7:
      lda win11_7, y
      sta (vidpage), y ; write A register to address vidpage + y
      iny
      tya	;transfer Y to accumulator
      cmp #$64 ; if we cycled through 100 columns	compare A to 0x63 (99)		have worked 0-99 = 100 columns
      bne LoadImageRow_7
    LoadImageRow_8:
      lda win11_8, y
      sta (vidpage), y ; write A register to address vidpage + y
      iny
      tya	;transfer Y to accumulator
      cmp #$64 ; if we cycled through 100 columns	compare A to 0x63 (99)		have worked 0-99 = 100 columns
      bne LoadImageRow_8	
      rts
    LoadImageRow_9:
      lda win11_9, y
      sta (vidpage), y ; write A register to address vidpage + y
      iny
      tya	;transfer Y to accumulator
      cmp #$64 ; if we cycled through 100 columns	compare A to 0x63 (99)		have worked 0-99 = 100 columns
      bne LoadImageRow_9
    LoadImageRow_10:
      lda win11_10, y
      sta (vidpage), y ; write A register to address vidpage + y
      iny
      tya	;transfer Y to accumulator
      cmp #$64 ; if we cycled through 100 columns	compare A to 0x63 (99)		have worked 0-99 = 100 columns
      bne LoadImageRow_10	
      rts
    LoadImageRow_11:
      lda win11_11, y
      sta (vidpage), y ; write A register to address vidpage + y
      iny
      tya	;transfer Y to accumulator
      cmp #$64 ; if we cycled through 100 columns	compare A to 0x63 (99)		have worked 0-99 = 100 columns
      bne LoadImageRow_11	
      rts
    LoadImageRow_12:
      lda win11_12, y
      sta (vidpage), y ; write A register to address vidpage + y
      iny
      tya	;transfer Y to accumulator
      cmp #$64 ; if we cycled through 100 columns	compare A to 0x63 (99)		have worked 0-99 = 100 columns
      bne LoadImageRow_12	
      rts
    LoadImageRow_13:
      lda win11_13, y
      sta (vidpage), y ; write A register to address vidpage + y
      iny
      tya	;transfer Y to accumulator
      cmp #$64 ; if we cycled through 100 columns	compare A to 0x63 (99)		have worked 0-99 = 100 columns
      bne LoadImageRow_13	
      rts
    LoadImageRow_14:
      lda win11_14, y
      sta (vidpage), y ; write A register to address vidpage + y
      iny
      tya	;transfer Y to accumulator
      cmp #$64 ; if we cycled through 100 columns	compare A to 0x63 (99)		have worked 0-99 = 100 columns
      bne LoadImageRow_14
      rts
    LoadImageRow_15:
      lda win11_15, y
      sta (vidpage), y ; write A register to address vidpage + y
      iny
      tya	;transfer Y to accumulator
      cmp #$64 ; if we cycled through 100 columns	compare A to 0x63 (99)		have worked 0-99 = 100 columns
      bne LoadImageRow_15	
      rts
    LoadImageRow_16:
      lda win11_16, y
      sta (vidpage), y ; write A register to address vidpage + y
      iny
      tya	;transfer Y to accumulator
      cmp #$64 ; if we cycled through 100 columns	compare A to 0x63 (99)		have worked 0-99 = 100 columns
      bne LoadImageRow_16	
      rts
    LoadImageRow_17:
      lda win11_17, y
      sta (vidpage), y ; write A register to address vidpage + y
      iny
      tya	;transfer Y to accumulator
      cmp #$64 ; if we cycled through 100 columns	compare A to 0x63 (99)		have worked 0-99 = 100 columns
      bne LoadImageRow_17
    LoadImageRow_18:
      lda win11_18, y
      sta (vidpage), y ; write A register to address vidpage + y
      iny
      tya	;transfer Y to accumulator
      cmp #$64 ; if we cycled through 100 columns	compare A to 0x63 (99)		have worked 0-99 = 100 columns
      bne LoadImageRow_18	
      rts
    LoadImageRow_19:
      lda win11_19, y
      sta (vidpage), y ; write A register to address vidpage + y
      iny
      tya	;transfer Y to accumulator
      cmp #$64 ; if we cycled through 100 columns	compare A to 0x63 (99)		have worked 0-99 = 100 columns
      bne LoadImageRow_19
    LoadImageRow_20:
      lda win11_20, y
      sta (vidpage), y ; write A register to address vidpage + y
      iny
      tya	;transfer Y to accumulator
      cmp #$64 ; if we cycled through 100 columns	compare A to 0x63 (99)		have worked 0-99 = 100 columns
      bne LoadImageRow_20	
      rts
    LoadImageRow_21:
      lda win11_21, y
      sta (vidpage), y ; write A register to address vidpage + y
      iny
      tya	;transfer Y to accumulator
      cmp #$64 ; if we cycled through 100 columns	compare A to 0x63 (99)		have worked 0-99 = 100 columns
      bne LoadImageRow_21	
      rts
    LoadImageRow_22:
      lda win11_22, y
      sta (vidpage), y ; write A register to address vidpage + y
      iny
      tya	;transfer Y to accumulator
      cmp #$64 ; if we cycled through 100 columns	compare A to 0x63 (99)		have worked 0-99 = 100 columns
      bne LoadImageRow_22	
      rts
    LoadImageRow_23:
      lda win11_23, y
      sta (vidpage), y ; write A register to address vidpage + y
      iny
      tya	;transfer Y to accumulator
      cmp #$64 ; if we cycled through 100 columns	compare A to 0x63 (99)		have worked 0-99 = 100 columns
      bne LoadImageRow_23	
      rts
    LoadImageRow_24:
      lda win11_24, y
      sta (vidpage), y ; write A register to address vidpage + y
      iny
      tya	;transfer Y to accumulator
      cmp #$64 ; if we cycled through 100 columns	compare A to 0x63 (99)		have worked 0-99 = 100 columns
      bne LoadImageRow_24
      rts
    LoadImageRow_25:
      lda win11_25, y
      sta (vidpage), y ; write A register to address vidpage + y
      iny
      tya	;transfer Y to accumulator
      cmp #$64 ; if we cycled through 100 columns	compare A to 0x63 (99)		have worked 0-99 = 100 columns
      bne LoadImageRow_25	
      rts
    LoadImageRow_26:
      lda win11_26, y
      sta (vidpage), y ; write A register to address vidpage + y
      iny
      tya	;transfer Y to accumulator
      cmp #$64 ; if we cycled through 100 columns	compare A to 0x63 (99)		have worked 0-99 = 100 columns
      bne LoadImageRow_26	
      rts
    LoadImageRow_27:
      lda win11_27, y
      sta (vidpage), y ; write A register to address vidpage + y
      iny
      tya	;transfer Y to accumulator
      cmp #$64 ; if we cycled through 100 columns	compare A to 0x63 (99)		have worked 0-99 = 100 columns
      bne LoadImageRow_27
    LoadImageRow_28:
      lda win11_28, y
      sta (vidpage), y ; write A register to address vidpage + y
      iny
      tya	;transfer Y to accumulator
      cmp #$64 ; if we cycled through 100 columns	compare A to 0x63 (99)		have worked 0-99 = 100 columns
      bne LoadImageRow_28	
      rts
    LoadImageRow_29:
      lda win11_29, y
      sta (vidpage), y ; write A register to address vidpage + y
      iny
      tya	;transfer Y to accumulator
      cmp #$64 ; if we cycled through 100 columns	compare A to 0x63 (99)		have worked 0-99 = 100 columns
      bne LoadImageRow_29
    LoadImageRow_30:
      lda win11_30, y
      sta (vidpage), y ; write A register to address vidpage + y
      iny
      tya	;transfer Y to accumulator
      cmp #$64 ; if we cycled through 100 columns	compare A to 0x63 (99)		have worked 0-99 = 100 columns
      bne LoadImageRow_30	
      rts
    LoadImageRow_31:
      lda win11_31, y
      sta (vidpage), y ; write A register to address vidpage + y
      iny
      tya	;transfer Y to accumulator
      cmp #$64 ; if we cycled through 100 columns	compare A to 0x63 (99)		have worked 0-99 = 100 columns
      bne LoadImageRow_31	
      rts
    LoadImageRow_32:
      lda win11_32, y
      sta (vidpage), y ; write A register to address vidpage + y
      iny
      tya	;transfer Y to accumulator
      cmp #$64 ; if we cycled through 100 columns	compare A to 0x63 (99)		have worked 0-99 = 100 columns
      bne LoadImageRow_32	
      rts
    LoadImageRow_33:
      lda win11_33, y
      sta (vidpage), y ; write A register to address vidpage + y
      iny
      tya	;transfer Y to accumulator
      cmp #$64 ; if we cycled through 100 columns	compare A to 0x63 (99)		have worked 0-99 = 100 columns
      bne LoadImageRow_33	
      rts
    LoadImageRow_34:
      lda win11_34, y
      sta (vidpage), y ; write A register to address vidpage + y
      iny
      tya	;transfer Y to accumulator
      cmp #$64 ; if we cycled through 100 columns	compare A to 0x63 (99)		have worked 0-99 = 100 columns
      bne LoadImageRow_34
      rts
    LoadImageRow_35:
      lda win11_35, y
      sta (vidpage), y ; write A register to address vidpage + y
      iny
      tya	;transfer Y to accumulator
      cmp #$64 ; if we cycled through 100 columns	compare A to 0x63 (99)		have worked 0-99 = 100 columns
      bne LoadImageRow_35	
      rts
    LoadImageRow_36:
      lda win11_36, y
      sta (vidpage), y ; write A register to address vidpage + y
      iny
      tya	;transfer Y to accumulator
      cmp #$64 ; if we cycled through 100 columns	compare A to 0x63 (99)		have worked 0-99 = 100 columns
      bne LoadImageRow_36	
      rts
    LoadImageRow_37:
      lda win11_37, y
      sta (vidpage), y ; write A register to address vidpage + y
      iny
      tya	;transfer Y to accumulator
      cmp #$64 ; if we cycled through 100 columns	compare A to 0x63 (99)		have worked 0-99 = 100 columns
      bne LoadImageRow_37
    LoadImageRow_38:
      lda win11_38, y
      sta (vidpage), y ; write A register to address vidpage + y
      iny
      tya	;transfer Y to accumulator
      cmp #$64 ; if we cycled through 100 columns	compare A to 0x63 (99)		have worked 0-99 = 100 columns
      bne LoadImageRow_38	
      rts
    LoadImageRow_39:
      lda win11_39, y
      sta (vidpage), y ; write A register to address vidpage + y
      iny
      tya	;transfer Y to accumulator
      cmp #$64 ; if we cycled through 100 columns	compare A to 0x63 (99)		have worked 0-99 = 100 columns
      bne LoadImageRow_39
    LoadImageRow_40:
      lda win11_40, y
      sta (vidpage), y ; write A register to address vidpage + y
      iny
      tya	;transfer Y to accumulator
      cmp #$64 ; if we cycled through 100 columns	compare A to 0x63 (99)		have worked 0-99 = 100 columns
      bne LoadImageRow_40	
      rts
    LoadImageRow_41:
      lda win11_41, y
      sta (vidpage), y ; write A register to address vidpage + y
      iny
      tya	;transfer Y to accumulator
      cmp #$64 ; if we cycled through 100 columns	compare A to 0x63 (99)		have worked 0-99 = 100 columns
      bne LoadImageRow_41	
      rts
    LoadImageRow_42:
      lda win11_42, y
      sta (vidpage), y ; write A register to address vidpage + y
      iny
      tya	;transfer Y to accumulator
      cmp #$64 ; if we cycled through 100 columns	compare A to 0x63 (99)		have worked 0-99 = 100 columns
      bne LoadImageRow_42	
      rts
    LoadImageRow_43:
      lda win11_43, y
      sta (vidpage), y ; write A register to address vidpage + y
      iny
      tya	;transfer Y to accumulator
      cmp #$64 ; if we cycled through 100 columns	compare A to 0x63 (99)		have worked 0-99 = 100 columns
      bne LoadImageRow_43	
      rts
    LoadImageRow_44:
      lda win11_44, y
      sta (vidpage), y ; write A register to address vidpage + y
      iny
      tya	;transfer Y to accumulator
      cmp #$64 ; if we cycled through 100 columns	compare A to 0x63 (99)		have worked 0-99 = 100 columns
      bne LoadImageRow_44
      rts
    LoadImageRow_45:
      lda win11_45, y
      sta (vidpage), y ; write A register to address vidpage + y
      iny
      tya	;transfer Y to accumulator
      cmp #$64 ; if we cycled through 100 columns	compare A to 0x63 (99)		have worked 0-99 = 100 columns
      bne LoadImageRow_45	
      rts
    LoadImageRow_46:
      lda win11_46, y
      sta (vidpage), y ; write A register to address vidpage + y
      iny
      tya	;transfer Y to accumulator
      cmp #$64 ; if we cycled through 100 columns	compare A to 0x63 (99)		have worked 0-99 = 100 columns
      bne LoadImageRow_46	
      rts
    LoadImageRow_47:
      lda win11_47, y
      sta (vidpage), y ; write A register to address vidpage + y
      iny
      tya	;transfer Y to accumulator
      cmp #$64 ; if we cycled through 100 columns	compare A to 0x63 (99)		have worked 0-99 = 100 columns
      bne LoadImageRow_47
    LoadImageRow_48:
      lda win11_48, y
      sta (vidpage), y ; write A register to address vidpage + y
      iny
      tya	;transfer Y to accumulator
      cmp #$64 ; if we cycled through 100 columns	compare A to 0x63 (99)		have worked 0-99 = 100 columns
      bne LoadImageRow_48	
      rts
    LoadImageRow_49:
      lda win11_49, y
      sta (vidpage), y ; write A register to address vidpage + y
      iny
      tya	;transfer Y to accumulator
      cmp #$64 ; if we cycled through 100 columns	compare A to 0x63 (99)		have worked 0-99 = 100 columns
      bne LoadImageRow_49
    LoadImageRow_50:
      lda win11_50, y
      sta (vidpage), y ; write A register to address vidpage + y
      iny
      tya	;transfer Y to accumulator
      cmp #$64 ; if we cycled through 100 columns	compare A to 0x63 (99)		have worked 0-99 = 100 columns
      bne LoadImageRow_50	
      rts
    LoadImageRow_51:
      lda win11_51, y
      sta (vidpage), y ; write A register to address vidpage + y
      iny
      tya	;transfer Y to accumulator
      cmp #$64 ; if we cycled through 100 columns	compare A to 0x63 (99)		have worked 0-99 = 100 columns
      bne LoadImageRow_51	
      rts
    LoadImageRow_52:
      lda win11_52, y
      sta (vidpage), y ; write A register to address vidpage + y
      iny
      tya	;transfer Y to accumulator
      cmp #$64 ; if we cycled through 100 columns	compare A to 0x63 (99)		have worked 0-99 = 100 columns
      bne LoadImageRow_52	
      rts
    LoadImageRow_53:
      lda win11_53, y
      sta (vidpage), y ; write A register to address vidpage + y
      iny
      tya	;transfer Y to accumulator
      cmp #$64 ; if we cycled through 100 columns	compare A to 0x63 (99)		have worked 0-99 = 100 columns
      bne LoadImageRow_53	
      rts
    LoadImageRow_54:
      lda win11_54, y
      sta (vidpage), y ; write A register to address vidpage + y
      iny
      tya	;transfer Y to accumulator
      cmp #$64 ; if we cycled through 100 columns	compare A to 0x63 (99)		have worked 0-99 = 100 columns
      bne LoadImageRow_54
      rts
    LoadImageRow_55:
      lda win11_55, y
      sta (vidpage), y ; write A register to address vidpage + y
      iny
      tya	;transfer Y to accumulator
      cmp #$64 ; if we cycled through 100 columns	compare A to 0x63 (99)		have worked 0-99 = 100 columns
      bne LoadImageRow_55	
      rts
    LoadImageRow_56:
      lda win11_56, y
      sta (vidpage), y ; write A register to address vidpage + y
      iny
      tya	;transfer Y to accumulator
      cmp #$64 ; if we cycled through 100 columns	compare A to 0x63 (99)		have worked 0-99 = 100 columns
      bne LoadImageRow_56	
      rts
    LoadImageRow_57:
      lda win11_57, y
      sta (vidpage), y ; write A register to address vidpage + y
      iny
      tya	;transfer Y to accumulator
      cmp #$64 ; if we cycled through 100 columns	compare A to 0x63 (99)		have worked 0-99 = 100 columns
      bne LoadImageRow_57
    LoadImageRow_58:
      lda win11_58, y
      sta (vidpage), y ; write A register to address vidpage + y
      iny
      tya	;transfer Y to accumulator
      cmp #$64 ; if we cycled through 100 columns	compare A to 0x63 (99)		have worked 0-99 = 100 columns
      bne LoadImageRow_58	
      rts
    LoadImageRow_59:
      lda win11_59, y
      sta (vidpage), y ; write A register to address vidpage + y
      iny
      tya	;transfer Y to accumulator
      cmp #$64 ; if we cycled through 100 columns	compare A to 0x63 (99)		have worked 0-99 = 100 columns
      bne LoadImageRow_59
    LoadImageRow_60:
      lda win11_60, y
      sta (vidpage), y ; write A register to address vidpage + y
      iny
      tya	;transfer Y to accumulator
      cmp #$64 ; if we cycled through 100 columns	compare A to 0x63 (99)		have worked 0-99 = 100 columns
      bne LoadImageRow_60	
      rts
    LoadImageRow_61:
      lda win11_61, y
      sta (vidpage), y ; write A register to address vidpage + y
      iny
      tya	;transfer Y to accumulator
      cmp #$64 ; if we cycled through 100 columns	compare A to 0x63 (99)		have worked 0-99 = 100 columns
      bne LoadImageRow_61	
      rts
    LoadImageRow_62:
      lda win11_62, y
      sta (vidpage), y ; write A register to address vidpage + y
      iny
      tya	;transfer Y to accumulator
      cmp #$64 ; if we cycled through 100 columns	compare A to 0x63 (99)		have worked 0-99 = 100 columns
      bne LoadImageRow_62	
      rts
    LoadImageRow_63:
      lda win11_63, y
      sta (vidpage), y ; write A register to address vidpage + y
      iny
      tya	;transfer Y to accumulator
      cmp #$64 ; if we cycled through 100 columns	compare A to 0x63 (99)		have worked 0-99 = 100 columns
      bne LoadImageRow_63	
      rts

nmi:
  rti

;Predefined messages
message1 db "Ready...", 0
message2 db "Windows 11 BE", 0
message3 db "Reading temp...", 0
message4 db "...", 0
message5 db "...", 0
message6 db "...", 0
message7 db "...", 0
message8 db "...", 0

;Lookups
hexOutLookup db "0123456789ABCDEF", 0

 .org $b000    ; Windows logo graphic -- 3000 in ROM binary file
    win11_0:    .byte "????????????????????????????????????????????????????????????????????????????????????????????????????"
    win11_1:    .byte "????????????????????????????????????????????????????????????????????????????????????????????????????"
    win11_2:    .byte "????????????????????????????????????????????????????????????????????????????????????????????????????"
    win11_3:    .byte "????????????????????????????????????????????????????????????????????????????????????????????????????"
    win11_4:    .byte "????????????????????????????????????????????????????????????????????????????????????????????????????"
    win11_5:    .byte "????????????????????????????????????????????????????????????????????????????????????????????????????"
    win11_6:    .byte "????????????????????????????????????????????????????????????????????????????????????????????????????"
    win11_7:    .byte "????????????????????????????????????????????????????????????????????????????????????????????????????"
    win11_8:    .byte "????????????????????????????????????????????????????????????????????????????????????????????????????"
    win11_9:    .byte "???????????????????????????????????????????>:::::???????????????????????????????????????????????????"
    win11_10:   .byte "????????????????????????????????????????::955555599:????????????????????????????????????????????????"
    win11_11:   .byte "???????????????????????????????????????95555555555559>??????????????????????????????????????????????"
    win11_12:   .byte "??????????????????????????????????????:555555555555559??????????????????????????????????????????????"
    win11_13:   .byte "??????????????????????????????????????:55555555555555:??>???????????????????????????????????????????"
    win11_14:   .byte "??????????????????????????????????????955555555555555??-(.???????????.>?????????????????????????????"
    win11_15:   .byte "??????????????????????????????????????555555555555559??-,().>>??>>.--(>?????????????????????????????"
    win11_16:   .byte "?????????????????????????????????????:55555555555555:?>(((((((-)((((,-??????????????????????????????"
    win11_17:   .byte "?????????????????????????????????????955555555555555:?.((((((((((((((-??????????????????????????????"
    win11_18:   .byte "?????????????????????????????????????555555555555555??-((((((((((((((>??????????????????????????????"
    win11_19:    .byte "????????????????????????????????????:555555555555559??)((((((((((((()???????????????????????????????"
    win11_20:    .byte "????????????????????????????????????:55555555555555:?>((((((((((((((-???????????????????????????????"
    win11_21:    .byte "????????????????????????????????????955555555555555??.((((((((((((((.???????????????????????????????"
    win11_22:    .byte "???????????????????????????????????>555999999955559??-((((((((((((((>???????????????????????????????"
    win11_23:    .byte "???????????????????????????????????:99:???????:955:??(((((((((((((()????????????????????????????????"
    win11_24:    .byte "????????????????????????????????????????????????:9>?>((((((((((((((-????????????????????????????????"
    win11_25:    .byte "?????????????????????????????????????//??????-((((((((((((((>????????????????????????????????"
    win11_26:    .byte "???????????????????????????????????????-,(((((((((((,(?????????????????????????????????"
    win11_27:    .byte "??????????????????????????????????/???-((((((((((((.?????????????????????????????????"
    win11_28:    .byte "??????????????????????????????????/????>-)((((()-.???????????????????????????????????"
    win11_29:    .byte "?????????????????????????????????/??=>????>>.>>??????????????????????????????????????"
    win11_30:    .byte "?????????????????????????????????/??88=>>??????>>==??????????????????????????????????"
    win11_31:    .byte "?????????????????????????????????/?>8888=======98<=??????????????????????????????????"
    win11_32:    .byte "???????????????????????????????????=88888888888888>??????????????????????????????????"
    win11_33:    .byte "????????????????????????????????/??988888888888888???????????????????????????????????"
    win11_34:    .byte "????????????????????????????????//?>88888888888888=???????????????????????????????????"
    win11_35:    .byte "????????????????????????????????/?=88888888888888>???????????????????????????????????"
    win11_36:    .byte "??????????????????????????????????=88888888888888>???????????????????????????????????"
    win11_37:    .byte "???????????????????????????????/?>88888888888888=????????????????????????????????????"
    win11_38:    .byte "???????????????????????????????/////?>88888888888888=????????????????????????????????????"
    win11_39:    .byte "???????????????????????????????//????????/??=88888888888888>????????????????????????????????????"
    win11_40:    .byte "????????????????????????????????????????????//??988888888888889?????????????????????????????????????"
    win11_41:    .byte "???????????????????????????????????????????????>8888888888888<=?????????????????????????????????????"
    win11_42:    .byte "????????????????????????????????????????????????=888888888888<>?????????????????????????????????????"
    win11_43:    .byte "?????????????????????????????????????????????????>==888888<9=>??????????????????????????????????????"
    win11_44:    .byte "????????????????????????????????????????????????????>====>>?????????????????????????????????????????"
    win11_45:    .byte "????????????????????????????????????????????????????????????????????????????????????????????????????"
    win11_46:    .byte "????????????????????????????????????????????????????????????????????????????????????????????????????"
    win11_47:    .byte "????????????????????????????????????????????????????????????????????????????????????????????????????"
    win11_48:    .byte "????????????????????????????????????????????????????????????????????????????????????????????????????"
    win11_49:    .byte "????????????????????????????????????????????????????????????????????????????????????????????????????"
    win11_50:    .byte "????????????????????????????????????????????????????????????????????????????????????????????????????"
    win11_51:    .byte "????????????????????????????????????????????????????????????????????????????????????????????????????"
    win11_52:    .byte "????????????????????????????????????????????????????????????????????????????????????????????????????"
    win11_53:    .byte "????????????????????????????????????????????????????????????????????????????????????????????????????"
    win11_54:    .byte "????????????????????????????????????????????????????????????????????????????????????????????????????"
    win11_55:    .byte "????????????????????????????????????????????????????????????????????????????????????????????????????"
    win11_56:    .byte "????????????????????????????????????????????????????????????????????????????????????????????????????"
    win11_57:    .byte "????????????????????????????????????????????????????????????????????????????????????????????????????"
    win11_58:    .byte "????????????????????????????????????????????????????????????????????????????????????????????????????"
    win11_59:    .byte "????????????????????????????????????????????????????????????????????????????????????????????????????"
    win11_60:    .byte "????????????????????????????????????????????????????????????????????????????????????????????????????"
    win11_61:    .byte "????????????????????????????????????????????????????????????????????????????????????????????????????"
    win11_62:    .byte "????????????????????????????????????????????????????????????????????????????????????????????????????"
    win11_63:    .byte "????????????????????????????????????????????????????????????????????????????????????????????????????"

;Char pixel data
  ; Represent a 5x7 font (35 points/bits of data required)
  ; Store each character graphic as 8 bytes. This will waste 3 bits per byte (last three bits of seven bytes/rows) and one entire empty byte (row 8)
  ;                                          This extra room could be used to add support for font sizes up to 8x8 pixels per character.
  ; The first 5 bits of each byte will represent the pixels for a single row of the character. Last three bits of each row as zeros.
  ; Example - '8':
  ;  ***            = %01110000
  ; *   *           = %10001000
  ; *   *           = %10001000
  ;  ***            = %01110000
  ; *   *           = %10001000
  ; *   *           = %10001000
  ;  ***            = %01110000
  ; -empty-         = %00000000
  ; To reference, start at memory address for .org below.

 .org $f000    ; 7000 in ROM binary file
charmap1:   ;ASCII 0x20 to 0x3F
  ;Start with ASCII 0x20 = space
  ;Each character will consume 8 bytes of data (for the 8 potential rows of pixel data)
  ;This results in only being able to address 32 characters in each charmap. Additional charmaps for characters #33 and beyond.
      ;char:SPACE ascii:0x20      charmap_location:0x00
          .byte %00000000
          .byte %00000000
          .byte %00000000
          .byte %00000000
          .byte %00000000
          .byte %00000000
          .byte %00000000
          .byte %00000000
      ;char:!     ascii:0x21      charmap_location:0x08 (increase by 8 bits/rows per char)
          .byte %00100000
          .byte %00100000
          .byte %00100000
          .byte %00100000
          .byte %00100000
          .byte %00000000
          .byte %00100000
          .byte %00000000
      ;char:'"'     ascii:0x22      charmap_location:0x10
          .byte %01010000
          .byte %01010000
          .byte %01010000
          .byte %00000000
          .byte %00000000
          .byte %00000000
          .byte %00000000
          .byte %00000000
      ;char:'#'     ascii:0x23      charmap_location:0x18
          .byte %01010000
          .byte %01010000
          .byte %11111000
          .byte %01010000
          .byte %11111000
          .byte %01010000
          .byte %01010000
          .byte %00000000
      ;char:$     ascii:0x24      charmap_location:0x20
          .byte %00100000
          .byte %01111000
          .byte %10100000
          .byte %01110000
          .byte %00101000
          .byte %11110000
          .byte %00100000
          .byte %00000000
      ;char:%     ascii:0x25      charmap_location:0x28
          .byte %11000000
          .byte %11001000
          .byte %00010000
          .byte %00100000
          .byte %01000000
          .byte %10011000
          .byte %00011000
          .byte %00000000
      ;char:&     ascii:0x26      charmap_location:0x30
          .byte %01100000
          .byte %10010000
          .byte %10100000
          .byte %01000000
          .byte %10101000
          .byte %10010000
          .byte %01101000
          .byte %00000000
      ;char:''     ascii:0x27      charmap_location:0x38
          .byte %00100000
          .byte %00100000
          .byte %00000000
          .byte %00000000
          .byte %00000000
          .byte %00000000
          .byte %00000000
          .byte %00000000
      ;char:(     ascii:0x28      charmap_location:0x40
          .byte %00010000
          .byte %00100000
          .byte %01000000
          .byte %01000000
          .byte %01000000
          .byte %00100000
          .byte %00010000
          .byte %00000000
      ;char:)     ascii:0x29      charmap_location:0x48
          .byte %01000000
          .byte %00100000
          .byte %00010000
          .byte %00010000
          .byte %00010000
          .byte %00100000
          .byte %01000000
          .byte %00000000
      ;char:*     ascii:0x2A      charmap_location:0x50
          .byte %00000000
          .byte %00100000
          .byte %10101000
          .byte %01110000
          .byte %10101000
          .byte %00100000
          .byte %00000000
          .byte %00000000
      ;char:+     ascii:0x2B      charmap_location:0x58
          .byte %00000000
          .byte %00100000
          .byte %00100000
          .byte %11111000
          .byte %00100000
          .byte %00100000
          .byte %00000000
          .byte %00000000
      ;char:,     ascii:0x2C      charmap_location:0x60
          .byte %00000000
          .byte %00000000
          .byte %00000000
          .byte %00000000
          .byte %00110000
          .byte %00010000
          .byte %00100000
          .byte %00000000
      ;char:-     ascii:0x2D      charmap_location:0x68
          .byte %00000000
          .byte %00000000
          .byte %00000000
          .byte %11111000
          .byte %00000000
          .byte %00000000
          .byte %00000000
          .byte %00000000
      ;char:.     ascii:0x2E      charmap_location:0x70
          .byte %00000000
          .byte %00000000
          .byte %00000000
          .byte %00000000
          .byte %00000000
          .byte %01100000
          .byte %01100000
          .byte %00000000
      ;char:/     ascii:0x2F      charmap_location:0x78
          .byte %00000000
          .byte %00001000
          .byte %00010000
          .byte %00100000
          .byte %01000000
          .byte %10000000
          .byte %00000000
          .byte %00000000
      ;char:0     ascii:0x30      charmap_location:0x80
          .byte %01110000
          .byte %10001000
          .byte %10011000
          .byte %10101000
          .byte %11001000
          .byte %10001000
          .byte %01110000
          .byte %00000000
      ;char:1     ascii:0x31      charmap_location:0x88
          .byte %00100000
          .byte %01100000
          .byte %00100000
          .byte %00100000
          .byte %00100000
          .byte %00100000
          .byte %01110000
          .byte %00000000
      ;char:2     ascii:0x32      charmap_location:0x90
          .byte %01110000
          .byte %10001000
          .byte %00001000
          .byte %00110000
          .byte %01000000
          .byte %10000000
          .byte %11111000
          .byte %00000000
      ;char:3     ascii:0x33      charmap_location:0x98
          .byte %01110000
          .byte %10001000
          .byte %00001000
          .byte %00110000
          .byte %00001000
          .byte %10001000
          .byte %01110000
          .byte %00000000
      ;char:4     ascii:0x34      charmap_location:0xA0
          .byte %00010000
          .byte %00110000
          .byte %01010000
          .byte %10010000
          .byte %11111000
          .byte %00010000
          .byte %00010000
          .byte %00000000
       ;char:5     ascii:0x35      charmap_location:0xA8
          .byte %11111000
          .byte %10000000
          .byte %11110000
          .byte %00001000
          .byte %00001000
          .byte %10001000
          .byte %01110000
          .byte %00000000
       ;char:6     ascii:0x36      charmap_location:0xB0
          .byte %00110000
          .byte %01000000
          .byte %10000000
          .byte %11110000
          .byte %10001000
          .byte %10001000
          .byte %01110000
          .byte %00000000
        ;char:7     ascii:0x37      charmap_location:0xB8
          .byte %11111000
          .byte %00001000
          .byte %00010000
          .byte %00100000
          .byte %01000000
          .byte %01000000
          .byte %01000000
          .byte %00000000
         ;char:8     ascii:0x38      charmap_location:0xC0
         .byte %01110000
         .byte %10001000
         .byte %10001000
         .byte %01110000
         .byte %10001000
         .byte %10001000
         .byte %01110000
         .byte %00000000
         ;char:9     ascii:0x39      charmap_location:0xC8
          .byte %01110000
          .byte %10001000
          .byte %10001000
          .byte %01111000
          .byte %00001000
          .byte %00010000
          .byte %01100000
          .byte %00000000
         ;char:':'     ascii:0x3A      charmap_location:0xD0
          .byte %00000000
          .byte %01100000
          .byte %01100000
          .byte %00000000
          .byte %01100000
          .byte %01100000
          .byte %00000000
          .byte %00000000
         ;char:;     ascii:0x3B      charmap_location:0xD8
          .byte %00000000
          .byte %01100000
          .byte %01100000
          .byte %00000000
          .byte %01100000
          .byte %00100000
          .byte %01000000
          .byte %00000000
         ;char:<     ascii:0x3C      charmap_location:0xE0
          .byte %00010000
          .byte %00100000
          .byte %01000000
          .byte %10000000
          .byte %01000000
          .byte %00100000
          .byte %00010000
          .byte %00000000
         ;char:=     ascii:0x3D      charmap_location:0xE8
          .byte %00000000
          .byte %00000000
          .byte %11111000
          .byte %00000000
          .byte %11111000
          .byte %00000000
          .byte %00000000
          .byte %00000000
         ;char:>     ascii:0x3E      charmap_location:0xF0
          .byte %01000000
          .byte %00100000
          .byte %00010000
          .byte %00001000
          .byte %00010000
          .byte %00100000
          .byte %01000000
          .byte %00000000
         ;char:?     ascii:0x3F      charmap_location:0xF8
          .byte %01110000
          .byte %10001000
          .byte %00001000
          .byte %00010000
          .byte %00100000
          .byte %00000000
          .byte %00100000
          .byte %00000000

 .org $f200    ; 7200 in ROM binary file
charmap2:   ;ASCII 0x40 to 0x5F
     ;char:'@'     ascii:0x40      charmap_location:0x00
      .byte %01110000
      .byte %10001000
      .byte %00001000
      .byte %01101000
      .byte %10101000
      .byte %10101000
      .byte %01110000
      .byte %00000000
     ;char:A     ascii:0x41      charmap_location:0x08
      .byte %00100000
      .byte %01010000
      .byte %10001000
      .byte %10001000
      .byte %11111000
      .byte %10001000
      .byte %10001000
      .byte %00000000
     ;char:B     ascii:0x42      charmap_location:0x10
      .byte %11110000
      .byte %01001000
      .byte %01001000
      .byte %01110000
      .byte %01001000
      .byte %01001000
      .byte %11110000
      .byte %00000000
     ;char:C     ascii:0x43      charmap_location:0x18
      .byte %01110000
      .byte %10001000
      .byte %10000000
      .byte %10000000
      .byte %10000000
      .byte %10001000
      .byte %01110000
      .byte %00000000
     ;char:D     ascii:0x44      charmap_location:0x20
      .byte %11110000
      .byte %01001000
      .byte %01001000
      .byte %01001000
      .byte %01001000
      .byte %01001000
      .byte %11110000
      .byte %00000000
     ;char:E     ascii:0x45      charmap_location:0x28
      .byte %11111000
      .byte %10000000
      .byte %10000000
      .byte %11110000
      .byte %10000000
      .byte %10000000
      .byte %11111000
      .byte %00000000
     ;char:F     ascii:0x46      charmap_location:0x30
      .byte %11111000
      .byte %10000000
      .byte %10000000
      .byte %11110000
      .byte %10000000
      .byte %10000000
      .byte %10000000
      .byte %00000000
     ;char:G     ascii:0x47      charmap_location:0x38
      .byte %01110000
      .byte %10001000
      .byte %10000000
      .byte %10011000
      .byte %10001000
      .byte %10001000
      .byte %01111000
      .byte %00000000
     ;char:H     ascii:0x48      charmap_location:0x40
      .byte %10001000
      .byte %10001000
      .byte %10001000
      .byte %11111000
      .byte %10001000
      .byte %10001000
      .byte %10001000
      .byte %00000000
     ;char:I     ascii:0x49      charmap_location:0x48
      .byte %01110000
      .byte %00100000
      .byte %00100000
      .byte %00100000
      .byte %00100000
      .byte %00100000
      .byte %01110000
      .byte %00000000
     ;char:J     ascii:0x4A      charmap_location:0x50
      .byte %00111000
      .byte %00010000
      .byte %00010000
      .byte %00010000
      .byte %00010000
      .byte %10010000
      .byte %01100000
      .byte %00000000
     ;char:K     ascii:0x4B      charmap_location:0x58
      .byte %10001000
      .byte %10010000
      .byte %10100000
      .byte %11000000
      .byte %10100000
      .byte %10010000
      .byte %10001000
      .byte %00000000
     ;char:L     ascii:0x4C      charmap_location:0x60
      .byte %10000000
      .byte %10000000
      .byte %10000000
      .byte %10000000
      .byte %10000000
      .byte %10000000
      .byte %11111000
      .byte %00000000
     ;char:M     ascii:0x4D      charmap_location:0x68
      .byte %10001000
      .byte %11011000
      .byte %10101000
      .byte %10101000
      .byte %10001000
      .byte %10001000
      .byte %10001000
      .byte %00000000
     ;char:N     ascii:0x4E      charmap_location:0x70
      .byte %10001000
      .byte %10001000
      .byte %11001000
      .byte %10101000
      .byte %10011000
      .byte %10001000
      .byte %10001000
      .byte %00000000
     ;char:O     ascii:0x4F      charmap_location:0x78
      .byte %01110000
      .byte %10001000
      .byte %10001000
      .byte %10001000
      .byte %10001000
      .byte %10001000
      .byte %01110000
      .byte %00000000
     ;char:P     ascii:0x50      charmap_location:0x80
      .byte %11110000
      .byte %10001000
      .byte %10001000
      .byte %11110000
      .byte %10000000
      .byte %10000000
      .byte %10000000
      .byte %00000000
     ;char:Q     ascii:0x51      charmap_location:0x88
      .byte %01110000
      .byte %10001000
      .byte %10001000
      .byte %10001000
      .byte %10101000
      .byte %10010000
      .byte %01101000
      .byte %00000000
     ;char:R     ascii:0x52      charmap_location:0x90
      .byte %11110000
      .byte %10001000
      .byte %10001000
      .byte %11110000
      .byte %10100000
      .byte %10010000
      .byte %10001000
      .byte %00000000
     ;char:S     ascii:0x53     charmap_location:0x98
      .byte %01110000
      .byte %10001000
      .byte %10000000
      .byte %01110000
      .byte %00001000
      .byte %10001000
      .byte %01110000
      .byte %00000000
     ;char:T     ascii:0x54      charmap_location:0xA0
      .byte %11111000
      .byte %00100000
      .byte %00100000
      .byte %00100000
      .byte %00100000
      .byte %00100000
      .byte %00100000
      .byte %00000000
     ;char:U     ascii:0x55      charmap_location:0xA8
      .byte %10001000
      .byte %10001000
      .byte %10001000
      .byte %10001000
      .byte %10001000
      .byte %10001000
      .byte %01110000
      .byte %00000000
     ;char:V     ascii:0x56      charmap_location:0xB0
      .byte %10001000
      .byte %10001000
      .byte %10001000
      .byte %10001000
      .byte %10001000
      .byte %01010000
      .byte %00100000
      .byte %00000000
     ;char:W     ascii:0x57      charmap_location:0xB8
      .byte %10001000
      .byte %10001000
      .byte %10001000
      .byte %10101000
      .byte %10101000
      .byte %10101000
      .byte %01010000
      .byte %00000000
     ;char:X     ascii:0x58      charmap_location:0xC0
      .byte %10001000
      .byte %10001000
      .byte %01010000
      .byte %00100000
      .byte %01010000
      .byte %10001000
      .byte %10001000
      .byte %00000000
     ;char:Y     ascii:0x59      charmap_location:0xC8
      .byte %10001000
      .byte %10001000
      .byte %01010000
      .byte %00100000
      .byte %00100000
      .byte %00100000
      .byte %00100000
      .byte %00000000
     ;char:Z     ascii:0x5A      charmap_location:0xD0
      .byte %11111000
      .byte %00001000
      .byte %00010000
      .byte %00100000
      .byte %01000000
      .byte %10000000
      .byte %11111000
      .byte %00000000
     ;char:[     ascii:0x5B      charmap_location:0xD8
      .byte %01110000
      .byte %01000000
      .byte %01000000
      .byte %01000000
      .byte %01000000
      .byte %01000000
      .byte %01110000
      .byte %00000000
     ;char:\     ascii:0x5C      charmap_location:0xE0
      .byte %00000000
      .byte %10000000
      .byte %01000000
      .byte %00100000
      .byte %00010000
      .byte %00001000
      .byte %00000000
      .byte %00000000
     ;char:]     ascii:0x5D      charmap_location:0xE8
      .byte %01110000
      .byte %00010000
      .byte %00010000
      .byte %00010000
      .byte %00010000
      .byte %00010000
      .byte %01110000
      .byte %00000000
     ;char:^     ascii:0x5E      charmap_location:0xF0
      .byte %00100000
      .byte %01010000
      .byte %10001000
      .byte %00000000
      .byte %00000000
      .byte %00000000
      .byte %00000000
      .byte %00000000
     ;char:_     ascii:0x5F      charmap_location:0xF8
      .byte %00000000
      .byte %00000000
      .byte %00000000
      .byte %00000000
      .byte %00000000
      .byte %00000000
      .byte %11111000
      .byte %00000000

 .org $f400    ; 7400 in ROM binary file
charmap3:   ;ASCII 0x60 to 0x7F
    ;char:`     ascii:0x60      charmap_location:0x00
      .byte %10000000
      .byte %01000000
      .byte %00100000
      .byte %00000000
      .byte %00000000
      .byte %00000000
      .byte %00000000
      .byte %00000000

    ;char:a     ascii:0x61      charmap_location:0x08
      .byte %00000000
      .byte %00000000
      .byte %01110000
      .byte %00001000
      .byte %01111000
      .byte %10001000
      .byte %01111000
      .byte %00000000

    ;char:b     ascii:0x62      charmap_location:0x10
      .byte %10000000
      .byte %10000000
      .byte %10110000
      .byte %11001000
      .byte %10001000
      .byte %10001000
      .byte %11110000
      .byte %00000000

    ;char:c     ascii:0x63      charmap_location:0x18
      .byte %00000000
      .byte %00000000
      .byte %01110000
      .byte %10000000
      .byte %10000000
      .byte %10001000
      .byte %01110000
      .byte %00000000

    ;char:d     ascii:0x64      charmap_location:0x20
      .byte %00001000
      .byte %00001000
      .byte %01101000
      .byte %10011000
      .byte %10001000
      .byte %10001000
      .byte %01111000
      .byte %00000000

    ;char:e     ascii:0x65      charmap_location:0x28
      .byte %00000000
      .byte %00000000
      .byte %01110000
      .byte %10001000
      .byte %11111000
      .byte %10000000
      .byte %01110000
      .byte %00000000

    ;char:f     ascii:0x66      charmap_location:0x30
      .byte %00110000
      .byte %01001000
      .byte %01000000
      .byte %11100000
      .byte %01000000
      .byte %01000000
      .byte %01000000
      .byte %00000000

    ;char:g     ascii:0x67      charmap_location:0x38
      .byte %00000000
      .byte %00000000
      .byte %01111000
      .byte %10001000
      .byte %01111000
      .byte %00001000
      .byte %01110000
      .byte %00000000

    ;char:h     ascii:0x68      charmap_location:0x40
      .byte %10000000
      .byte %10000000
      .byte %10110000
      .byte %11001000
      .byte %10001000
      .byte %10001000
      .byte %10001000
      .byte %00000000

    ;char:i     ascii:0x69      charmap_location:0x48
      .byte %00100000
      .byte %00000000
      .byte %00100000
      .byte %01100000
      .byte %00100000
      .byte %00100000
      .byte %01110000
      .byte %00000000

    ;char:j     ascii:0x6A      charmap_location:0x50
      .byte %00010000
      .byte %00000000
      .byte %00110000
      .byte %00010000
      .byte %00010000
      .byte %10010000
      .byte %01100000
      .byte %00000000

    ;char:k     ascii:0x6B      charmap_location:0x58
       .byte %10000000
      .byte %10000000
      .byte %10010000
      .byte %10100000
      .byte %11000000
      .byte %10100000
      .byte %10010000
      .byte %00000000

    ;char:l     ascii:0x6C      charmap_location:0x60
      .byte %01100000
      .byte %00100000
      .byte %00100000
      .byte %00100000
      .byte %00100000
      .byte %00100000
      .byte %01110000
      .byte %00000000

    ;char:m     ascii:0x6D      charmap_location:0x68
      .byte %00000000
      .byte %00000000
      .byte %11010000
      .byte %10101000
      .byte %10101000
      .byte %10101000
      .byte %10101000
      .byte %00000000

    ;char:n     ascii:0x6E      charmap_location:0x70
      .byte %00000000
      .byte %00000000
      .byte %10110000
      .byte %11001000
      .byte %10001000
      .byte %10001000
      .byte %10001000
      .byte %00000000

    ;char:o     ascii:0x6F      charmap_location:0x78
      .byte %00000000
      .byte %00000000
      .byte %01110000
      .byte %10001000
      .byte %10001000
      .byte %10001000
      .byte %01110000
      .byte %00000000

    ;char:p     ascii:0x70      charmap_location:0x80
      .byte %00000000
      .byte %00000000
      .byte %11110000
      .byte %10001000
      .byte %11110000
      .byte %10000000
      .byte %10000000
      .byte %00000000

    ;char:q     ascii:0x71      charmap_location:0x88
      .byte %00000000
      .byte %00000000
      .byte %01101000
      .byte %10011000
      .byte %01111000
      .byte %00001000
      .byte %00001000
      .byte %00000000

    ;char:r     ascii:0x72      charmap_location:0x90
      .byte %00000000
      .byte %00000000
      .byte %10110000
      .byte %11001000
      .byte %10000000
      .byte %10000000
      .byte %10000000
      .byte %00000000

    ;char:s     ascii:0x73     charmap_location:0x98
      .byte %00000000
      .byte %00000000
      .byte %01110000
      .byte %10000000
      .byte %01110000
      .byte %00001000
      .byte %11110000
      .byte %00000000

    ;char:t     ascii:0x74      charmap_location:0xA0
      .byte %01000000
      .byte %01000000
      .byte %11100000
      .byte %01000000
      .byte %01000000
      .byte %01001000
      .byte %00110000
      .byte %00000000

    ;char:u     ascii:0x75      charmap_location:0xA8
      .byte %00000000
      .byte %00000000
      .byte %10001000
      .byte %10001000
      .byte %10001000
      .byte %10011000
      .byte %01101000
      .byte %00000000

    ;char:v     ascii:0x76      charmap_location:0xB0
      .byte %00000000
      .byte %00000000
      .byte %10001000
      .byte %10001000
      .byte %10001000
      .byte %01010000
      .byte %00100000
      .byte %00000000

    ;char:w     ascii:0x77      charmap_location:0xB8
      .byte %00000000
      .byte %00000000
      .byte %10001000
      .byte %10001000
      .byte %10001000
      .byte %10101000
      .byte %01010000
      .byte %00000000

    ;char:x     ascii:0x78      charmap_location:0xC0
      .byte %00000000
      .byte %00000000
      .byte %10001000
      .byte %01010000
      .byte %00100000
      .byte %01010000
      .byte %10001000
      .byte %00000000

    ;char:y     ascii:0x79      charmap_location:0xC8
      .byte %00000000
      .byte %00000000
      .byte %10001000
      .byte %10001000
      .byte %01111000
      .byte %00001000
      .byte %01110000
      .byte %00000000

    ;char:z     ascii:0x7A      charmap_location:0xD0
      .byte %00000000
      .byte %00000000
      .byte %11111000
      .byte %00010000
      .byte %00100000
      .byte %01000000
      .byte %11111000
      .byte %00000000

    ;char:{     ascii:0x7B      charmap_location:0xD8
      .byte %00100000
      .byte %01000000
      .byte %01000000
      .byte %10000000
      .byte %01000000
      .byte %01000000
      .byte %00100000
      .byte %00000000

    ;char:|     ascii:0x7C      charmap_location:0xE0
      .byte %00100000
      .byte %00100000
      .byte %00100000
      .byte %00100000
      .byte %00100000
      .byte %00100000
      .byte %00100000
      .byte %00000000

    ;char:}     ascii:0x7D      charmap_location:0xE8
      .byte %00100000
      .byte %00010000
      .byte %00010000
      .byte %00001000
      .byte %00010000
      .byte %00010000
      .byte %00100000
      .byte %00000000

    ;char:~     ascii:0x7E      charmap_location:0xF0
      .byte %00000000
      .byte %00000000
      .byte %00000000
      .byte %01101000
      .byte %10010000
      .byte %00000000
      .byte %00000000
      .byte %00000000

 .org $fd00    ; 7d00 in ROM binary file
;These keymaps convert keyscans to ASCII values
keymap:
  .byte "????????????? `?"          ; 00-0F
  .byte "?????q1???zsaw2?"          ; 10-1F
  .byte "?cxde43?? vftr5?"          ; 20-2F
  .byte "?nbhgy6???mju78?"          ; 30-3F
  .byte "?,kio09??./l;p-?"          ; 40-4F
  .byte "??'?[=????",$0a,"]?\??"    ; 50-5F
  .byte "?????????1?47???"          ; 60-6F0
  .byte "0.2568",$1b,"??+3-*9??"    ; 70-7F
  .byte "????????????????"          ; 80-8F
  .byte "????????????????"          ; 90-9F
  .byte "????????????????"          ; A0-AF
  .byte "????????????????"          ; B0-BF
  .byte "????????????????"          ; C0-CF
  .byte "????????????????"          ; D0-DF
  .byte "????????????????"          ; E0-EF
  .byte "????????????????"          ; F0-FF
keymap_shifted:
  .byte "????????????? ~?"          ; 00-0F
  .byte "?????Q!???ZSAW@?"          ; 10-1F
  .byte "?CXDE#$?? VFTR%?"          ; 20-2F
  .byte "?NBHGY^???MJU&*?"          ; 30-3F
  .byte "?<KIO)(??>?L:P_?"          ; 40-4F
  .byte '??"?{+?????}?|??'          ; 50-5F
  .byte "?????????1?47???"          ; 60-6F
  .byte "0.2568???+3-*9??"          ; 70-7F
  .byte "????????????????"          ; 80-8F
  .byte "????????????????"          ; 90-9F
  .byte "????????????????"          ; A0-AF
  .byte "????????????????"          ; B0-BF
  .byte "????????????????"          ; C0-CF
  .byte "????????????????"          ; D0-DF
  .byte "????????????????"          ; E0-EF
  .byte "????????????????"          ; F0-FF
; Reset/IRQ vectors
  .org $fffa
  .word nmi
  .word reset
  ;.word keyboard_interrupt  ;
  .word irq