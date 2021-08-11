; Project for 6502+VGA from Ben Eater
; Assembly code to be compiled with vasm - to create bin file for EEPROM programmer
; Example command line to run:
;	vasm6502_oldstyle.exe -Fbin -dotdir vga_ps2kbdLCD.s -o vga_ps2kbdLCD.bin

; Use X to track the video page
; Use Y to track the column in the page
; Use A to track pixel color
; Resolution: 100 columns x 60 rows (was 75 rows with just VGA circuit, with no 6502 integration)

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

; Font: 5x7 fixed   https://thumb7.shutterstock.com/display_pic_with_logo/1811018/359671199/stock-vector-blue-led-letters-and-numbers-electronic-scoreboard-vector-alphabet-359671199.jpg


; TO DO
; -Improve code commenting :)
; -ClearChar subroutine
; -FillRegion type of subroutine to draw rectanglular shapes
; -General code optimization - removal of unecessary calls

kb_wptr                 = $0005
kb_rptr                 = $0006
kb_flags                = $0007

vidpage                 = $0000 ; 2 bytes
char_vp                 = $0010
char_vp_p1              = $0012
char_color              = $0014
char_y_offset           = $0016
char_current_val        = $0018
message_to_process      = $0020
delayDurationHighByte   = $0030     ;Count from this number (high byte) to FF - higher number results in shorter delay

kb_buffer               = $0200  ; 256-byte kb buffer 0200-02ff

PORTB                   = $6000
PORTA                   = $6001
DDRB                    = $6002
DDRA                    = $6003
PCR                     = $600c
IFR                     = $600d
IER                     = $600e

RELEASE                 = %00000001
SHIFT                   = %00000010
E                       = %01000000
RW                      = %00100000
RS                      = %00010000

  .org $8000

reset:
  ;*** vga ***
  lda #$00
  sta delayDurationHighByte

  ;*** ps2lcd ***
  ldx #$ff
  txs

  lda #$01	;positive edge (in code from Ben)
  ;lda #$00		;negative edge (testing)
  sta PCR		;Set CA1 to positive edge

  lda #$82		;1000 0010	Enables interrupt CA1, disables everything else: Set/Clear Timer1 Timer2 CB1 CB2 Shift Register CA2 
  sta IER
  cli

  lda #%11111111 ; Set all pins on port B to output
  sta DDRB
  lda #%00000000 ; Set all pins on port A to input
  sta DDRA

  jsr lcd_init
  lda #%00101000 ; Set 4-bit mode; 2-line display; 5x8 font
  jsr lcd_instruction
  lda #%00001110 ; Display on; cursor on; blink off
  jsr lcd_instruction
  lda #%00000110 ; Increment and shift cursor; don't shift display
  jsr lcd_instruction
  lda #%00000001 ; Clear display
  jsr lcd_instruction

  lda #$00
  sta kb_flags
  sta kb_wptr
  sta kb_rptr

  ;*** vga ***
  jsr InitVideoMemory
  jsr FillBlack

    ;*** vga ***
  ;where to place chars and char color - change these locations before calling PrintChar
  lda #$29
  sta char_vp_p1
  lda #$80
  sta char_vp
  lda #$3F      ;white
  sta char_color
  lda #$7
  sta char_y_offset

  lda #$01
  sta message_to_process
  jsr PrintString
  lda #$00  ;done processing pre-defined strings
  sta message_to_process

  lda #$30
  sta char_vp_p1
  lda #$80
  sta char_vp
  lda #$30
  sta char_color
  lda #$8
  sta char_y_offset


loop:

  ;*** ps2lcd ***
  sei
  lda kb_rptr
  cmp kb_wptr
  cli
  bne key_pressed
  jmp loop

Finished:
  jmp Finished  ;end of the program... sit and spin

key_pressed:
  ldx kb_rptr
  lda kb_buffer, x
  cmp #$0a           ; enter - go to second line
  beq enter_pressed
  cmp #$1b           ; escape - clear display
  beq esc_pressed

  jsr print_char_lcd
  
  ;*** vga ***

  ;where to place chars and char color - change these locations before calling PrintChar
  ;lda #$30
  ;sta char_vp_p1
  ;lda #$80
  ;sta char_vp
  ;lda #$33
  ;sta char_color
  
  lda kb_buffer, x  ;#$32  ; kb_buffer, x  ; char_current_val  ;the char to be displayed
  jsr print_char_vga
  ;inc char_y_offset
  ;inc char_y_offset
  ;***********

  inc kb_rptr

  jmp loop

enter_pressed:
  
;*** vga ***
;crlf
  lda #$36
  sta char_vp_p1
  lda #$80
  sta char_vp
  lda #$30      ;bright blue
  sta char_color
  lda #$8
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
  ;where to place chars and char color - change these locations before calling PrintChar
  lda #$30
  sta char_vp_p1
  lda #$80
  sta char_vp
  lda #$3F
  sta char_color
  lda #$8
  sta char_y_offset

  ;*** lcd ***
  lda #%00000001 ; Clear display
  jsr lcd_instruction
  inc kb_rptr
  jmp loop

lcd_wait:
  pha
  lda #%11110000  ; LCD data is input
  sta DDRB
lcdbusy:
  lda #RW
  sta PORTB
  lda #(RW | E)
  sta PORTB
  lda PORTB       ; Read high nibble
  pha             ; and put on stack since it has the busy flag
  lda #RW
  sta PORTB
  lda #(RW | E)
  sta PORTB
  lda PORTB       ; Read low nibble
  pla             ; Get high nibble off stack
  and #%00001000
  bne lcdbusy

  lda #RW
  sta PORTB
  lda #%11111111  ; LCD data is output
  sta DDRB
  pla
  rts

lcd_init:
  lda #%00000010 ; Set 4-bit mode
  sta PORTB
  ora #E
  sta PORTB
  and #%00001111
  sta PORTB
  rts

