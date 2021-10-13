;General Information
    ; Project for 6502+LCD+PS2+VGA for Ben Eater circuit design
    ; This assembly code developed by rehsd with foundational elements from Ben Eater (others if noted in code)
    ; Last updated September 2021
    ; Assembly code compiled with vasm and uploaded to ROM on 6502 build
    ; Example build command line:
    ;	vasm6502_oldstyle.exe -Fbin -dotdir -wdc02 PCB_ROM.s -o pcb_rom.bin

    ; *** Hardware config ***
    ; W65C02 (Ben),  5.0 MHz
    ; VGA circuit (Ben), 10.0 MHz
    ; PS2 keyboard circuit (Ben)
    ; Joystick circuit (not on PCB)
    ; VIA1 PortA - PS2 keyboard input
    ; VIA1 PortB - 16x02 LCD in 4-bit (nibble) mode
    ; VIA2 PortA - 
    ; VIA2 PortB - Joystick input
    ; VIA3 PortA - 
    ; VIA3 PortB - 
    ; VIA4 PortA - 
    ; VIA4 PortB - 
    ; VIA5 PortA - 
    ; VIA5 PortB - 
    ; W65C51N ACIA at $4100

    ; VGA info
    ; Use X to track the video page
    ; Use Y to track the column in the page
    ; Use A to track pixel color
    ; 'VGA' Resolution: 100 columns x 64 rows (was 75 rows with just VGA circuit, with no 6502 integration)

    ; All calls to the Delay routine are tested with a 6502 clock of 4.9152MHz. Other clock speeds may require adjusting the duration of the delays.

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
    ; -safety code in case text/cursor/drawing is taken outside of screen (video address range)

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
message_to_process      = $0020
delayDurationHighByte   = $0030     ;Count from this number (high byte) to FF - higher number results in shorter delay


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
;                         $69       temp storage in joystick interrupt handlers


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

kb_buffer               = $0200  ; 256-byte kb buffer 0200-02ff

;VIAs
;Address Line A13		    110000000000000
PORT1B = $6000
PORT1A = $6001
DDR1B  = $6002
DDR1A  = $6003
PCR1   = $600C
IFR1   = $600D
IER1   = $600E

;Address Line A12		    101000000000000
PORT2B = $5000
PORT2A = $5001
DDR2B  = $5002
DDR2A  = $5003
PCR2   = $500C
IFR2   = $500D
IER2   = $500E

;Address Line A11		    100100000000000
PORT3B = $4800
PORT3A = $4801
DDR3B  = $4802
DDR3A  = $4803
PCR3   = $480C
IFR3   = $480D
IER3   = $480E

;Address Line A10			100010000000000
PORT4B = $4400
PORT4A = $4401
DDR4B  = $4402
DDR4A  = $4403
PCR4   = $440C
IFR4   = $440D
IER4   = $440E
	
;Address Line A09		    100001000000000
PORT5B = $4200
PORT5A = $4201
DDR5B  = $4202
DDR5A  = $4203
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

JOYSTICK_DOWN           = %00000001
JOYSTICK_UP             = %00000010
JOYSTICK_PRESS          = %00000100
JOYSTICK_RIGHT          = %00001000
JOYSTICK_LEFT           = %00010000

;.org $8000         ;comment here for outlining in Visual Studio editor
  .org $8000
reset:
  ;*** ps2lcd ***
  ldx #$ff          ;init stack
  txs

  ;see page 42 of https://eater.net/datasheets/HD44780.pdf
  ;when running 6502 at 4.9 MHz (versus 1 MHz), sometimes init needs additional call or delay
  
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


  ;setup interrupts
  lda #$01	    ;positive edge (in code from Ben)
  sta PCR1		;Set CA1 to positive edge
  
  lda #$00     ;edge negative
  sta PCR2
  sta PCR3

  lda #%10000010	;Enables interrupt CA1, disables everything else. Set/Clear Timer1 Timer2 CB1 CB2 ShiftRegister CA1 CA2 
  sta IER1

  lda #%01111111    ;Disable all interrupt for the VIA
  sta IER2
  sta IER3
  sta IER4
  sta IER5

  ;lda #%10010000    ;Enable CB1, disable others. Set/Clear Timer1 Timer2 CB1 CB2 ShiftRegister CA1 CA2 
  ;sta IER2
  
  ;lda #%10000010	;Enables xxx, disables everything else. Set/Clear Timer1 Timer2 CB1 CB2 ShiftRegister CA1 CA2 
  ;sta IER3

  cli           ;enable interrupts

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
  sta DDR5B
  sta DDR5A

  ;init keyboard handling memory
  lda #$00
  sta kb_flags
  sta kb_flags2
  sta kb_wptr
  sta kb_rptr

  ;*** vga ***
  jsr InitVideoMemory
  jsr FillBlack

    ;*** vga ***
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
  
  ;Set to 0 when transitioning to dynamic strings/chars (vs. pre-defined, stored messages)
  lda #$00  ;done processing pre-defined strings
  sta message_to_process

  jsr StartScreen

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

  ;jsr StartSerial
  jmp loop
