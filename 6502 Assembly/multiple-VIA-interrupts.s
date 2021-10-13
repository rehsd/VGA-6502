; Assembly code to be compiled with vasm - to create bin file for EEPROM programmer
; Example command line to run:
;	vasm6502_oldstyle.exe -Fbin -dotdir test_interrupts_3vias.s -o test_interrupts_3vias.bin

PORT1B = $6000
PORT1A = $6001
DDR1B  = $6002
DDR1A  = $6003
PCR1   = $600C
IFR1   = $600D
IER1   = $600E

PORT2B = $5000
PORT2A = $5001
DDR2B  = $5002
DDR2A  = $5003
PCR2   = $500C
IFR2   = $500D
IER2   = $500E

PORT3B = $4800
PORT3A = $4801
DDR3B  = $4802
DDR3A  = $4803
PCR3   = $480C
IFR3   = $480D
IER3   = $480E

B1	= %10000000
B2	= %01000000
B3	= %00100000
B4	= %00010000
B5	= %00001000
B6	= %00000100
B7	= %00000010
B8	= %00000001
B9	= %00000000
B10 = %11111111

  .org $8000

reset:
  ;setup interrupts
  cli
  lda #$82
  sta IER1
  sta IER2
  sta IER3
  lda #$00
  sta PCR1
  sta PCR2
  sta PCR3

  ;set all VIA ports as output
  lda #$ff
  sta DDR1B
  sta DDR1A
  sta DDR2B
  sta DDR2A
  sta DDR3B
  sta DDR3A

  ;output an initial value (displayed on bar graphs)
  lda B2
  sta PORT1B
  sta PORT1A
  lda B4
  sta PORT2B
  sta PORT2A
  lda B6
  sta PORT3B
  sta PORT3A

loop:
  jmp loop

allTest:
  lda B9
  sta PORT1B
  sta PORT1A
  sta PORT2B
  sta PORT2A
  sta PORT3B
  sta PORT3A

  lda B1
  sta PORT1B
  sta PORT1A
  lda B3
  sta PORT2B
  sta PORT2A
  lda B5
  sta PORT3B
  sta PORT3A

  lda B2
  sta PORT1B
  sta PORT1A
  lda B4
  sta PORT2B
  sta PORT2A
  lda B6
  sta PORT3B
  sta PORT3A

  lda B10
  sta PORT1B
  sta PORT1A
  sta PORT2B
  sta PORT2A
  sta PORT3B
  sta PORT3A

  rts

VIA1_IRQ:
  lda B1
  sta PORT1B
  sta PORT1A
  sta PORT2B
  sta PORT2A
  sta PORT3B
  sta PORT3A

  jmp irq_done

VIA2_IRQ:
  lda B2
  sta PORT1B
  sta PORT1A
  sta PORT2B
  sta PORT2A
  sta PORT3B
  sta PORT3A

  jmp irq_done

VIA3_IRQ:
  lda B3
  sta PORT1B
  sta PORT1A
  sta PORT2B
  sta PORT2A
  sta PORT3B
  sta PORT3A

  jmp irq_done

nmi:
  rti

irq:
  pha
  txa
  pha
  tya
  pha

  ;check interrupts in order of priority
  BIT  IFR1				; Check status register for VIA1
  BMI  VIA1_IRQ			; Branch if VIA1 is interrupt source
  BIT  IFR2				; Check status register for VIA2
  BMI  VIA2_IRQ			; Branch if VIA2 is interrupt source
  BIT  IFR3				; Check status register for VIA3_STATUS
  BMI  VIA3_IRQ			; Branch if VIA3 is interrupt source

  ;Should never get here unless missing a BIT/BMI for the interrupt source

irq_done:
  pla
  tay
  pla
  tax
  pla
  rti

  .org $fffa
  .word nmi
  .word reset
  .word irq