lcd_instruction:
  jsr lcd_wait
  pha
  lsr
  lsr
  lsr
  lsr            ; Send high 4 bits
  sta PORTB
  ora #E         ; Set E bit to send instruction
  sta PORTB
  eor #E         ; Clear E bit
  sta PORTB
  pla
  and #%00001111 ; Send low 4 bits
  sta PORTB
  ora #E         ; Set E bit to send instruction
  sta PORTB
  eor #E         ; Clear E bit
  sta PORTB
  rts

print_char_lcd:
  jsr lcd_wait
  pha
  lsr
  lsr
  lsr
  lsr             ; Send high 4 bits
  ora #RS         ; Set RS
  sta PORTB
  ora #E          ; Set E bit to send instruction
  sta PORTB
  eor #E          ; Clear E bit
  sta PORTB
  pla
  and #%00001111  ; Send low 4 bits
  ora #RS         ; Set RS
  sta PORTB
  ora #E          ; Set E bit to send instruction
  sta PORTB
  eor #E          ; Clear E bit
  sta PORTB
  rts


; IRQ vector points here
keyboard_interrupt:
  pha
  txa
  pha
  lda kb_flags
  and #RELEASE   ; check if we're releasing a key
  beq read_key   ; otherwise, read the key

  lda kb_flags
  eor #RELEASE   ; flip the releasing bit
  sta kb_flags
  lda PORTA      ; read key value that is being released
  cmp #$12       ; left shift
  beq shift_up
  cmp #$59       ; right shift
  beq shift_up
  jmp exit

shift_up:
  lda kb_flags
  eor #SHIFT  ; flip the shift bit
  sta kb_flags
  jmp exit

read_key:
  lda PORTA
  cmp #$f0        ; if releasing a key
  beq key_release ; set the releasing bit
  cmp #$12        ; left shift
  beq shift_down
  cmp #$59        ; right shift
  beq shift_down

  tax
  lda kb_flags
  and #SHIFT
  bne shifted_key

  lda keymap, x   ; map to character code
  jmp push_key

shifted_key:
  lda keymap_shifted, x   ; map to character code

push_key:
  ldx kb_wptr
  sta kb_buffer, x
  inc kb_wptr
  jmp exit

shift_down:
  lda kb_flags
  ora #SHIFT
  sta kb_flags
  jmp exit

key_release:
  lda kb_flags
  ora #RELEASE
  sta kb_flags

exit:
  pla
  tax
  pla
  rti




ClearChar:
  ;TO DO - Clear a single character
  rts

message1 db "VGA", 0
message2 db "ABCDEFGHIJKLM", 0
message3 db "NOPQRSTUVWXYZ", 0
message4 db "00.0F!FF?10", 0
message5 db "SET POSITION", 0
message6 db "  AND COLOR", 0
message7 db "6502 PLUS", 0
message8 db "    V-G-A", 0

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
  ldx #0
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

jump_to_PrintChar0:
  jmp PrintChar0
jump_to_PrintChar1:
  jmp PrintChar1
jump_to_PrintChar2:
  jmp PrintChar2
jump_to_PrintChar3:
  jmp PrintChar3
jump_to_PrintChar4:
  jmp PrintChar4
jump_to_PrintChar5:
  jmp PrintChar5
jump_to_PrintChar6:
  jmp PrintChar6
jump_to_PrintChar7:
  jmp PrintChar7
jump_to_PrintChar8:
  jmp PrintChar8
jump_to_PrintChar9:
  jmp PrintChar9
jump_to_PrintCharA:
  jmp PrintCharA
jump_to_PrintCharB:
  jmp PrintCharB
jump_to_PrintCharC:
  jmp PrintCharC
jump_to_PrintCharD:
  jmp PrintCharD
jump_to_PrintCharE:
  jmp PrintCharE
jump_to_PrintCharF:
  jmp PrintCharF

print_char_vga:
  sta char_current_val

  ;determine which char and call appropriate Subroutines
  cmp #$30  ;0
  beq jump_to_PrintChar0
  cmp #$31  ;1
  beq jump_to_PrintChar1
  cmp #$32  ;2
  beq jump_to_PrintChar2
  cmp #$33  ;3
  beq jump_to_PrintChar3
  cmp #$34  ;4
  beq jump_to_PrintChar4
  cmp #$35  ;5
  beq jump_to_PrintChar5
  cmp #$36  ;6
  beq jump_to_PrintChar6
  cmp #$37  ;7
  beq jump_to_PrintChar7
  cmp #$38  ;8
  beq jump_to_PrintChar8
  cmp #$39  ;9
  beq jump_to_PrintChar9
  cmp #$41  ;A
  beq jump_to_PrintCharA
  cmp #$42  ;B
  beq jump_to_PrintCharB
  cmp #$43  ;C
  beq jump_to_PrintCharC
  cmp #$44  ;D
  beq jump_to_PrintCharD
  cmp #$45  ;E
  beq jump_to_PrintCharE
  cmp #$46  ;F
  beq jump_to_PrintCharF
  cmp #$47  ;G
  beq jump_to_PrintCharG
  cmp #$48  ;H
  beq jump_to_PrintCharH
  cmp #$49  ;I
  beq jump_to_PrintCharI
  cmp #$4A  ;J
  beq jump_to_PrintCharJ
  cmp #$4B  ;K
  beq jump_to_PrintCharK
  cmp #$4C  ;L
  beq jump_to_PrintCharL
  cmp #$4D  ;M
  beq jump_to_PrintCharM
  cmp #$4E  ;N
  beq jump_to_PrintCharN
  cmp #$4F  ;O
  beq jump_to_PrintCharO
  cmp #$50  ;P
  beq jump_to_PrintCharP
  cmp #$51  ;Q
  beq jump_to_PrintCharQ
  cmp #$52  ;R
  beq jump_to_PrintCharR
  cmp #$53  ;S
  beq jump_to_PrintCharS
  cmp #$54  ;T
  beq jump_to_PrintCharT
  cmp #$55  ;U
  beq jump_to_PrintCharU
  cmp #$56  ;V
  beq jump_to_PrintCharV
  cmp #$57  ;W
  beq jump_to_PrintCharW
  cmp #$58  ;X
  beq jump_to_PrintCharX
  cmp #$59  ;Y
  beq jump_to_PrintCharY
  cmp #$5A  ;Z
  beq jump_to_PrintCharZ
  cmp #$20  ;SPACE
  beq jump_to_PrintCharSpace
  cmp #$2E  ;PERIOD
  beq jump_to_PrintCharPeriod
  cmp #$21  ;EXCLAMATION
  beq jump_to_PrintCharExclamation
  cmp #$3F  ;QUESTION
  beq jump_to_PrintCharQuestion
  cmp #$2D  ;DASH
  beq jump_to_PrintCharDash