StartSerial:
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
    lda #%00011110				;1 stop bit, 8 data bits, 5208 baud (1Mhz external oscillator, F/192 = 5208)
    sta ACIA_CONTROL


    write:
        ldx #0
    next_char:
    wait_txd_empty:  
        lda ACIA_STATUS
        and #$10
        beq wait_txd_empty
        lda serialText,x
        beq serialOut
        sta ACIA_DATA
        jsr print_char_lcd
        jsr Delay
        inx
        jmp next_char
   serialOut:
        rts

serialText db "serial init... ", 0

StartScreen:
  ;fill region test 1 - top left bar
  lda #01
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
  lda #99
  sta fill_region_end_x
  lda #00
  sta fill_region_end_y
  lda #$0c  ;bright green
  sta fill_region_color
  jsr FillRegion

  ;fill region test 3 - bottom left bar
  lda #01   
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
  lda #99
  sta fill_region_end_x
  lda #63
  sta fill_region_end_y
  lda #$3f  ;white
  sta fill_region_color
  jsr FillRegion

  ;fill region test 5  ;left border
  lda #01   ;noise on first column, so starting at second column (1)
  sta fill_region_start_x
  lda #01
  sta fill_region_start_y
  lda #01
  sta fill_region_end_x
  lda #62
  sta fill_region_end_y
  lda #%00111100
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
  lda #%00001111
  sta fill_region_color
  jsr FillRegion

  rts
Handle_Arrow_Up:
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
  jmp loop
Handle_Arrow_Left:
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
  jmp loop
Handle_Arrow_Right:
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
  jmp loop
Handle_Arrow_Down:
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
  jmp loop
Handle_KB_flags:
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

  lda kb_flags2
  bit #NKP_INSERT
  bne Handle_NKP_Insert

  bit #NKP_DELETE
  bne Handle_NKP_Delete

  bit #NKP_MINUS
  bne Handle_NKP_Minus

  bit #NKP_ASTERISK
  bne Handle_NKP_Asterisk
  
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
key_pressed:
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
  bra loop
Finished:
  jmp Finished  ;end of the program if sent to this subroutine... sit and spin
loop:
  ;sit here and loop, process key presses via interrupts as they come in
  sei                   ;Set the interrupt disable flag to one.
  lda kb_rptr
  cmp kb_wptr
  cli                   ;Clear Interrupt Disable
  bne key_pressed

  ;Handle KB flags
  jmp Handle_KB_flags
  ;bra loop
esc_pressed:
  ;*** vga ***
  jsr InitVideoMemory
  jsr FillBlack

  ;*** lcd ***
  lda #%00000001 ; Clear display
  jsr lcd_instruction
  
  inc kb_rptr
  jmp loop
enter_pressed:
  ;*** vga ***
  lda vidpage
  sta char_vp
  lda vidpage + 1
  sta char_vp_p1
  lda #$3
  sta char_y_offset

  ;*** lcd ***
  lda #%10101000 ; put cursor at position 40
  jsr lcd_instruction
  inc kb_rptr
  jmp loop
StorePrevPixelInfo:
    lda fill_region_start_x
    sta pixel_prev_x
    lda fill_region_start_y
    sta pixel_prev_y
    ldy pixel_prev_x
    ;need the color of the pixel at the location - convert x,y position to memory location 
    lda (vidpage), y        ;issue line
    sta pixel_prev_color
    rts
RestoreCurrentPixelInfo:
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
    lda #$30    ;'0'
    jsr print_char_lcd
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
irq:
  ;put items on stack, so we can return them
  pha ;a to stack
  phx ;x to stack
  phy ;y to stack

  ;check interrupts in order of priority
  BIT  IFR1				; Check status register for VIA1        ; PS2 keyboard
  BMI  VIA1_IRQ			; Branch if VIA1 is interrupt source

  BIT  IFR2				; Check status register for VIA2        ; joystick
  BMI  VIA2_IRQ			; Branch if VIA2 is interrupt source
  
  BIT  IFR3				; Check status register for VIA3        ; ACIA serial
  BMI  VIA3_IRQ			; Branch if VIA3 is interrupt source

  ;Should never get here unless missing a BIT/BMI for the interrupt source
irq_done:
  ;return items from stack
  ply ;stack to y
  plx ;stack to x
  pla ;stack to a
  rti
