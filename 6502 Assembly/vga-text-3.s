;General Information
    ; Project for 6502+LCD+PS2+VGA for Ben Eater circuit design
    ; 6502 with 2-line LCD display and PS2 - base design by ben Eater
    ; VGA base design by Ben Eater
    ; 2-line LCD in 4-bit (nibble) mode
    ; 6502 clock at 4.9 MHz, VGA clock at 10 MHz
    ; This assembly code developed by rehsd with foundational elements from Ben Eater (others if noted in code)
    ; Last updated August 2021
    ; Assembly code compiled with vasm and uploaded to ROM on 6502 build
    ; Example command line to run:
    ;	vasm6502_oldstyle.exe -Fbin -dotdir vga_ps2kbdLCD_charmap.s -o vga_ps2kbdLCD_charmap.bin

    ; Use X to track the video page
    ; Use Y to track the column in the page
    ; Use A to track pixel color
    ; 'VGA' Resolution: 100 columns x 60 rows (was 75 rows with just VGA circuit, with no 6502 integration)

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
        ;   Combine the above bits for other colors

    ; Font: 5x7 fixed   https://fontstruct.com/fontstructions/show/847768/5x7_dot_matrix
    ; Font pixel data is stored in ROM
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
    ; -FillRegion type of subroutine to draw rectanglular shapes
    ; -General code optimization - removal of unecessary calls

;Variable declarations / memory-related

vidpage                 = $0000 ; 2 bytes
kb_wptr                 = $0005
kb_rptr                 = $0006
kb_flags                = $0007
char_vp                 = $0010
char_vp_p1              = $0012
char_color              = $0014
char_y_offset           = $0016
char_current_val        = $0018
message_to_process      = $0020
delayDurationHighByte   = $0030     ;Count from this number (high byte) to FF - higher number results in shorter delay

;other addresses used throughout code
;                         $40, $41    Delay subroutine
;                         $44         Horizontal pixel writing location
;                         $46
;                         $48         Charpixel row stop
;                         $50         charmap current char byte
;                         $52         charix row loop counter
;                         $54         print string current char to process

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

PIXEL_COL1              = %10000000
PIXEL_COL2              = %01000000
PIXEL_COL3              = %00100000
PIXEL_COL4              = %00010000
PIXEL_COL5              = %00001000

ASCII_CHARMAP           = %11100000

;.org $8000         ;comment here for outlining in Visual Studio editor
  .org $8000
reset:
  ;*** vga ***
  lda #$00
  sta delayDurationHighByte

  ;*** ps2lcd ***
  ldx #$ff
  txs

  lda #$01	    ;positive edge (in code from Ben)
  sta PCR		;Set CA1 to positive edge

  lda #$82		;1000 0010	Enables interrupt CA1, disables everything else: Clear Timer1 Timer2 CB1 CB2 Shift Register CA2 
  sta IER
  cli

  lda #%11111111 ; Set all pins on port B to output
  sta DDRB
  lda #%00000000 ; Set all pins on port A to input
  sta DDRA

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


  lda #$00
  sta kb_flags
  sta kb_wptr
  sta kb_rptr

  ;*** vga ***
  jsr InitVideoMemory
  jsr FillBlack

    ;*** vga ***
  ;where to place chars and char color - change these locations before calling PrintChar
  ;TO DO Graphic to show how VGA addressing is setup
  lda #$28
  sta char_vp_p1
  lda #$80
  sta char_vp
  lda #$3F  ;white
  sta char_color
  lda #$5
  sta char_y_offset

  ;Display pre-defined message #1
  lda #$01
  sta message_to_process
  jsr PrintString
  
  ;Set to 0 when transitioning to dynamic strings/chars (vs. pre-defined, stored messages)
  lda #$00  ;done processing pre-defined strings
  sta message_to_process
loop:
  ;*** ps2lcd ***
  ;sit here and loop, process key presses via interrupts as they come in
  sei                   ;Set the interrupt disable flag to one.
  lda kb_rptr
  cmp kb_wptr
  cli                   ;Clear Interrupt Disable
  bne key_pressed
  jmp loop
Finished:
  jmp Finished  ;end of the program if sent to this subroutine... sit and spin
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

  inc kb_rptr
  jmp loop
enter_pressed:
  
  ;*** vga ***
  ;crlf
  ;jsr NextVGALine   ;one pixel
  ;jsr NextVGALine   ;one pixel
  ;jsr NextVGALine   ;one pixel
  ;jsr NextVGALine   ;one pixel
  ;jsr NextVGALine   ;one pixel
  ;jsr NextVGALine   ;one pixel
  ;jsr NextVGALine   ;one pixel
  ;jsr NextVGALine   ;one pixel
  ;jsr NextVGALine   ;one pixel

  ;old code:
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
  ;wait a bit before initializing the screen - helpful at higher clock speeds
  jsr  Delay
  jsr  Delay

  ;see page 42 of https://eater.net/datasheets/HD44780.pdf
  lda #%00000010 ; Set 4-bit mode
  sta PORTB
  jsr  Delay
  ora #E
  sta PORTB
  jsr  Delay
  and #%00001111
  sta PORTB

  rts
lcd_instruction:
  ;send an instruction to the 2-line LCD
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
  ;print a character on the 2-line LCD
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
keyboard_interrupt:
  ;handle a keypress
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
  ;TO DO - Clear a single character, instad of having to clear entire screen
  rts

;Predefined messages
message1 db "abcdef", 0
message2 db "ABCDEFGHIJKLM", 0
message3 db "NOPQRSTUVWXYZ", 0
message4 db "00.0F!FF?10", 0
message5 db "SET POSITION", 0
message6 db "  AND COLOR", 0
message7 db "6502 PLUS", 0
message8 db "    V-G-A", 0

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
  
  ;jsr print_char_lcd                ;^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  
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

  ;lda #$51  ;Q
  ;jsr print_char_lcd 
  ;lda char_current_val
  ;jsr print_char_lcd                ;^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  
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
  ; TO DO point to questionm mark when no supported char is found...
  
  ;lda #$7b  ;{
  ;jsr print_char_lcd                ;^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  ;rts   ;will it ever get here?
 
GetCharMap1:
  ;supports ASCII chars from 0x20 to 0x3F
  clc
  ;lda #$31  ;1                                                              ;^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  ;jsr print_char_lcd   ;helpful to print to 2-line LCD when debugging       ;^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
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
  ;lda #$32  ;2                                                             ;^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  ;jsr print_char_lcd   ;helpful to print to 2-line LCD when debugging      ;^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

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
  ;lda #$33  ;3                                                                 ;^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  ;jsr print_char_lcd   ;helpful to print to 2-line LCD when debugging          ;^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

  ;supports ASCII chars from 0x60 to 0x7F
  clc
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
      ;ldx $46   ;return x to state when coming into routine

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

  ;ldx $40   ;get x back
  ;inx   ;so that processing of loop strings will move to the next char in the string
  jmp PrintStringLoop
NextVGALine:
    ;move the location for writing to the screen down one line. Example:
    ;vidpage+1    00      vidpage 80
    ;next line
    ;vidpdage+1   01      vidpage 00
    ;next line
    ;vidpdage+1   01      vidpage 80
    clc
    lda vidpage
    adc #$80
    sta vidpage
    ;sta char_vp
    lda vidpage + 1   ;do not clc... need the carry bit to roll to the second (high) byte
    adc #$00          ;add carry
    sta vidpage + 1
    ;sta char_vp_p1
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
  .word keyboard_interrupt