Next:
  ;move the 'cursor' to the right by 7 pixels
  inc char_y_offset
  inc char_y_offset
  inc char_y_offset
  inc char_y_offset
  inc char_y_offset
  inc char_y_offset
  ;inc char_y_offset
  inx
  jmp PrintStringLoop

jump_to_PrintCharG:
  jmp PrintCharG
jump_to_PrintCharH:
  jmp PrintCharH
jump_to_PrintCharI:
  jmp PrintCharI
jump_to_PrintCharJ:
  jmp PrintCharJ
jump_to_PrintCharK:
  jmp PrintCharK
jump_to_PrintCharL:
  jmp PrintCharL
jump_to_PrintCharM:
  jmp PrintCharM
jump_to_PrintCharN:
  jmp PrintCharN
jump_to_PrintCharO:
  jmp PrintCharO
jump_to_PrintCharP:
  jmp PrintCharP
jump_to_PrintCharQ:
  jmp PrintCharQ
jump_to_PrintCharR:
  jmp PrintCharR
jump_to_PrintCharS:
  jmp PrintCharS
jump_to_PrintCharT:
  jmp PrintCharT
jump_to_PrintCharU:
  jmp PrintCharU
jump_to_PrintCharV:
  jmp PrintCharV
jump_to_PrintCharW:
  jmp PrintCharW
jump_to_PrintCharX:
  jmp PrintCharX
jump_to_PrintCharY:
  jmp PrintCharY
jump_to_PrintCharZ:
  jmp PrintCharZ
jump_to_PrintCharSpace:
  jmp PrintCharSpace
jump_to_PrintCharPeriod:
  jmp PrintCharPeriod
jump_to_PrintCharExclamation:
  jmp PrintCharExclamation
jump_to_PrintCharQuestion:
  jmp PrintCharQuestion
jump_to_PrintCharDash:
  jmp PrintCharDash


;Subroutines for manually (painfully) creating each character
;Lots of room for improvement here. Please send me tips and tricks. :)
;Will likely setup variables to store a 5-byte representation of each character (A-Z, 0-9, etc.), and make a more general routine to read those representations to generate the output - similar to Ben's approach for the LED segment display on the 8-bit computer'
;Maybe something, in concept, similar to http://gammon.com.au/forum/?id=10940

PrintChar0:
 
  lda char_vp_p1
  sta vidpage + 1
  lda char_vp
  sta vidpage
      
  ldy char_y_offset  ;column start
  sty $44


  lda char_color	;load color stored above
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  
  lda vidpage + 1
  clc
  adc #01
  sta vidpage + 1
  lda #$00 
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  iny
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  
  lda #$80  
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  lda vidpage + 1
  clc
  adc #01
  sta vidpage + 1
  lda #$00   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  lda #$80   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  
  lda vidpage + 1
  clc
  adc #01
  sta vidpage + 1
  lda #$00   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  iny
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  lda #$80   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  jmp Next
PrintChar1:
 
  lda char_vp_p1
  sta vidpage + 1
  lda char_vp
  sta vidpage
      
  ldy char_y_offset  ;column start
  sty $44


  lda char_color	;load color stored above
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  
  lda vidpage + 1
  clc
  adc #01
  sta vidpage + 1
  lda #$00 
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  
  lda #$80  
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  lda vidpage + 1
  clc
  adc #01
  sta vidpage + 1
  lda #$00   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  lda #$80   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  
  lda vidpage + 1
  clc
  adc #01
  sta vidpage + 1
  lda #$00   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  lda #$80   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  jmp Next
PrintChar2:
 
  lda char_vp_p1
  sta vidpage + 1
  lda char_vp
  sta vidpage
      
  ldy char_y_offset  ;column start
  sty $44


  lda char_color	;load color stored above
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  
  lda vidpage + 1
  clc
  adc #01
  sta vidpage + 1
  lda #$00 
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  iny
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  
  lda #$80  
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  iny
  iny
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  lda vidpage + 1
  clc
  adc #01
  sta vidpage + 1
  lda #$00   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  iny
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  lda #$80   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  
  lda vidpage + 1
  clc
  adc #01
  sta vidpage + 1
  lda #$00   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  lda #$80   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y

    jmp Next
PrintChar3:
 
  lda char_vp_p1
  sta vidpage + 1
  lda char_vp
  sta vidpage
      
  ldy char_y_offset  ;column start
  sty $44


  lda char_color	;load color stored above
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  
  lda vidpage + 1
  clc
  adc #01
  sta vidpage + 1
  lda #$00 
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  iny
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  
  lda #$80  
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  iny
  iny
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  lda vidpage + 1
  clc
  adc #01
  sta vidpage + 1
  lda #$00   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  lda #$80   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  iny
  iny
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  
  lda vidpage + 1
  clc
  adc #01
  sta vidpage + 1
  lda #$00   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  iny
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  lda #$80   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y

    jmp Next
