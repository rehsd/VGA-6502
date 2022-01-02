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
Sound_ROW_JumpTo        = $003D     ;play from ROW starting at this line (zero-based)

PlaySong_MeasureLoop    = $AE     ;Used in PlaySong to track repeating sections for looping

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

;VIA2 PORTB - USB mouse
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

;VIA2 PORTA - SPI
SPI_SCK                = %00000001      ;Used for separate SCK on devices without OE, such as SPI 8 char 7-segment LED display with MAX7219
OEB595                 = %00000010      ;74HC595 serial to parallel shift register OE (SPI to VIA) -- used to be on 74HC138

;VIA3 PORTA & PORTB - SPI
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

;VIA4 PORTA & PORTB - Sound card (AY-3-8910)
;AY1_A9_B                = %00000001        //Used in pre-PCB version
;AY2_A9_B                = %00010000        //Used in pre-PCB version
AY1_BC1                 = %00000001         //U38, Left1 - U37 ROM access
AY1_BDIR                = %00000010 
AY2_BC1                 = %00000100         //U36, Right1 - U37 ROM access
AY2_BDIR                = %00001000
AY3_BC1                 = %00010000         //U1, Left2 - U3 ROM access
AY3_BDIR                = %00100000
AY4_BC1                 = %01000000         //U2, Right2 - U3 ROM access
AY4_BDIR                = %10000000

;Arduino SPI Communication
SPI_ARD_CMD_RESET           = 00        
SPI_ARD_CMD_GETSTATUS       = 01        
SPI_ARD_CMD_GETTWOBYTES     = 02
SPI_ARD_CMD_PRINTSCREEN     = 03
SPI_ARD_CMD_GETSOUNDINFO    = 04

SOUND_LEVEL_DEFAULT         = 15        ;01 (min) to 15 (max)