; Project for 6502+VGA from Ben Eater
; Assembly code to be compiled with vasm - to create bin file for EEPROM programmer
; Command line to run:
;	vasm6502_oldstyle.exe -Fbin -dotdir vga-text.s -o vga-text.bin

; Use X to track the video page
; Use Y to track the column in the page
; Use A to track pixel color
; Resolution: 100 columns x 60 rows (was 75 rows with just VGA circuit, with no 6502 integration)

; 00110000	48	bright blue
; 00100000	32	dim blue
; 00010000	16	middle blue
; 
; 00001100	12	bright blue
; 00001000	8	dim blue
; 00000100	4	middle blue
; 
; 00000011	3	bright red
; 00000010	2	dim red
; 00000001	1	middle red
; 
; 00000000	0	black
; 00111111	63	white

;lda #$00	;color	BLACK
;lda #$30	;color  BLUE BRIGHT
;lda #$10	;color  BLUE REGULAR    
;lda #$20	;color  BLUE DIM
;lda #$0c	;color  GREEN BRIGHT
;lda #$04	;color  GREEN REGULAR
;lda #$08	;color  GREEN DIM
;lda #$03	;color  RED BRIGHT
;lda #$01	;color  RED REGULAR
;lda #$02	;color  RED DIM
;lda #$3F	;color  WHITE

; Font: 5x7 fixed   https://thumb7.shutterstock.com/display_pic_with_logo/1811018/359671199/stock-vector-blue-led-letters-and-numbers-electronic-scoreboard-vector-alphabet-359671199.jpg

vidpage = $0000 ; 2 bytes
char_vp = $50
char_vp_p1 = $52
char_color = $54

;start_color = $0002 ; 1 byte

  .org $8000
reset:
loop:
  ;TO DO Instead of clearly the entire screen, just clear the space for the character about to be displayed

  jsr InitVideoMemory
  jsr FillBlack

  ;where to place chars and char color - change these locations before calling PrintChar
  lda #$30
  sta char_vp_p1
  lda #$80
  sta char_vp
  lda #$3F
  sta char_color
  
  jsr PrintChar9

  jsr InitVideoMemory
  jsr FillBlack
  jsr PrintChar8

  jsr InitVideoMemory
  jsr FillBlack
  jsr PrintChar7
  
  jsr InitVideoMemory
  jsr FillBlack
  jsr PrintChar6

  jsr InitVideoMemory
  jsr FillBlack
  jsr PrintChar5

  jsr InitVideoMemory
  jsr FillBlack
  lda #$0F  ;change color to yellow
  sta char_color
  jsr PrintChar4

  jsr InitVideoMemory
  jsr FillBlack
  jsr PrintChar3

  jsr InitVideoMemory
  jsr FillBlack
  jsr PrintChar2

  jsr InitVideoMemory
  jsr FillBlack
  lda #$03  ;change color to red
  sta char_color
  jsr PrintChar1

  jsr InitVideoMemory
  jsr FillBlack
  jsr PrintChar0

  jmp loop
Finished:
  jmp Finished  ;end of the program... sit and spin

ClearChar:
  ;TO DO - Clear a single character
  rts

;Subroutines for manually (painfully) creating each character
;Lots of room for improvement here. Please send me tips and tricks. :)
;Will likely setup variables to store a 5-byte representation of each character (A-Z, 0-9, etc.), and make a more general routine to read those representations to generate the output - similar to Ben's approach for the LED segment display on the 8-bit computer'
PrintChar0:
 
  lda char_vp_p1
  sta vidpage + 1
  lda char_vp
  sta vidpage
      
  ldy #$20  ;column start
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

  rts
PrintChar1:
 
  lda char_vp_p1
  sta vidpage + 1
  lda char_vp
  sta vidpage
      
  ldy #$20  ;column start
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

  rts
PrintChar2:
 
  lda char_vp_p1
  sta vidpage + 1
  lda char_vp
  sta vidpage
      
  ldy #$20  ;column start
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

  rts
PrintChar3:
 
  lda char_vp_p1
  sta vidpage + 1
  lda char_vp
  sta vidpage
      
  ldy #$20  ;column start
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

  rts
PrintChar4:
 
  lda char_vp_p1
  sta vidpage + 1
  lda char_vp
  sta vidpage
      
  ldy #$20  ;column start
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

  rts
PrintChar5:
 
  lda char_vp_p1
  sta vidpage + 1
  lda char_vp
  sta vidpage
      
  ldy #$20  ;column start
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

  rts
PrintChar6:
 
  lda char_vp_p1
  sta vidpage + 1
  lda char_vp
  sta vidpage
      
  ldy #$20  ;column start
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

  rts
PrintChar7:
 
  lda char_vp_p1
  sta vidpage + 1
  lda char_vp
  sta vidpage
      
  ldy #$20  ;column start
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

  rts
PrintChar8:
 
  lda char_vp_p1
  sta vidpage + 1
  lda char_vp
  sta vidpage
      
  ldy #$20  ;column start
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

  rts
PrintChar9:
  lda char_vp_p1
  sta vidpage + 1
  lda char_vp
  sta vidpage
  
  ;lda #$30
  ;sta vidpage + 1
  ;lda #$80   
  ;sta vidpage
 
  
  ldy #$20  ;column start
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
  lda #$00	;counter start - increase number to shorten delay
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
  lda #$20
  sta vidpage + 1
  lda #$00
  sta vidpage
  ldx #$20 ; X will count down how many pages of video RAM to go
  ldy #$0 ; populate a page starting at 0
  rts

; Reset/IRQ/NMI vectors
  .org $fffa
  .word reset
  .word reset
  .word reset