PrintChar4:
 
  lda char_vp_p1
  sta vidpage + 1
  lda char_vp
  sta vidpage
      
  ldy char_y_offset  ;column start
  sty $44


  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  iny
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  
  lda vidpage + 1
  clc
  adc #01
  sta vidpage + 1
  lda #$00 
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  iny
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  
  lda #$80  
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  iny
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  lda vidpage + 1
  clc
  adc #01
  sta vidpage + 1
  lda #$00   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  lda #$80   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  iny
  iny
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  
  lda vidpage + 1
  clc
  adc #01
  sta vidpage + 1
  lda #$00   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  iny
  iny
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  lda #$80   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  iny
  iny
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y

    jmp Next
PrintChar5:
 
  lda char_vp_p1
  sta vidpage + 1
  lda char_vp
  sta vidpage
      
  ldy char_y_offset  ;column start
  sty $44


  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  
  lda vidpage + 1
  clc
  adc #01
  sta vidpage + 1
  lda #$00 
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  
  lda #$80  
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  lda vidpage + 1
  clc
  adc #01
  sta vidpage + 1
  lda #$00   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  iny
  iny
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  lda #$80   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  iny
  iny
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  
  lda vidpage + 1
  clc
  adc #01
  sta vidpage + 1
  lda #$00   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  iny
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  lda #$80   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y

    jmp Next
PrintChar6:
 
  lda char_vp_p1
  sta vidpage + 1
  lda char_vp
  sta vidpage
      
  ldy char_y_offset  ;column start
  sty $44


  lda char_color	;load color stored above
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  
  lda vidpage + 1
  clc
  adc #01
  sta vidpage + 1
  lda #$00 
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  iny
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  
  lda #$80  
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y

  lda vidpage + 1
  clc
  adc #01
  sta vidpage + 1
  lda #$00   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  lda #$80   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  iny
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  
  lda vidpage + 1
  clc
  adc #01
  sta vidpage + 1
  lda #$00   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  iny
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  lda #$80   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y

    jmp Next
PrintChar7:
 
  lda char_vp_p1
  sta vidpage + 1
  lda char_vp
  sta vidpage
      
  ldy char_y_offset  ;column start
  sty $44


  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  lda vidpage + 1
  clc
  adc #01
  sta vidpage + 1
  lda #$00 
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  iny
  iny
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  
  lda #$80  
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  iny
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  lda vidpage + 1
  clc
  adc #01
  sta vidpage + 1
  lda #$00   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  lda #$80   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  
  lda vidpage + 1
  clc
  adc #01
  sta vidpage + 1
  lda #$00   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  lda #$80   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y

    jmp Next
PrintChar8:
 
  lda char_vp_p1
  sta vidpage + 1
  lda char_vp
  sta vidpage
      
  ldy char_y_offset  ;column start
  sty $44


  lda char_color	;load color stored above
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  
  lda vidpage + 1
  clc
  adc #01
  sta vidpage + 1
  lda #$00 
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  iny
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  
  lda #$80  
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  iny
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  lda vidpage + 1
  clc
  adc #01
  sta vidpage + 1
  lda #$00   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  lda #$80   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  iny
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  
  lda vidpage + 1
  clc
  adc #01
  sta vidpage + 1
  lda #$00   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  iny
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  lda #$80   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y

    jmp Next
PrintChar9:
  lda char_vp_p1
  sta vidpage + 1
  lda char_vp
  sta vidpage
  
  ;lda #$30
  ;sta vidpage + 1
  ;lda #$80   
  ;sta vidpage
 
  
  ldy char_y_offset  ;column start
  sty $44


  lda char_color	;load color stored above
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  
  lda vidpage + 1
  clc
  adc #01
  sta vidpage + 1
  lda #$00 
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  iny
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  
  lda #$80  
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  iny
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  lda vidpage + 1
  clc
  adc #01
  sta vidpage + 1
  lda #$00   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  lda #$80   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  iny
  iny
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  
  lda vidpage + 1
  clc
  adc #01
  sta vidpage + 1
  lda #$00   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  iny
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  lda #$80   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y


    jmp Next
PrintCharA:
  lda char_vp_p1
  sta vidpage + 1
  lda char_vp
  sta vidpage
  
  ;lda #$30
  ;sta vidpage + 1
  ;lda #$80   
  ;sta vidpage
 
  
  ldy char_y_offset  ;column start
  sty $44


  lda char_color	;load color stored above
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  
  lda vidpage + 1
  clc
  adc #01
  sta vidpage + 1
  lda #$00 
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  iny
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  
  lda #$80  
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  iny
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  lda vidpage + 1
  clc
  adc #01
  sta vidpage + 1
  lda #$00   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  lda #$80   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  iny
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  
  lda vidpage + 1
  clc
  adc #01
  sta vidpage + 1
  lda #$00   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  iny
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  lda #$80   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  iny
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  jmp Next
PrintCharB:
  lda char_vp_p1
  sta vidpage + 1
  lda char_vp
  sta vidpage
  
  ;lda #$30
  ;sta vidpage + 1
  ;lda #$80   
  ;sta vidpage
 
  
  ldy char_y_offset  ;column start
  sty $44


  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  
  lda vidpage + 1
  clc
  adc #01
  sta vidpage + 1
  lda #$00 
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  iny
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  
  lda #$80  
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  iny
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  lda vidpage + 1
  clc
  adc #01
  sta vidpage + 1
  lda #$00   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  lda #$80   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  iny
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  
  lda vidpage + 1
  clc
  adc #01
  sta vidpage + 1
  lda #$00   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  iny
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  lda #$80   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  jmp Next
PrintCharC:
  lda char_vp_p1
  sta vidpage + 1
  lda char_vp
  sta vidpage
  
  ;lda #$30
  ;sta vidpage + 1
  ;lda #$80   
  ;sta vidpage
 
  
  ldy char_y_offset  ;column start
  sty $44


  lda char_color	;load color stored above
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  
  lda vidpage + 1
  clc
  adc #01
  sta vidpage + 1
  lda #$00 
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  iny
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  
  lda #$80  
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y

  lda vidpage + 1
  clc
  adc #01
  sta vidpage + 1
  lda #$00   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y

  lda #$80   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  
  lda vidpage + 1
  clc
  adc #01
  sta vidpage + 1
  lda #$00   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  iny
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  lda #$80   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  jmp Next
PrintCharD:
  lda char_vp_p1
  sta vidpage + 1
  lda char_vp
  sta vidpage
  
  ;lda #$30
  ;sta vidpage + 1
  ;lda #$80   
  ;sta vidpage
 
  
  ldy char_y_offset  ;column start
  sty $44


  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  
  lda vidpage + 1
  clc
  adc #01
  sta vidpage + 1
  lda #$00 
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  iny
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  
  lda #$80  
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  iny
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  lda vidpage + 1
  clc
  adc #01
  sta vidpage + 1
  lda #$00   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  iny
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  lda #$80   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  iny
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  
  lda vidpage + 1
  clc
  adc #01
  sta vidpage + 1
  lda #$00   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  iny
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  lda #$80   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  jmp Next
PrintCharE:
  lda char_vp_p1
  sta vidpage + 1
  lda char_vp
  sta vidpage
  
  ;lda #$30
  ;sta vidpage + 1
  ;lda #$80   
  ;sta vidpage
 
  
  ldy char_y_offset  ;column start
  sty $44


  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  
  lda vidpage + 1
  clc
  adc #01
  sta vidpage + 1
  lda #$00 
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  
  lda #$80  
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y

  lda vidpage + 1
  clc
  adc #01
  sta vidpage + 1
  lda #$00   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  lda #$80   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  
  lda vidpage + 1
  clc
  adc #01
  sta vidpage + 1
  lda #$00   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y

  lda #$80   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  jmp Next