VIA1_IRQ:
  ;to do -- check interrupt source on VIA IER (CB1, CB2, CA1, CA2)
  jmp keyboard_interrupt
Handle_Joystick_Down:
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

  jmp VIA2_IRQ_OUT
Handle_Joystick_Press:
    ;jsr print_dec_lcd
    lda #$00  ;start counting up at this value; higher # = shorter delay
    sta delayDurationHighByte
    jsr Delay
    lda currently_drawing
    cmp #$01
    beq JS_turnDrawingOff
    lda #$01   ;otherwise, turn it on
    jmp handleJSpress_out
    JS_turnDrawingOff:
    lda #$00
    handleJSpress_out:
    sta currently_drawing

    bit PORT2B      ;reset interrupt
    jmp irq_done
VIA2_IRQ:
  ;to do -- check interrupt source on VIA IER (CB1, CB2, CA1, CA2)
  lda PORT2B
  sta $69
  AND #JOYSTICK_DOWN
  bne Handle_Joystick_Down
  lda $69
  AND #JOYSTICK_PRESS
  bne Handle_Joystick_Press
  lda $69
  AND #JOYSTICK_LEFT
  bne Handle_Joystick_Left
  lda $69
  AND #JOYSTICK_RIGHT
  bne Handle_Joystick_Right
  lda $69
  AND #JOYSTICK_UP
  bne Handle_Joystick_Up
  ;drops into VIA2_IRQ_OUT
VIA2_IRQ_OUT:
  lda #$D0  ;start counting up at this value; higher # = shorter delay; adjust based on preference for movement speed (and on clock speed)
  sta delayDurationHighByte
  jsr Delay

  ;read the port. if still bits there, repeat the interrupt handler - allows holding the joystick to keep cursor moving
  lda PORT2B
  cmp #$00
  bne VIA2_IRQ
  
  jmp irq_done
VIA3_IRQ:
  ;to do -- check interrupt source on VIA IER (CB1, CB2, CA1, CA2)
  ;for now, assuming VIA3 CA1 as the source (W65C51 ACIA using this pin)
  lda ACIA_DATA     
  ;jsr print_char_lcd       ;can output to lcd or vga. if both, it fails -- possibly taking too long, or a register issue?
  jsr print_char_vga
  bit ACIA_STATUS   ;reset interrupt of ACIA
  bit PORT3A        ;reset VIA interrupt    ;if running ACIA interrupt direct to 6502 (i.e., no VIA), this step is not necessary
  jmp irq_done
Handle_Joystick_Left:
    ;jsr print_dec_lcd
    jsr RestoreCurrentPixelInfo
    ldx fill_region_start_x
    dex
    stx fill_region_start_x
    jsr StorePrevPixelInfo
    jsr DrawPixel
    jmp VIA2_IRQ_OUT
Handle_Joystick_Right:
    ;jsr print_dec_lcd

    ;put old pixel data in current pixel, since the pointer is moving out
    jsr RestoreCurrentPixelInfo
    ;add to fill_region_start_x to move the pixel right
    ldx fill_region_start_x
    inx
    stx fill_region_start_x
    jsr StorePrevPixelInfo
    jsr DrawPixel

    jmp VIA2_IRQ_OUT
Handle_Joystick_Up:
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

  jmp VIA2_IRQ_OUT
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
read_key:
  lda PORT1A

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

  tax
  lda kb_flags
  and #SHIFT
  bne shifted_key

  lda keymap, x   ; map to character code
  bra push_key
shifted_key:
  lda keymap_shifted, x   ; map to character code
push_key:
  ldx kb_wptr
  sta kb_buffer, x
  inc kb_wptr
  jmp irq_done
shift_down:
  lda kb_flags
  ora #SHIFT
  sta kb_flags
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
PrintString:
  stx $40   ;store x
  ldx #$00
  stx $54   ;printstring current char tracking
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
    rts
FillRegion:
    ;push registers to stack?
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
        rts
        ;pull registers from stack?
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
  lda #$00
  sta char_vp
  sta vidpage
  lda #$3F
  sta char_color
  lda #$3
  sta char_y_offset

  ldx #$20 ; X will count down how many pages of video RAM to go
  ldy #$0 ; populate a page starting at 0
  rts
nmi:
  rti


;Predefined messages
message1 db "abcdef", 0
message2 db "ABCDEFGHIJKLM", 0
message3 db "NOPQRSTUVWXYZ", 0
message4 db "00.0F!FF?10", 0
message5 db "SET POSITION", 0
message6 db "  AND COLOR", 0
message7 db "6502 PLUS", 0
message8 db "    V-G-A", 0
hexOutLookup db "0123456789ABCDEF", 0

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