PrintCharF:
  lda char_vp_p1
  sta vidpage + 1
  lda char_vp
  sta vidpage
  
  ;lda #$30
  ;sta vidpage + 1
  ;lda #$80   
  ;sta vidpage
 
  
  ldy char_y_offset  ;column start
  sty $44


  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  
  lda vidpage + 1
  clc
  adc #01
  sta vidpage + 1
  lda #$00 
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  
  lda #$80  
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y

  lda vidpage + 1
  clc
  adc #01
  sta vidpage + 1
  lda #$00   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  lda #$80   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  
  lda vidpage + 1
  clc
  adc #01
  sta vidpage + 1
  lda #$00   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y

  lda #$80   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y

  jmp Next
PrintCharG:
  lda char_vp_p1
  sta vidpage + 1
  lda char_vp
  sta vidpage
  
  ;lda #$30
  ;sta vidpage + 1
  ;lda #$80   
  ;sta vidpage
 
  
  ldy char_y_offset  ;column start
  sty $44


  lda char_color	;load color stored above
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  
  lda vidpage + 1
  clc
  adc #01
  sta vidpage + 1
  lda #$00 
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  iny
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  
  lda #$80  
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y

  lda vidpage + 1
  clc
  adc #01
  sta vidpage + 1
  lda #$00   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y

  lda #$80   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  
  lda vidpage + 1
  clc
  adc #01
  sta vidpage + 1
  lda #$00   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  iny
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  lda #$80   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  jmp Next
PrintCharH:
  lda char_vp_p1
  sta vidpage + 1
  lda char_vp
  sta vidpage
  
  ;lda #$30
  ;sta vidpage + 1
  ;lda #$80   
  ;sta vidpage
 
  
  ldy char_y_offset  ;column start
  sty $44


  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  iny
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  
  lda vidpage + 1
  clc
  adc #01
  sta vidpage + 1
  lda #$00 
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  iny
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  
  lda #$80  
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  iny
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  lda vidpage + 1
  clc
  adc #01
  sta vidpage + 1
  lda #$00   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  lda #$80   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  iny
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  
  lda vidpage + 1
  clc
  adc #01
  sta vidpage + 1
  lda #$00   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  iny
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  lda #$80   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  iny
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  jmp Next
PrintCharI:
  lda char_vp_p1
  sta vidpage + 1
  lda char_vp
  sta vidpage
  
  ;lda #$30
  ;sta vidpage + 1
  ;lda #$80   
  ;sta vidpage
 
  
  ldy char_y_offset  ;column start
  sty $44


  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  
  lda vidpage + 1
  clc
  adc #01
  sta vidpage + 1
  lda #$00 
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  
  lda #$80  
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  lda vidpage + 1
  clc
  adc #01
  sta vidpage + 1
  lda #$00   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  lda #$80   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  
  lda vidpage + 1
  clc
  adc #01
  sta vidpage + 1
  lda #$00   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  lda #$80   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  jmp Next
PrintCharJ:
  lda char_vp_p1
  sta vidpage + 1
  lda char_vp
  sta vidpage
  
  ;lda #$30
  ;sta vidpage + 1
  ;lda #$80   
  ;sta vidpage
 
  
  ldy char_y_offset  ;column start
  sty $44


  lda char_color	;load color stored above
  iny
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  
  lda vidpage + 1
  clc
  adc #01
  sta vidpage + 1
  lda #$00 
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  iny
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  
  lda #$80  
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  iny
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  lda vidpage + 1
  clc
  adc #01
  sta vidpage + 1
  lda #$00   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  iny
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  lda #$80   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  iny
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  
  lda vidpage + 1
  clc
  adc #01
  sta vidpage + 1
  lda #$00   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  lda #$80   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  jmp Next
PrintCharK:
  lda char_vp_p1
  sta vidpage + 1
  lda char_vp
  sta vidpage
  
  ;lda #$30
  ;sta vidpage + 1
  ;lda #$80   
  ;sta vidpage
 
  
  ldy char_y_offset  ;column start
  sty $44


  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  iny
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  
  lda vidpage + 1
  clc
  adc #01
  sta vidpage + 1
  lda #$00 
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  
  lda #$80  
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  lda vidpage + 1
  clc
  adc #01
  sta vidpage + 1
  lda #$00   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  lda #$80   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  
  lda vidpage + 1
  clc
  adc #01
  sta vidpage + 1
  lda #$00   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  lda #$80   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  iny
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  jmp Next
PrintCharL:
  lda char_vp_p1
  sta vidpage + 1
  lda char_vp
  sta vidpage
  
  ;lda #$30
  ;sta vidpage + 1
  ;lda #$80   
  ;sta vidpage
 
  
  ldy char_y_offset  ;column start
  sty $44


  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  
  lda vidpage + 1
  clc
  adc #01
  sta vidpage + 1
  lda #$00 
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  
  lda #$80  
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y

  lda vidpage + 1
  clc
  adc #01
  sta vidpage + 1
  lda #$00   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y

  lda #$80   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  
  lda vidpage + 1
  clc
  adc #01
  sta vidpage + 1
  lda #$00   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y

  lda #$80   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  jmp Next
PrintCharM:
  lda char_vp_p1
  sta vidpage + 1
  lda char_vp
  sta vidpage
  
  ;lda #$30
  ;sta vidpage + 1
  ;lda #$80   
  ;sta vidpage
 
  
  ldy char_y_offset  ;column start
  sty $44


  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  iny
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  
  lda vidpage + 1
  clc
  adc #01
  sta vidpage + 1
  lda #$00 
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  
  lda #$80  
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  lda vidpage + 1
  clc
  adc #01
  sta vidpage + 1
  lda #$00   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  iny
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  lda #$80   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  iny
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  
  lda vidpage + 1
  clc
  adc #01
  sta vidpage + 1
  lda #$00   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  iny
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  lda #$80   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  iny
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  jmp Next
PrintCharN:
  lda char_vp_p1
  sta vidpage + 1
  lda char_vp
  sta vidpage
  
  ;lda #$30
  ;sta vidpage + 1
  ;lda #$80   
  ;sta vidpage
 
  
  ldy char_y_offset  ;column start
  sty $44


  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  iny
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  
  lda vidpage + 1
  clc
  adc #01
  sta vidpage + 1
  lda #$00 
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  iny
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  
  lda #$80  
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  lda vidpage + 1
  clc
  adc #01
  sta vidpage + 1
  lda #$00   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  lda #$80   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  
  lda vidpage + 1
  clc
  adc #01
  sta vidpage + 1
  lda #$00   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  iny
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  lda #$80   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  iny
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  jmp Next
PrintCharO:
  lda char_vp_p1
  sta vidpage + 1
  lda char_vp
  sta vidpage
  
  ;lda #$30
  ;sta vidpage + 1
  ;lda #$80   
  ;sta vidpage
 
  
  ldy char_y_offset  ;column start
  sty $44


  lda char_color	;load color stored above
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  
  lda vidpage + 1
  clc
  adc #01
  sta vidpage + 1
  lda #$00 
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  iny
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  
  lda #$80  
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  iny
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  lda vidpage + 1
  clc
  adc #01
  sta vidpage + 1
  lda #$00   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  iny
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  lda #$80   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  iny
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  
  lda vidpage + 1
  clc
  adc #01
  sta vidpage + 1
  lda #$00   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  iny
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  lda #$80   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  jmp Next
PrintCharP:
  lda char_vp_p1
  sta vidpage + 1
  lda char_vp
  sta vidpage
  
  ;lda #$30
  ;sta vidpage + 1
  ;lda #$80   
  ;sta vidpage
 
  
  ldy char_y_offset  ;column start
  sty $44


  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  
  lda vidpage + 1
  clc
  adc #01
  sta vidpage + 1
  lda #$00 
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  iny
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  
  lda #$80  
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  iny
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  lda vidpage + 1
  clc
  adc #01
  sta vidpage + 1
  lda #$00   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  lda #$80   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  
  lda vidpage + 1
  clc
  adc #01
  sta vidpage + 1
  lda #$00   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y

  lda #$80   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y

  jmp Next
PrintCharQ:
  lda char_vp_p1
  sta vidpage + 1
  lda char_vp
  sta vidpage
  
  ;lda #$30
  ;sta vidpage + 1
  ;lda #$80   
  ;sta vidpage
 
  
  ldy char_y_offset  ;column start
  sty $44


  lda char_color	;load color stored above
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  
  lda vidpage + 1
  clc
  adc #01
  sta vidpage + 1
  lda #$00 
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  iny
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  
  lda #$80  
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  iny
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  lda vidpage + 1
  clc
  adc #01
  sta vidpage + 1
  lda #$00   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  iny
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  lda #$80   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  
  lda vidpage + 1
  clc
  adc #01
  sta vidpage + 1
  lda #$00   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  lda #$80   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  jmp Next
PrintCharR:
  lda char_vp_p1
  sta vidpage + 1
  lda char_vp
  sta vidpage
  
  ;lda #$30
  ;sta vidpage + 1
  ;lda #$80   
  ;sta vidpage
 
  
  ldy char_y_offset  ;column start
  sty $44


  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  
  lda vidpage + 1
  clc
  adc #01
  sta vidpage + 1
  lda #$00 
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  iny
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  
  lda #$80  
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  iny
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  lda vidpage + 1
  clc
  adc #01
  sta vidpage + 1
  lda #$00   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  lda #$80   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  
  lda vidpage + 1
  clc
  adc #01
  sta vidpage + 1
  lda #$00   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  lda #$80   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  iny
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  jmp Next
PrintCharS:
  lda char_vp_p1
  sta vidpage + 1
  lda char_vp
  sta vidpage
  
  ;lda #$30
  ;sta vidpage + 1
  ;lda #$80   
  ;sta vidpage
 
  
  ldy char_y_offset  ;column start
  sty $44


  lda char_color	;load color stored above
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  
  lda vidpage + 1
  clc
  adc #01
  sta vidpage + 1
  lda #$00 
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  
  lda #$80  
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y

  lda vidpage + 1
  clc
  adc #01
  sta vidpage + 1
  lda #$00   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  lda #$80   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  iny
  iny
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  
  lda vidpage + 1
  clc
  adc #01
  sta vidpage + 1
  lda #$00   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  iny
  iny
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  lda #$80   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  jmp Next
PrintCharT:
  lda char_vp_p1
  sta vidpage + 1
  lda char_vp
  sta vidpage
  
  ;lda #$30
  ;sta vidpage + 1
  ;lda #$80   
  ;sta vidpage
 
  
  ldy char_y_offset  ;column start
  sty $44


  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  
  lda vidpage + 1
  clc
  adc #01
  sta vidpage + 1
  lda #$00 
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  
  lda #$80  
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  lda vidpage + 1
  clc
  adc #01
  sta vidpage + 1
  lda #$00   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  lda #$80   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  
  lda vidpage + 1
  clc
  adc #01
  sta vidpage + 1
  lda #$00   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  lda #$80   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  jmp Next
PrintCharU:
  lda char_vp_p1
  sta vidpage + 1
  lda char_vp
  sta vidpage
  
  ;lda #$30
  ;sta vidpage + 1
  ;lda #$80   
  ;sta vidpage
 
  
  ldy char_y_offset  ;column start
  sty $44


  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  iny
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  
  lda vidpage + 1
  clc
  adc #01
  sta vidpage + 1
  lda #$00 
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  iny
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  
  lda #$80  
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  iny
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  lda vidpage + 1
  clc
  adc #01
  sta vidpage + 1
  lda #$00   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  iny
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  lda #$80   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  iny
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  
  lda vidpage + 1
  clc
  adc #01
  sta vidpage + 1
  lda #$00   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  iny
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  lda #$80   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  jmp Next
PrintCharV:
  lda char_vp_p1
  sta vidpage + 1
  lda char_vp
  sta vidpage
  
  ;lda #$30
  ;sta vidpage + 1
  ;lda #$80   
  ;sta vidpage
 
  
  ldy char_y_offset  ;column start
  sty $44


  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  iny
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  
  lda vidpage + 1
  clc
  adc #01
  sta vidpage + 1
  lda #$00 
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  iny
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  
  lda #$80  
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  iny
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  lda vidpage + 1
  clc
  adc #01
  sta vidpage + 1
  lda #$00   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  iny
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  lda #$80   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  iny
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  
  lda vidpage + 1
  clc
  adc #01
  sta vidpage + 1
  lda #$00   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  lda #$80   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  jmp Next
PrintCharW:
  lda char_vp_p1
  sta vidpage + 1
  lda char_vp
  sta vidpage
  
  ;lda #$30
  ;sta vidpage + 1
  ;lda #$80   
  ;sta vidpage
 
  
  ldy char_y_offset  ;column start
  sty $44


  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  iny
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  
  lda vidpage + 1
  clc
  adc #01
  sta vidpage + 1
  lda #$00 
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  iny
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  
  lda #$80  
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  iny
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  lda vidpage + 1
  clc
  adc #01
  sta vidpage + 1
  lda #$00   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  iny
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  lda #$80   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  
  lda vidpage + 1
  clc
  adc #01
  sta vidpage + 1
  lda #$00   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  lda #$80   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  iny
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  jmp Next
PrintCharX:
  lda char_vp_p1
  sta vidpage + 1
  lda char_vp
  sta vidpage
  
  ;lda #$30
  ;sta vidpage + 1
  ;lda #$80   
  ;sta vidpage
 
  
  ldy char_y_offset  ;column start
  sty $44


  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  iny
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  
  lda vidpage + 1
  clc
  adc #01
  sta vidpage + 1
  lda #$00 
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  iny
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  
  lda #$80  
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  lda vidpage + 1
  clc
  adc #01
  sta vidpage + 1
  lda #$00   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  lda #$80   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  
  lda vidpage + 1
  clc
  adc #01
  sta vidpage + 1
  lda #$00   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  iny
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  lda #$80   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  iny
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  jmp Next
PrintCharY:
  lda char_vp_p1
  sta vidpage + 1
  lda char_vp
  sta vidpage
  
  ;lda #$30
  ;sta vidpage + 1
  ;lda #$80   
  ;sta vidpage
 
  
  ldy char_y_offset  ;column start
  sty $44


  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  iny
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  
  lda vidpage + 1
  clc
  adc #01
  sta vidpage + 1
  lda #$00 
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  iny
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  
  lda #$80  
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  lda vidpage + 1
  clc
  adc #01
  sta vidpage + 1
  lda #$00   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  lda #$80   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  
  lda vidpage + 1
  clc
  adc #01
  sta vidpage + 1
  lda #$00   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  lda #$80   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  jmp Next
PrintCharZ:
  lda char_vp_p1
  sta vidpage + 1
  lda char_vp
  sta vidpage
  
  ;lda #$30
  ;sta vidpage + 1
  ;lda #$80   
  ;sta vidpage
 
  
  ldy char_y_offset  ;column start
  sty $44


  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  
  lda vidpage + 1
  clc
  adc #01
  sta vidpage + 1
  lda #$00 
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  iny
  iny
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  
  lda #$80  
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  iny
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  lda vidpage + 1
  clc
  adc #01
  sta vidpage + 1
  lda #$00   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  lda #$80   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  
  lda vidpage + 1
  clc
  adc #01
  sta vidpage + 1
  lda #$00   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y

  lda #$80   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  jmp Next
PrintCharSpace:
  ;nothing to do for a space
  jmp Next
PrintCharPeriod:
  lda char_vp_p1
  sta vidpage + 1
  lda char_vp
  sta vidpage
  
  ;lda #$30
  ;sta vidpage + 1
  ;lda #$80   
  ;sta vidpage
 
  
  ldy char_y_offset  ;column start
  sty $44


  lda char_color	;load color stored above
  ;iny
  ;sta (vidpage), y ; write A register to address vidpage + y

  
  lda vidpage + 1
  clc
  adc #01
  sta vidpage + 1
  lda #$00 
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  
  lda #$80  
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above

  lda vidpage + 1
  clc
  adc #01
  sta vidpage + 1
  lda #$00   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above

  lda #$80   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  
  lda vidpage + 1
  clc
  adc #01
  sta vidpage + 1
  lda #$00   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above

  lda #$80   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  
  jmp Next
PrintCharExclamation:
  lda char_vp_p1
  sta vidpage + 1
  lda char_vp
  sta vidpage
  
  ;lda #$30
  ;sta vidpage + 1
  ;lda #$80   
  ;sta vidpage
 
  
  ldy char_y_offset  ;column start
  sty $44


  lda char_color	;load color stored above
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  
  lda vidpage + 1
  clc
  adc #01
  sta vidpage + 1
  lda #$00 
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  
  lda #$80  
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y


  lda vidpage + 1
  clc
  adc #01
  sta vidpage + 1
  lda #$00   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y


  lda #$80   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  
  lda vidpage + 1
  clc
  adc #01
  sta vidpage + 1
  lda #$00   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above

  lda #$80   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  
  jmp Next
PrintCharQuestion:
  lda char_vp_p1
  sta vidpage + 1
  lda char_vp
  sta vidpage
  
  ;lda #$30
  ;sta vidpage + 1
  ;lda #$80   
  ;sta vidpage
 
  
  ldy char_y_offset  ;column start
  sty $44


  lda char_color	;load color stored above
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  
  lda vidpage + 1
  clc
  adc #01
  sta vidpage + 1
  lda #$00 
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  iny
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  
  lda #$80  
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  iny
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  lda vidpage + 1
  clc
  adc #01
  sta vidpage + 1
  lda #$00   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  iny
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  lda #$80   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  
  lda vidpage + 1
  clc
  adc #01
  sta vidpage + 1
  lda #$00   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above

  lda #$80   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  iny
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  
  jmp Next
PrintCharDash:
  lda char_vp_p1
  sta vidpage + 1
  lda char_vp
  sta vidpage
  
  ;lda #$30
  ;sta vidpage + 1
  ;lda #$80   
  ;sta vidpage
 
  
  ldy char_y_offset  ;column start
  sty $44


  lda char_color	;load color stored above
  ;iny
  ;sta (vidpage), y ; write A register to address vidpage + y

  
  lda vidpage + 1
  clc
  adc #01
  sta vidpage + 1
  lda #$00 
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  
  lda #$80  
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above

  lda vidpage + 1
  clc
  adc #01
  sta vidpage + 1
  lda #$00   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  sta (vidpage), y ; write A register to address vidpage + y

  lda #$80   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  
  lda vidpage + 1
  clc
  adc #01
  sta vidpage + 1
  lda #$00   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above

  lda #$80   
  sta vidpage
  ldy $44  ;column
  lda char_color	;load color stored above
  
  jmp Next

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
  lda #$00	;color    40=black(ish)
  sta (vidpage), y ; write A register to address vidpage + y
  iny
  tya	;transfer Y to accumulator
  cmp #$64 ; if we cycled through 100 columns	compare A to 0x63 (99)		have worked 0-99 = 100 columns
  bne FillRowBlack	
  rts

Delay:
  ;Simple delay routing. Counts from 0 to 65535 for the delay.  
  ;https://gist.github.com/superjamie/fd80fabadf39199c97de400213f614e9
  sta $40   ;save current accumulator
  ;lda #$C0	;counter start - increase number to shorten delay
  lda delayDurationHighByte	;counter start - increase number to shorten delay
  sta $41  ; store high byte
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
  lda #$23
  sta char_vp_p1
  sta vidpage + 1
  lda #$00
  sta char_vp
  sta vidpage
  lda #$3F
  sta char_color
  lda #$5
  sta char_y_offset

  ldx #$20 ; X will count down how many pages of video RAM to go
  ldy #$0 ; populate a page starting at 0
  rts

  nmi:
  rti


  .org $fd00
keymap:
  .byte "????????????? `?" ; 00-0F
  .byte "?????q1???zsaw2?" ; 10-1F
  .byte "?cxde43?? vftr5?" ; 20-2F
  .byte "?nbhgy6???mju78?" ; 30-3F
  .byte "?,kio09??./l;p-?" ; 40-4F
  .byte "??'?[=????",$0a,"]?\??" ; 50-5F
  .byte "?????????1?47???" ; 60-6F
  .byte "0.2568",$1b,"??+3-*9??" ; 70-7F
  .byte "????????????????" ; 80-8F
  .byte "????????????????" ; 90-9F
  .byte "????????????????" ; A0-AF
  .byte "????????????????" ; B0-BF
  .byte "????????????????" ; C0-CF
  .byte "????????????????" ; D0-DF
  .byte "????????????????" ; E0-EF
  .byte "????????????????" ; F0-FF
keymap_shifted:
  .byte "????????????? ~?" ; 00-0F
  .byte "?????Q!???ZSAW@?" ; 10-1F
  .byte "?CXDE#$?? VFTR%?" ; 20-2F
  .byte "?NBHGY^???MJU&*?" ; 30-3F
  .byte "?<KIO)(??>?L:P_?" ; 40-4F
  .byte '??"?{+?????}?|??' ; 50-5F
  .byte "?????????1?47???" ; 60-6F
  .byte "0.2568???+3-*9??" ; 70-7F
  .byte "????????????????" ; 80-8F
  .byte "????????????????" ; 90-9F
  .byte "????????????????" ; A0-AF
  .byte "????????????????" ; B0-BF
  .byte "????????????????" ; C0-CF
  .byte "????????????????" ; D0-DF
  .byte "????????????????" ; E0-EF
  .byte "????????????????" ; F0-FF

; Reset/IRQ vectors
  .org $fffa
  .word nmi
  .word reset
  .word keyboard_interrupt
