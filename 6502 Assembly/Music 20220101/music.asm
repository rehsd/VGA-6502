    ;Music example
    .org $9400

    PlaySong:

        pha ;a to stack
        phx ;x to stack
        phy ;y to stack

        lda #$FF    ;write
        sta DDR4A
        sta DDR4B

        jsr SoundTick
        jsr SoundTick
        jsr SoundTick
        jsr SoundTick

        ResetPSGs:
            ;*************** sound to AY1_2_3_4 (SND_RESET) ***************
                lda #<SND_RESET
                sta TUNE_PTR_LO
                lda #>SND_RESET
                sta TUNE_PTR_HI

                jsr AY1_PlayTune
                jsr AY2_PlayTune
                jsr AY3_PlayTune
                jsr AY4_PlayTune


        Measure1_top:
            ;play twice
            lda #0
            sta PlaySong_MeasureLoop
        Measure1:
            ;1/12
            ;*************** sound to AY1_2 (SND_TONE_G4) ***************
                lda #<SND_TONE_G4
                sta TUNE_PTR_LO
                lda #>SND_TONE_G4
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G2_CHB) ***************
                lda #<SND_TONE_G2_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_G2_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G1_CHC) ***************
                lda #<SND_TONE_G1_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_G1_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune


                jsr SoundTick

            ;2/12
            ;*************** sound to AY1_2 (SND_TONE_D4) ***************
                lda #<SND_TONE_D4
                sta TUNE_PTR_LO
                lda #>SND_TONE_D4
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G2_CHB) ***************
                lda #<SND_TONE_G2_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_G2_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
                ;*************** sound to AY1_2 (SND_TONE_G1_CHC) ***************
                lda #<SND_TONE_G1_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_G1_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

                jsr SoundTick

            ;3/12
            ;*************** sound to AY1_2 (SND_TONE_G4) ***************
                lda #<SND_TONE_G4
                sta TUNE_PTR_LO
                lda #>SND_TONE_G4
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G2_CHB) ***************
                lda #<SND_TONE_G2_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_G2_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
                ;*************** sound to AY1_2 (SND_TONE_G1_CHC) ***************
                lda #<SND_TONE_G1_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_G1_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

                jsr SoundTick

            ;4/12
            ;*************** sound to AY1_2 (SND_TONE_D4) ***************
                lda #<SND_TONE_D4
                sta TUNE_PTR_LO
                lda #>SND_TONE_D4
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G2_CHB) ***************
                lda #<SND_TONE_G2_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_G2_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G1_CHC_OFF) ***************
                lda #<SND_TONE_G1_CHC_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_G1_CHC_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

                jsr SoundTick

            ;5/12
            ;*************** sound to AY1_2 (SND_TONE_G4) ***************
                lda #<SND_TONE_G4
                sta TUNE_PTR_LO
                lda #>SND_TONE_G4
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G2_CHB) ***************
                lda #<SND_TONE_G2_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_G2_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G1_CHC) ***************
                lda #<SND_TONE_G1_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_G1_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

                jsr SoundTick

            ;6/12
            ;*************** sound to AY1_2 (SND_TONE_D4) ***************
                lda #<SND_TONE_D4
                sta TUNE_PTR_LO
                lda #>SND_TONE_D4
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G2_CHB) ***************
                lda #<SND_TONE_G2_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_G2_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G1_CHC_OFF) ***************
                lda #<SND_TONE_G1_CHC_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_G1_CHC_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

                jsr SoundTick

            lda PlaySong_MeasureLoop
            cmp #$01
            beq Measure2_top
            lda #01
            sta PlaySong_MeasureLoop
            jmp Measure1

        Measure2_top:
            ;play twice
            lda #0
            sta PlaySong_MeasureLoop
        Measure2:
    

            ;1/12
            ;*************** sound to AY1_2 (SND_TONE_F4S) ***************
                lda #<SND_TONE_F4S
                sta TUNE_PTR_LO
                lda #>SND_TONE_F4S
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_A2S_CHB) ***************
                lda #<SND_TONE_A2S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A2S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_A1S_CHC) ***************
                lda #<SND_TONE_A1S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_A1S_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune


                jsr SoundTick

            ;2/12
            ;*************** sound to AY1_2 (SND_TONE_C4S) ***************
                lda #<SND_TONE_C4S
                sta TUNE_PTR_LO
                lda #>SND_TONE_C4S
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_A2S_CHB) ***************
                lda #<SND_TONE_A2S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A2S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
                ;*************** sound to AY1_2 (SND_TONE_A1S_CHC) ***************
                lda #<SND_TONE_A1S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_A1S_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

                jsr SoundTick

            ;3/12
            ;*************** sound to AY1_2 (SND_TONE_F4S) ***************
                lda #<SND_TONE_F4S
                sta TUNE_PTR_LO
                lda #>SND_TONE_F4S
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_A2S_CHB) ***************
                lda #<SND_TONE_A2S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A2S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
                ;*************** sound to AY1_2 (SND_TONE_A1S_CHC) ***************
                lda #<SND_TONE_A1S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_A1S_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

                jsr SoundTick

            ;4/12
            ;*************** sound to AY1_2 (SND_TONE_C4S) ***************
                lda #<SND_TONE_C4S
                sta TUNE_PTR_LO
                lda #>SND_TONE_C4S
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_A2S_CHB) ***************
                lda #<SND_TONE_A2S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A2S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_A1S_CHC_OFF) ***************
                lda #<SND_TONE_A1S_CHC_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A1S_CHC_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

                jsr SoundTick

            ;5/12
            ;*************** sound to AY1_2 (SND_TONE_F4S) ***************
                lda #<SND_TONE_F4S
                sta TUNE_PTR_LO
                lda #>SND_TONE_F4S
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_A2S_CHB) ***************
                lda #<SND_TONE_A2S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A2S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
                ;*************** sound to AY1_2 (SND_TONE_A1S_CHC) ***************
                lda #<SND_TONE_A1S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_A1S_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

                jsr SoundTick

            ;6/12
            ;*************** sound to AY1_2 (SND_TONE_C4S) ***************
                lda #<SND_TONE_C4S
                sta TUNE_PTR_LO
                lda #>SND_TONE_C4S
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_A2S_CHB) ***************
                lda #<SND_TONE_A2S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A2S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_A1S_CHC_OFF) ***************
                lda #<SND_TONE_A1S_CHC_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A1S_CHC_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

                jsr SoundTick

            lda PlaySong_MeasureLoop
            cmp #$01
            beq Measure3_top
            lda #01
            sta PlaySong_MeasureLoop
            jmp Measure2

        Measure3_top:
            ;play twice
            lda #0
            sta PlaySong_MeasureLoop
        Measure3:


            ;1/12
            ;*************** sound to AY1_2 (SND_TONE_G4) ***************
                lda #<SND_TONE_G4
                sta TUNE_PTR_LO
                lda #>SND_TONE_G4
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_D3S_CHB) ***************
                lda #<SND_TONE_D3S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_D3S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_D2S_CHC) ***************
                lda #<SND_TONE_D2S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_D2S_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune


                jsr SoundTick

            ;2/12
            ;*************** sound to AY1_2 (SND_TONE_A3S) ***************
                lda #<SND_TONE_A3S
                sta TUNE_PTR_LO
                lda #>SND_TONE_A3S
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_D3S_CHB) ***************
                lda #<SND_TONE_D3S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_D3S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
                ;*************** sound to AY1_2 (SND_TONE_D2S_CHC) ***************
                lda #<SND_TONE_D2S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_D2S_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

                jsr SoundTick

            ;3/12
            ;*************** sound to AY1_2 (SND_TONE_G4) ***************
                lda #<SND_TONE_G4
                sta TUNE_PTR_LO
                lda #>SND_TONE_G4
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_D3S_CHB) ***************
                lda #<SND_TONE_D3S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_D3S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
                ;*************** sound to AY1_2 (SND_TONE_D2S_CHC) ***************
                lda #<SND_TONE_D2S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_D2S_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

                jsr SoundTick

            ;4/12
            ;*************** sound to AY1_2 (SND_TONE_A3S) ***************
                lda #<SND_TONE_A3S
                sta TUNE_PTR_LO
                lda #>SND_TONE_A3S
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_D3S_CHB) ***************
                lda #<SND_TONE_D3S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_D3S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_D2S_CHC_OFF) ***************
                lda #<SND_TONE_D2S_CHC_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_D2S_CHC_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

                jsr SoundTick

            ;5/12
            ;*************** sound to AY1_2 (SND_TONE_G4) ***************
                lda #<SND_TONE_G4
                sta TUNE_PTR_LO
                lda #>SND_TONE_G4
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_D3S_CHB) ***************
                lda #<SND_TONE_D3S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_D3S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
                ;*************** sound to AY1_2 (SND_TONE_D2S_CHC) ***************
                lda #<SND_TONE_D2S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_D2S_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

                jsr SoundTick

            ;6/12
            ;*************** sound to AY1_2 (SND_TONE_A3S) ***************
                lda #<SND_TONE_A3S
                sta TUNE_PTR_LO
                lda #>SND_TONE_A3S
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_D3S_CHB) ***************
                lda #<SND_TONE_D3S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_D3S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_D2S_CHC_OFF) ***************
                lda #<SND_TONE_D2S_CHC_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_D2S_CHC_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

                jsr SoundTick

            lda PlaySong_MeasureLoop
            jsr print_hex_lcd
            cmp #$01
            beq Measure4_top
            lda #01
            sta PlaySong_MeasureLoop
            jmp Measure3

        Measure4_top:
            ;play twice
            lda #0
            sta PlaySong_MeasureLoop
        Measure4:

            ;1/12
            ;*************** sound to AY1_2 (SND_TONE_F4S) ***************
                lda #<SND_TONE_F4S
                sta TUNE_PTR_LO
                lda #>SND_TONE_F4S
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_B2_CHB) ***************
                lda #<SND_TONE_B2_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_B2_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_B1_CHC) ***************
                lda #<SND_TONE_B1_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_B1_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune


                jsr SoundTick

            ;2/12
            ;*************** sound to AY1_2 (SND_TONE_B3) ***************
                lda #<SND_TONE_B3
                sta TUNE_PTR_LO
                lda #>SND_TONE_B3
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_B2_CHB) ***************
                lda #<SND_TONE_B2_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_B2_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
                ;*************** sound to AY1_2 (SND_TONE_B1_CHC) ***************
                lda #<SND_TONE_B1_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_B1_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

                jsr SoundTick

            ;3/12
            ;*************** sound to AY1_2 (SND_TONE_F4S) ***************
                lda #<SND_TONE_F4S
                sta TUNE_PTR_LO
                lda #>SND_TONE_F4S
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_B2_CHB) ***************
                lda #<SND_TONE_B2_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_B2_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
                ;*************** sound to AY1_2 (SND_TONE_B1_CHC) ***************
                lda #<SND_TONE_B1_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_B1_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

                jsr SoundTick

            ;4/12
            ;*************** sound to AY1_2 (SND_TONE_B3) ***************
                lda #<SND_TONE_B3
                sta TUNE_PTR_LO
                lda #>SND_TONE_B3
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_B2_CHB) ***************
                lda #<SND_TONE_B2_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_B2_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_B1_CHC_OFF) ***************
                lda #<SND_TONE_B1_CHC_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_B1_CHC_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

                jsr SoundTick

            ;5/12
            ;*************** sound to AY1_2 (SND_TONE_F4S) ***************
                lda #<SND_TONE_F4S
                sta TUNE_PTR_LO
                lda #>SND_TONE_F4S
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_B2_CHB) ***************
                lda #<SND_TONE_B2_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_B2_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
                ;*************** sound to AY1_2 (SND_TONE_B1_CHC) ***************
                lda #<SND_TONE_B1_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_B1_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

                jsr SoundTick

            ;6/12
            ;*************** sound to AY1_2 (SND_TONE_B3) ***************
                lda #<SND_TONE_B3
                sta TUNE_PTR_LO
                lda #>SND_TONE_B3
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_B2_CHB) ***************
                lda #<SND_TONE_B2_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_B2_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_B1_CHC_OFF) ***************
                lda #<SND_TONE_B1_CHC_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_B1_CHC_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

                jsr SoundTick

            lda PlaySong_MeasureLoop
            jsr print_hex_lcd
            cmp #$01
            beq Measure5_top
            lda #01
            sta PlaySong_MeasureLoop
            jmp Measure4

        Measure5_top:
            ;play twice
            lda #0
            sta PlaySong_MeasureLoop
        Measure5:
    
            ;*************** sound to AY1_2_3_4 (SND_RESET) ***************
                lda #<SND_RESET
                sta TUNE_PTR_LO
                lda #>SND_RESET
                sta TUNE_PTR_HI

                jsr AY1_PlayTune
                jsr AY2_PlayTune
                jsr AY3_PlayTune
                jsr AY4_PlayTune

            ;1/12
            ;*************** sound to AY1_2 (SND_TONE_G4) ***************
                lda #<SND_TONE_G4
                sta TUNE_PTR_LO
                lda #>SND_TONE_G4
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G2_CHB) ***************
                lda #<SND_TONE_G2_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_G2_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G1_CHC) ***************
                lda #<SND_TONE_G1_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_G1_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune


                jsr SoundTick

            ;2/12
            ;*************** sound to AY1_2 (SND_TONE_D4) ***************
                lda #<SND_TONE_D4
                sta TUNE_PTR_LO
                lda #>SND_TONE_D4
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G2_CHB) ***************
                lda #<SND_TONE_G2_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_G2_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
                ;*************** sound to AY1_2 (SND_TONE_G1_CHC) ***************
                lda #<SND_TONE_G1_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_G1_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

                jsr SoundTick

            ;3/12
            ;*************** sound to AY1_2 (SND_TONE_G4) ***************
                lda #<SND_TONE_G4
                sta TUNE_PTR_LO
                lda #>SND_TONE_G4
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G2_CHB) ***************
                lda #<SND_TONE_G2_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_G2_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
                ;*************** sound to AY1_2 (SND_TONE_G1_CHC) ***************
                lda #<SND_TONE_G1_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_G1_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

                jsr SoundTick

            ;4/12
            ;*************** sound to AY1_2 (SND_TONE_D4) ***************
                lda #<SND_TONE_D4
                sta TUNE_PTR_LO
                lda #>SND_TONE_D4
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G2_CHB) ***************
                lda #<SND_TONE_G2_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_G2_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G1_CHC_OFF) ***************
                lda #<SND_TONE_G1_CHC_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_G1_CHC_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

                jsr SoundTick

            ;5/12
            ;*************** sound to AY1_2 (SND_TONE_G4) ***************
                lda #<SND_TONE_G4
                sta TUNE_PTR_LO
                lda #>SND_TONE_G4
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G2_CHB) ***************
                lda #<SND_TONE_G2_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_G2_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
                ;*************** sound to AY1_2 (SND_TONE_G1_CHC) ***************
                lda #<SND_TONE_G1_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_G1_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

                jsr SoundTick

            ;6/12
            ;*************** sound to AY1_2 (SND_TONE_D4) ***************
                lda #<SND_TONE_D4
                sta TUNE_PTR_LO
                lda #>SND_TONE_D4
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G2_CHB) ***************
                lda #<SND_TONE_G2_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_G2_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G1_CHC_OFF) ***************
                lda #<SND_TONE_G1_CHC_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_G1_CHC_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

                jsr SoundTick

            lda PlaySong_MeasureLoop
            cmp #$01
            beq Measure6_top
            lda #01
            sta PlaySong_MeasureLoop
            jmp Measure5

        Measure6_top:
            ;play twice
            lda #0
            sta PlaySong_MeasureLoop
        Measure6:
    

            ;1/12
            ;*************** sound to AY1_2 (SND_TONE_F4S) ***************
                lda #<SND_TONE_F4S
                sta TUNE_PTR_LO
                lda #>SND_TONE_F4S
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_A2S_CHB) ***************
                lda #<SND_TONE_A2S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A2S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_A1S_CHC) ***************
                lda #<SND_TONE_A1S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_A1S_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune


                jsr SoundTick

            ;2/12
            ;*************** sound to AY1_2 (SND_TONE_C4S) ***************
                lda #<SND_TONE_C4S
                sta TUNE_PTR_LO
                lda #>SND_TONE_C4S
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_A2S_CHB) ***************
                lda #<SND_TONE_A2S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A2S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
                ;*************** sound to AY1_2 (SND_TONE_A1S_CHC) ***************
                lda #<SND_TONE_A1S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_A1S_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

                jsr SoundTick

            ;3/12
            ;*************** sound to AY1_2 (SND_TONE_F4S) ***************
                lda #<SND_TONE_F4S
                sta TUNE_PTR_LO
                lda #>SND_TONE_F4S
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_A2S_CHB) ***************
                lda #<SND_TONE_A2S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A2S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
                ;*************** sound to AY1_2 (SND_TONE_A1S_CHC) ***************
                lda #<SND_TONE_A1S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_A1S_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

                jsr SoundTick

            ;4/12
            ;*************** sound to AY1_2 (SND_TONE_C4S) ***************
                lda #<SND_TONE_C4S
                sta TUNE_PTR_LO
                lda #>SND_TONE_C4S
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_A2S_CHB) ***************
                lda #<SND_TONE_A2S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A2S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_A1S_CHC_OFF) ***************
                lda #<SND_TONE_A1S_CHC_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A1S_CHC_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

                jsr SoundTick

            ;5/12
            ;*************** sound to AY1_2 (SND_TONE_F4S) ***************
                lda #<SND_TONE_F4S
                sta TUNE_PTR_LO
                lda #>SND_TONE_F4S
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_A2S_CHB) ***************
                lda #<SND_TONE_A2S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A2S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
                ;*************** sound to AY1_2 (SND_TONE_A1S_CHC) ***************
                lda #<SND_TONE_A1S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_A1S_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

                jsr SoundTick

            ;6/12
            ;*************** sound to AY1_2 (SND_TONE_C4S) ***************
                lda #<SND_TONE_C4S
                sta TUNE_PTR_LO
                lda #>SND_TONE_C4S
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_A2S_CHB) ***************
                lda #<SND_TONE_A2S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A2S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_A1S_CHC_OFF) ***************
                lda #<SND_TONE_A1S_CHC_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A1S_CHC_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

                jsr SoundTick

            lda PlaySong_MeasureLoop
            cmp #$01
            beq Measure7_top
            lda #01
            sta PlaySong_MeasureLoop
            jmp Measure6

        Measure7_top:
            ;play twice
            lda #0
            sta PlaySong_MeasureLoop
        Measure7:


            ;1/12
            ;*************** sound to AY1_2 (SND_TONE_G4) ***************
                lda #<SND_TONE_G4
                sta TUNE_PTR_LO
                lda #>SND_TONE_G4
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_D3S_CHB) ***************
                lda #<SND_TONE_D3S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_D3S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_D2S_CHC) ***************
                lda #<SND_TONE_D2S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_D2S_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune


                jsr SoundTick

            ;2/12
            ;*************** sound to AY1_2 (SND_TONE_A3S) ***************
                lda #<SND_TONE_A3S
                sta TUNE_PTR_LO
                lda #>SND_TONE_A3S
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_D3S_CHB) ***************
                lda #<SND_TONE_D3S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_D3S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
                ;*************** sound to AY1_2 (SND_TONE_D2S_CHC) ***************
                lda #<SND_TONE_D2S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_D2S_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

                jsr SoundTick

            ;3/12
            ;*************** sound to AY1_2 (SND_TONE_G4) ***************
                lda #<SND_TONE_G4
                sta TUNE_PTR_LO
                lda #>SND_TONE_G4
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_D3S_CHB) ***************
                lda #<SND_TONE_D3S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_D3S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
                ;*************** sound to AY1_2 (SND_TONE_D2S_CHC) ***************
                lda #<SND_TONE_D2S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_D2S_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

                jsr SoundTick

            ;4/12
            ;*************** sound to AY1_2 (SND_TONE_A3S) ***************
                lda #<SND_TONE_A3S
                sta TUNE_PTR_LO
                lda #>SND_TONE_A3S
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_D3S_CHB) ***************
                lda #<SND_TONE_D3S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_D3S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_D2S_CHC_OFF) ***************
                lda #<SND_TONE_D2S_CHC_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_D2S_CHC_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

                jsr SoundTick

            ;5/12
            ;*************** sound to AY1_2 (SND_TONE_G4) ***************
                lda #<SND_TONE_G4
                sta TUNE_PTR_LO
                lda #>SND_TONE_G4
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_D3S_CHB) ***************
                lda #<SND_TONE_D3S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_D3S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
                ;*************** sound to AY1_2 (SND_TONE_D2S_CHC) ***************
                lda #<SND_TONE_D2S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_D2S_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

                jsr SoundTick

            ;6/12
            ;*************** sound to AY1_2 (SND_TONE_A3S) ***************
                lda #<SND_TONE_A3S
                sta TUNE_PTR_LO
                lda #>SND_TONE_A3S
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_D3S_CHB) ***************
                lda #<SND_TONE_D3S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_D3S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_D2S_CHC_OFF) ***************
                lda #<SND_TONE_D2S_CHC_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_D2S_CHC_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

                jsr SoundTick

            lda PlaySong_MeasureLoop
            jsr print_hex_lcd
            cmp #$01
            beq Measure8_top
            lda #01
            sta PlaySong_MeasureLoop
            jmp Measure7

        Measure8_top:
            ;play twice
            lda #0
            sta PlaySong_MeasureLoop
        Measure8:

            ;1/12
            ;*************** sound to AY1_2 (SND_TONE_F4S) ***************
                lda #<SND_TONE_F4S
                sta TUNE_PTR_LO
                lda #>SND_TONE_F4S
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_A4) ***************
                lda #<SND_TONE_A4
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune                
            ;*************** sound to AY1_2 (SND_TONE_B2_CHB) ***************
                lda #<SND_TONE_B2_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_B2_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_B1_CHC) ***************
                lda #<SND_TONE_B1_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_B1_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune


                jsr SoundTick

            ;2/12
            ;*************** sound to AY1_2 (SND_TONE_B3) ***************
                lda #<SND_TONE_B3
                sta TUNE_PTR_LO
                lda #>SND_TONE_B3
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
             ;*************** sound to AY3_4 (SND_TONE_A4_OFF) ***************
                lda #<SND_TONE_A4_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune 
            ;*************** sound to AY1_2 (SND_TONE_B2_CHB) ***************
                lda #<SND_TONE_B2_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_B2_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
                ;*************** sound to AY1_2 (SND_TONE_B1_CHC) ***************
                lda #<SND_TONE_B1_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_B1_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

                jsr SoundTick

            ;3/12
            ;*************** sound to AY1_2 (SND_TONE_F4S) ***************
                lda #<SND_TONE_F4S
                sta TUNE_PTR_LO
                lda #>SND_TONE_F4S
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_A4) ***************
                lda #<SND_TONE_A4
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune 
            ;*************** sound to AY1_2 (SND_TONE_B2_CHB) ***************
                lda #<SND_TONE_B2_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_B2_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
                ;*************** sound to AY1_2 (SND_TONE_B1_CHC) ***************
                lda #<SND_TONE_B1_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_B1_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

                jsr SoundTick

            ;4/12
            ;*************** sound to AY1_2 (SND_TONE_B3) ***************
                lda #<SND_TONE_B3
                sta TUNE_PTR_LO
                lda #>SND_TONE_B3
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_A4_OFF) ***************
                lda #<SND_TONE_A4_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune 
            ;*************** sound to AY1_2 (SND_TONE_B2_CHB) ***************
                lda #<SND_TONE_B2_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_B2_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_B1_CHC_OFF) ***************
                lda #<SND_TONE_B1_CHC_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_B1_CHC_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

                jsr SoundTick

            ;5/12
            ;*************** sound to AY1_2 (SND_TONE_F4S) ***************
                lda #<SND_TONE_F4S
                sta TUNE_PTR_LO
                lda #>SND_TONE_F4S
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_A4) ***************
                lda #<SND_TONE_A4
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune 
            ;*************** sound to AY1_2 (SND_TONE_B2_CHB) ***************
                lda #<SND_TONE_B2_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_B2_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
                ;*************** sound to AY1_2 (SND_TONE_B1_CHC) ***************
                lda #<SND_TONE_B1_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_B1_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

                jsr SoundTick

            ;6/12
            ;*************** sound to AY1_2 (SND_TONE_B3) ***************
                lda #<SND_TONE_B3
                sta TUNE_PTR_LO
                lda #>SND_TONE_B3
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_A4_OFF) ***************
                lda #<SND_TONE_A4_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune 
            ;*************** sound to AY1_2 (SND_TONE_B2_CHB) ***************
                lda #<SND_TONE_B2_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_B2_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_B1_CHC_OFF) ***************
                lda #<SND_TONE_B1_CHC_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_B1_CHC_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

                jsr SoundTick

            lda PlaySong_MeasureLoop
            jsr print_hex_lcd
            cmp #$01
            beq Measure9_top
            lda #01
            sta PlaySong_MeasureLoop
            jmp Measure8

        Measure9_top:
            ;play twice
            lda #0
            sta PlaySong_MeasureLoop
        Measure9:
    
            ;*************** sound to AY1_2_3_4 (SND_RESET) ***************
                lda #<SND_RESET
                sta TUNE_PTR_LO
                lda #>SND_RESET
                sta TUNE_PTR_HI

                jsr AY1_PlayTune
                jsr AY2_PlayTune
                jsr AY3_PlayTune
                jsr AY4_PlayTune

            ;1/12
            ;*************** sound to AY1_2 (SND_TONE_G4) ***************
                lda #<SND_TONE_G4
                sta TUNE_PTR_LO
                lda #>SND_TONE_G4
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G2_CHB) ***************
                lda #<SND_TONE_G2_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_G2_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G1_CHC) ***************
                lda #<SND_TONE_G1_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_G1_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune


                jsr SoundTick

            ;2/12
            ;*************** sound to AY1_2 (SND_TONE_D4) ***************
                lda #<SND_TONE_D4
                sta TUNE_PTR_LO
                lda #>SND_TONE_D4
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G2_CHB) ***************
                lda #<SND_TONE_G2_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_G2_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
                ;*************** sound to AY1_2 (SND_TONE_G1_CHC) ***************
                lda #<SND_TONE_G1_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_G1_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

                jsr SoundTick

            ;3/12
            ;*************** sound to AY1_2 (SND_TONE_G4) ***************
                lda #<SND_TONE_G4
                sta TUNE_PTR_LO
                lda #>SND_TONE_G4
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G2_CHB) ***************
                lda #<SND_TONE_G2_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_G2_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
                ;*************** sound to AY1_2 (SND_TONE_G1_CHC) ***************
                lda #<SND_TONE_G1_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_G1_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

                jsr SoundTick

            ;4/12
            ;*************** sound to AY1_2 (SND_TONE_D4) ***************
                lda #<SND_TONE_D4
                sta TUNE_PTR_LO
                lda #>SND_TONE_D4
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G2_CHB) ***************
                lda #<SND_TONE_G2_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_G2_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G1_CHC_OFF) ***************
                lda #<SND_TONE_G1_CHC_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_G1_CHC_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

                jsr SoundTick

            ;5/12
            ;*************** sound to AY1_2 (SND_TONE_G4) ***************
                lda #<SND_TONE_G4
                sta TUNE_PTR_LO
                lda #>SND_TONE_G4
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G2_CHB) ***************
                lda #<SND_TONE_G2_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_G2_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
                ;*************** sound to AY1_2 (SND_TONE_G1_CHC) ***************
                lda #<SND_TONE_G1_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_G1_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

                jsr SoundTick

            ;6/12
            ;*************** sound to AY1_2 (SND_TONE_D4) ***************
                lda #<SND_TONE_D4
                sta TUNE_PTR_LO
                lda #>SND_TONE_D4
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G2_CHB) ***************
                lda #<SND_TONE_G2_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_G2_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G1_CHC_OFF) ***************
                lda #<SND_TONE_G1_CHC_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_G1_CHC_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

                jsr SoundTick

            lda PlaySong_MeasureLoop
            cmp #$01
            beq Measure10_top
            lda #01
            sta PlaySong_MeasureLoop
            jmp Measure9

        Measure10_top:
            ;play twice
            lda #0
            sta PlaySong_MeasureLoop
        Measure10:
    

            ;1/12
            ;*************** sound to AY1_2 (SND_TONE_F4S) ***************
                lda #<SND_TONE_F4S
                sta TUNE_PTR_LO
                lda #>SND_TONE_F4S
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_A2S_CHB) ***************
                lda #<SND_TONE_A2S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A2S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_A1S_CHC) ***************
                lda #<SND_TONE_A1S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_A1S_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune


                jsr SoundTick

            ;2/12
            ;*************** sound to AY1_2 (SND_TONE_C4S) ***************
                lda #<SND_TONE_C4S
                sta TUNE_PTR_LO
                lda #>SND_TONE_C4S
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_A2S_CHB) ***************
                lda #<SND_TONE_A2S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A2S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
                ;*************** sound to AY1_2 (SND_TONE_A1S_CHC) ***************
                lda #<SND_TONE_A1S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_A1S_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

                jsr SoundTick

            ;3/12
            ;*************** sound to AY1_2 (SND_TONE_F4S) ***************
                lda #<SND_TONE_F4S
                sta TUNE_PTR_LO
                lda #>SND_TONE_F4S
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_A2S_CHB) ***************
                lda #<SND_TONE_A2S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A2S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
                ;*************** sound to AY1_2 (SND_TONE_A1S_CHC) ***************
                lda #<SND_TONE_A1S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_A1S_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

                jsr SoundTick

            ;4/12
            ;*************** sound to AY1_2 (SND_TONE_C4S) ***************
                lda #<SND_TONE_C4S
                sta TUNE_PTR_LO
                lda #>SND_TONE_C4S
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_A2S_CHB) ***************
                lda #<SND_TONE_A2S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A2S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_A1S_CHC_OFF) ***************
                lda #<SND_TONE_A1S_CHC_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A1S_CHC_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

                jsr SoundTick

            ;5/12
            ;*************** sound to AY1_2 (SND_TONE_F4S) ***************
                lda #<SND_TONE_F4S
                sta TUNE_PTR_LO
                lda #>SND_TONE_F4S
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_A2S_CHB) ***************
                lda #<SND_TONE_A2S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A2S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
                ;*************** sound to AY1_2 (SND_TONE_A1S_CHC) ***************
                lda #<SND_TONE_A1S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_A1S_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

                jsr SoundTick

            ;6/12
            ;*************** sound to AY1_2 (SND_TONE_C4S) ***************
                lda #<SND_TONE_C4S
                sta TUNE_PTR_LO
                lda #>SND_TONE_C4S
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_A2S_CHB) ***************
                lda #<SND_TONE_A2S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A2S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_A1S_CHC_OFF) ***************
                lda #<SND_TONE_A1S_CHC_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A1S_CHC_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

                jsr SoundTick

            lda PlaySong_MeasureLoop
            cmp #$01
            beq Measure11_top
            lda #01
            sta PlaySong_MeasureLoop
            jmp Measure10

        Measure11_top:
            ;play twice
            lda #0
            sta PlaySong_MeasureLoop
        Measure11:


            ;1/12
            ;*************** sound to AY1_2 (SND_TONE_G4) ***************
                lda #<SND_TONE_G4
                sta TUNE_PTR_LO
                lda #>SND_TONE_G4
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_D3S_CHB) ***************
                lda #<SND_TONE_D3S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_D3S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_D2S_CHC) ***************
                lda #<SND_TONE_D2S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_D2S_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune


                jsr SoundTick

            ;2/12
            ;*************** sound to AY1_2 (SND_TONE_A3S) ***************
                lda #<SND_TONE_A3S
                sta TUNE_PTR_LO
                lda #>SND_TONE_A3S
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_D3S_CHB) ***************
                lda #<SND_TONE_D3S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_D3S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
                ;*************** sound to AY1_2 (SND_TONE_D2S_CHC) ***************
                lda #<SND_TONE_D2S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_D2S_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

                jsr SoundTick

            ;3/12
            ;*************** sound to AY1_2 (SND_TONE_G4) ***************
                lda #<SND_TONE_G4
                sta TUNE_PTR_LO
                lda #>SND_TONE_G4
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_D3S_CHB) ***************
                lda #<SND_TONE_D3S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_D3S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
                ;*************** sound to AY1_2 (SND_TONE_D2S_CHC) ***************
                lda #<SND_TONE_D2S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_D2S_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

                jsr SoundTick

            ;4/12
            ;*************** sound to AY1_2 (SND_TONE_A3S) ***************
                lda #<SND_TONE_A3S
                sta TUNE_PTR_LO
                lda #>SND_TONE_A3S
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_D3S_CHB) ***************
                lda #<SND_TONE_D3S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_D3S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_D2S_CHC_OFF) ***************
                lda #<SND_TONE_D2S_CHC_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_D2S_CHC_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

                jsr SoundTick

            ;5/12
            ;*************** sound to AY1_2 (SND_TONE_G4) ***************
                lda #<SND_TONE_G4
                sta TUNE_PTR_LO
                lda #>SND_TONE_G4
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_D3S_CHB) ***************
                lda #<SND_TONE_D3S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_D3S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
                ;*************** sound to AY1_2 (SND_TONE_D2S_CHC) ***************
                lda #<SND_TONE_D2S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_D2S_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

                jsr SoundTick

            ;6/12
            ;*************** sound to AY1_2 (SND_TONE_A3S) ***************
                lda #<SND_TONE_A3S
                sta TUNE_PTR_LO
                lda #>SND_TONE_A3S
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_D3S_CHB) ***************
                lda #<SND_TONE_D3S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_D3S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_D2S_CHC_OFF) ***************
                lda #<SND_TONE_D2S_CHC_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_D2S_CHC_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

                jsr SoundTick

            lda PlaySong_MeasureLoop
            jsr print_hex_lcd
            cmp #$01
            beq Measure12_top
            lda #01
            sta PlaySong_MeasureLoop
            jmp Measure11

        Measure12_top:
            ;play twice
            lda #0
            sta PlaySong_MeasureLoop
        Measure12:

            ;1/12
            ;*************** sound to AY1_2 (SND_TONE_F4S) ***************
                lda #<SND_TONE_F4S
                sta TUNE_PTR_LO
                lda #>SND_TONE_F4S
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_A4) ***************
                lda #<SND_TONE_A4
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune                
            ;*************** sound to AY1_2 (SND_TONE_B2_CHB) ***************
                lda #<SND_TONE_B2_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_B2_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_B1_CHC) ***************
                lda #<SND_TONE_B1_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_B1_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune


                jsr SoundTick

            ;2/12
            ;*************** sound to AY1_2 (SND_TONE_B3) ***************
                lda #<SND_TONE_B3
                sta TUNE_PTR_LO
                lda #>SND_TONE_B3
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
             ;*************** sound to AY3_4 (SND_TONE_A4_OFF) ***************
                lda #<SND_TONE_A4_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune 
            ;*************** sound to AY1_2 (SND_TONE_B2_CHB) ***************
                lda #<SND_TONE_B2_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_B2_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
                ;*************** sound to AY1_2 (SND_TONE_B1_CHC) ***************
                lda #<SND_TONE_B1_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_B1_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

                jsr SoundTick

            ;3/12
            ;*************** sound to AY1_2 (SND_TONE_F4S) ***************
                lda #<SND_TONE_F4S
                sta TUNE_PTR_LO
                lda #>SND_TONE_F4S
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_A4) ***************
                lda #<SND_TONE_A4
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune 
            ;*************** sound to AY1_2 (SND_TONE_B2_CHB) ***************
                lda #<SND_TONE_B2_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_B2_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
                ;*************** sound to AY1_2 (SND_TONE_B1_CHC) ***************
                lda #<SND_TONE_B1_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_B1_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

                jsr SoundTick

            ;4/12
            ;*************** sound to AY1_2 (SND_TONE_B3) ***************
                lda #<SND_TONE_B3
                sta TUNE_PTR_LO
                lda #>SND_TONE_B3
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_A4_OFF) ***************
                lda #<SND_TONE_A4_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune 
            ;*************** sound to AY1_2 (SND_TONE_B2_CHB) ***************
                lda #<SND_TONE_B2_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_B2_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_B1_CHC_OFF) ***************
                lda #<SND_TONE_B1_CHC_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_B1_CHC_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

                jsr SoundTick

            ;5/12
            ;*************** sound to AY1_2 (SND_TONE_F4S) ***************
                lda #<SND_TONE_F4S
                sta TUNE_PTR_LO
                lda #>SND_TONE_F4S
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_A4) ***************
                lda #<SND_TONE_A4
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune 
            ;*************** sound to AY1_2 (SND_TONE_B2_CHB) ***************
                lda #<SND_TONE_B2_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_B2_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
                ;*************** sound to AY1_2 (SND_TONE_B1_CHC) ***************
                lda #<SND_TONE_B1_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_B1_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

                jsr SoundTick

            ;6/12
            ;*************** sound to AY1_2 (SND_TONE_B3) ***************
                lda #<SND_TONE_B3
                sta TUNE_PTR_LO
                lda #>SND_TONE_B3
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_A4_OFF) ***************
                lda #<SND_TONE_A4_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune 
            ;*************** sound to AY1_2 (SND_TONE_B2_CHB) ***************
                lda #<SND_TONE_B2_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_B2_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_B1_CHC_OFF) ***************
                lda #<SND_TONE_B1_CHC_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_B1_CHC_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

                jsr SoundTick

            lda PlaySong_MeasureLoop
            jsr print_hex_lcd
            cmp #$01
            beq Measure13_top
            lda #01
            sta PlaySong_MeasureLoop
            jmp Measure12

        Measure13_top:
            ;play twice
            lda #0
            sta PlaySong_MeasureLoop
        Measure13:

            ;1/12
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_G4) ***************
                lda #<SND_TONE_G4
                sta TUNE_PTR_LO
                lda #>SND_TONE_G4
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY1_2 (SND_TONE_D4) ***************
                lda #<SND_TONE_D4
                sta TUNE_PTR_LO
                lda #>SND_TONE_D4
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune                 
            ;*************** sound to AY3_4 (SND_TONE_G2_CHB) ***************
                lda #<SND_TONE_G2_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_G2_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G1_CHC) ***************
                lda #<SND_TONE_G1_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_G1_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune


                jsr SoundTickHalf

            ;1/12 break
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_G4_OFF) ***************
                lda #<SND_TONE_G4_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_G4_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY1_2 (SND_TONE_D4_OFF) ***************
                lda #<SND_TONE_D4_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_D4_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune                 
            ;*************** sound to AY3_4 (SND_TONE_G2_CHB) ***************
                lda #<SND_TONE_G2_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_G2_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G1_CHC) ***************
                lda #<SND_TONE_G1_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_G1_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune


                jsr SoundTickHalf

            ;2/12
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_G2_CHB) ***************
                lda #<SND_TONE_G2_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_G2_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G1_CHC) ***************
                lda #<SND_TONE_G1_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_G1_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune


                jsr SoundTickHalf

            ;2/12 break
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_G2_CHB) ***************
                lda #<SND_TONE_G2_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_G2_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G1_CHC) ***************
                lda #<SND_TONE_G1_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_G1_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune


                jsr SoundTickHalf

            ;3/12
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_G2_CHB) ***************
                lda #<SND_TONE_G2_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_G2_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G1_CHC) ***************
                lda #<SND_TONE_G1_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_G1_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune


                jsr SoundTickHalf

            ;3/12 break
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_G2_CHB_OFF) ***************
                lda #<SND_TONE_G2_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_G2_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G1_CHC_OFF) ***************
                lda #<SND_TONE_G1_CHC_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_G1_CHC_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune


                jsr SoundTickHalf

            ;4/12
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_G4) ***************
                lda #<SND_TONE_G4
                sta TUNE_PTR_LO
                lda #>SND_TONE_G4
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY1_2 (SND_TONE_D4) ***************
                lda #<SND_TONE_D4
                sta TUNE_PTR_LO
                lda #>SND_TONE_D4
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune                 
            ;*************** sound to AY3_4 (SND_TONE_G2_CHB) ***************
                lda #<SND_TONE_G2_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_G2_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G1_CHC) ***************
                lda #<SND_TONE_G1_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_G1_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune


                jsr SoundTickHalf

            ;4/12 break
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_G4_OFF) ***************
                lda #<SND_TONE_G4_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_G4_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY1_2 (SND_TONE_D4_OFF) ***************
                lda #<SND_TONE_D4_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_D4_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune                 
            ;*************** sound to AY3_4 (SND_TONE_G2_CHB_OFF) ***************
                lda #<SND_TONE_G2_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_G2_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G1_CHC_OFF) ***************
                lda #<SND_TONE_G1_CHC_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_G1_CHC_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune


                jsr SoundTickHalf

            ;5/12
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_G2_CHB) ***************
                lda #<SND_TONE_G2_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_G2_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G1_CHC) ***************
                lda #<SND_TONE_G1_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_G1_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune


                jsr SoundTickHalf

            ;5/12 break
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_G2_CHB) ***************
                lda #<SND_TONE_G2_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_G2_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G1_CHC) ***************
                lda #<SND_TONE_G1_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_G1_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune


                jsr SoundTickHalf

            ;6/12
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_G2_CHB) ***************
                lda #<SND_TONE_G2_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_G2_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G1_CHC) ***************
                lda #<SND_TONE_G1_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_G1_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune


                jsr SoundTickHalf

            ;6/12 break
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_G4_OFF) ***************
                lda #<SND_TONE_G4_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_G4_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY1_2 (SND_TONE_D4_OFF) ***************
                lda #<SND_TONE_D4_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_D4_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune                 
            ;*************** sound to AY3_4 (SND_TONE_G2_CHB_OFF) ***************
                lda #<SND_TONE_G2_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_G2_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G1_CHC_OFF) ***************
                lda #<SND_TONE_G1_CHC_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_G1_CHC_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune


                jsr SoundTickHalf

            ;7/12
            ;*************** sound to AY1_2 (SND_TONE_A4_CHB) ***************
                lda #<SND_TONE_A4_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_G4) ***************
                lda #<SND_TONE_G4
                sta TUNE_PTR_LO
                lda #>SND_TONE_G4
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY1_2 (SND_TONE_D4) ***************
                lda #<SND_TONE_D4
                sta TUNE_PTR_LO
                lda #>SND_TONE_D4
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune                 
            ;*************** sound to AY3_4 (SND_TONE_G2_CHB) ***************
                lda #<SND_TONE_G2_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_G2_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G1_CHC) ***************
                lda #<SND_TONE_G1_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_G1_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune


                jsr SoundTickHalf

            ;7/12 break
            ;*************** sound to AY1_2 (SND_TONE_A4_CHB_OFF) ***************
                lda #<SND_TONE_A4_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_G4_OFF) ***************
                lda #<SND_TONE_G4_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_G4_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY1_2 (SND_TONE_D4_OFF) ***************
                lda #<SND_TONE_D4_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_D4_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune                 
            ;*************** sound to AY3_4 (SND_TONE_G2_CHB) ***************
                lda #<SND_TONE_G2_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_G2_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G1_CHC) ***************
                lda #<SND_TONE_G1_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_G1_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune


                jsr SoundTickHalf

            ;8/12
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_G2_CHB) ***************
                lda #<SND_TONE_G2_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_G2_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G1_CHC) ***************
                lda #<SND_TONE_G1_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_G1_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune


                jsr SoundTickHalf

            ;8/12 break
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_G2_CHB) ***************
                lda #<SND_TONE_G2_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_G2_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G1_CHC) ***************
                lda #<SND_TONE_G1_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_G1_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune


                jsr SoundTickHalf

            ;9/12
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_G4) ***************
                lda #<SND_TONE_G4
                sta TUNE_PTR_LO
                lda #>SND_TONE_G4
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY1_2 (SND_TONE_D4) ***************
                lda #<SND_TONE_D4
                sta TUNE_PTR_LO
                lda #>SND_TONE_D4
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune                 
            ;*************** sound to AY3_4 (SND_TONE_G2_CHB) ***************
                lda #<SND_TONE_G2_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_G2_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G1_CHC) ***************
                lda #<SND_TONE_G1_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_G1_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune


                jsr SoundTickHalf

            ;9/12 break
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_G4_OFF) ***************
                lda #<SND_TONE_G4_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_G4_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY1_2 (SND_TONE_D4_OFF) ***************
                lda #<SND_TONE_D4_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_D4_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune                 
            ;*************** sound to AY3_4 (SND_TONE_G2_CHB_OFF) ***************
                lda #<SND_TONE_G2_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_G2_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G1_CHC_OFF) ***************
                lda #<SND_TONE_G1_CHC_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_G1_CHC_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune


                jsr SoundTickHalf

            ;10/12
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_G2_CHB) ***************
                lda #<SND_TONE_G2_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_G2_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G1_CHC) ***************
                lda #<SND_TONE_G1_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_G1_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune


                jsr SoundTickHalf

            ;10/12 break
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_G2_CHB_OFF) ***************
                lda #<SND_TONE_G2_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_G2_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G1_CHC_OFF) ***************
                lda #<SND_TONE_G1_CHC_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_G1_CHC_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune


                jsr SoundTickHalf

            ;11/12
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_G4) ***************
                lda #<SND_TONE_G4
                sta TUNE_PTR_LO
                lda #>SND_TONE_G4
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY1_2 (SND_TONE_D4) ***************
                lda #<SND_TONE_D4
                sta TUNE_PTR_LO
                lda #>SND_TONE_D4
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune                 
            ;*************** sound to AY3_4 (SND_TONE_G2_CHB) ***************
                lda #<SND_TONE_G2_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_G2_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G1_CHC) ***************
                lda #<SND_TONE_G1_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_G1_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune


                jsr SoundTickHalf

            ;11/12 break
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_G4_OFF) ***************
                lda #<SND_TONE_G4_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_G4_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY1_2 (SND_TONE_D4_OFF) ***************
                lda #<SND_TONE_D4_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_D4_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune                 
            ;*************** sound to AY3_4 (SND_TONE_G2_CHB) ***************
                lda #<SND_TONE_G2_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_G2_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G1_CHC) ***************
                lda #<SND_TONE_G1_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_G1_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune


                jsr SoundTickHalf

            ;12/12
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_G2_CHB) ***************
                lda #<SND_TONE_G2_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_G2_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G1_CHC) ***************
                lda #<SND_TONE_G1_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_G1_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune


                jsr SoundTickHalf

            ;12/12 break
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_G4_OFF) ***************
                lda #<SND_TONE_G4_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_G4_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY1_2 (SND_TONE_D4_OFF) ***************
                lda #<SND_TONE_D4_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_D4_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune                 
            ;*************** sound to AY3_4 (SND_TONE_G2_CHB_OFF) ***************
                lda #<SND_TONE_G2_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_G2_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G1_CHC_OFF) ***************
                lda #<SND_TONE_G1_CHC_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_G1_CHC_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune


                jsr SoundTickHalf

        Measure14_top:
            ;play twice
            lda #0
            sta PlaySong_MeasureLoop
        Measure14:
            ;1/12
            ;*************** sound to AY1_2 (SND_TONE_A4_CHB) ***************
                lda #<SND_TONE_A4_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_F4S) ***************
                lda #<SND_TONE_F4S
                sta TUNE_PTR_LO
                lda #>SND_TONE_F4S
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY1_2 (SND_TONE_C4S) ***************
                lda #<SND_TONE_C4S
                sta TUNE_PTR_LO
                lda #>SND_TONE_C4S
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune                 
            ;*************** sound to AY3_4 (SND_TONE_A2S_CHB) ***************
                lda #<SND_TONE_A2S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A2S_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_A1S_CHC) ***************
                lda #<SND_TONE_A1S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_A1S_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune


                jsr SoundTickHalf

            ;1/12 break
            ;*************** sound to AY1_2 (SND_TONE_A4_CHB_OFF) ***************
                lda #<SND_TONE_A4_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_F4S_OFF) ***************
                lda #<SND_TONE_F4S_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_F4S_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY1_2 (SND_TONE_C4S_OFF) ***************
                lda #<SND_TONE_C4S_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_C4S_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune                 
            ;*************** sound to AY3_4 (SND_TONE_A2S_CHB) ***************
                lda #<SND_TONE_A2S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A2S_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_A1S_CHC) ***************
                lda #<SND_TONE_A1S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_A1S_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune


                jsr SoundTickHalf

            ;2/12
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_A2S_CHB) ***************
                lda #<SND_TONE_A2S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A2S_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_A1S_CHC) ***************
                lda #<SND_TONE_A1S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_A1S_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune


                jsr SoundTickHalf

            ;2/12 break
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_A2S_CHB) ***************
                lda #<SND_TONE_A2S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A2S_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_A1S_CHC) ***************
                lda #<SND_TONE_A1S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_A1S_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune


                jsr SoundTickHalf

            ;3/12
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_A2S_CHB) ***************
                lda #<SND_TONE_A2S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A2S_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_A1S_CHC) ***************
                lda #<SND_TONE_A1S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_A1S_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune


                jsr SoundTickHalf

            ;3/12 break
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_A2S_CHB_OFF) ***************
                lda #<SND_TONE_A2S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A2S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_A1S_CHC_OFF) ***************
                lda #<SND_TONE_A1S_CHC_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A1S_CHC_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune


                jsr SoundTickHalf

            ;4/12
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_F4S) ***************
                lda #<SND_TONE_F4S
                sta TUNE_PTR_LO
                lda #>SND_TONE_F4S
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY1_2 (SND_TONE_C4S) ***************
                lda #<SND_TONE_C4S
                sta TUNE_PTR_LO
                lda #>SND_TONE_C4S
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune                 
            ;*************** sound to AY3_4 (SND_TONE_A2S_CHB) ***************
                lda #<SND_TONE_A2S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A2S_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_A1S_CHC) ***************
                lda #<SND_TONE_A1S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_A1S_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune


                jsr SoundTickHalf

            ;4/12 break
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_F4S_OFF) ***************
                lda #<SND_TONE_F4S_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_F4S_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY1_2 (SND_TONE_C4S_OFF) ***************
                lda #<SND_TONE_C4S_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_C4S
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune                 
            ;*************** sound to AY3_4 (SND_TONE_A2S_CHB_OFF) ***************
                lda #<SND_TONE_A2S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A2S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_A1S_CHC_OFF) ***************
                lda #<SND_TONE_A1S_CHC_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A1S_CHC_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune


                jsr SoundTickHalf

            ;5/12
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_A2S_CHB) ***************
                lda #<SND_TONE_A2S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A2S_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_A1S_CHC) ***************
                lda #<SND_TONE_A1S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_A1S_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune


                jsr SoundTickHalf

            ;5/12 break
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_A2S_CHB) ***************
                lda #<SND_TONE_A2S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A2S_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_A1S_CHC) ***************
                lda #<SND_TONE_A1S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_A1S_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune


                jsr SoundTickHalf

            ;6/12
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_A2S_CHB) ***************
                lda #<SND_TONE_A2S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A2S_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_A1S_CHC) ***************
                lda #<SND_TONE_A1S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_A1S_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune


                jsr SoundTickHalf

            ;6/12 break
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_A2S_CHB_OFF) ***************
                lda #<SND_TONE_A2S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A2S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_A1S_CHC_OFF) ***************
                lda #<SND_TONE_A1S_CHC_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A1S_CHC_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune


                jsr SoundTickHalf

            ;7/12
            ;*************** sound to AY1_2 (SND_TONE_A4_CHB) ***************
                lda #<SND_TONE_A4_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_F4S) ***************
                lda #<SND_TONE_F4S
                sta TUNE_PTR_LO
                lda #>SND_TONE_F4S
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY1_2 (SND_TONE_C4S) ***************
                lda #<SND_TONE_C4S
                sta TUNE_PTR_LO
                lda #>SND_TONE_C4S
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune                 
            ;*************** sound to AY3_4 (SND_TONE_A2S_CHB) ***************
                lda #<SND_TONE_A2S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A2S_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_A1S_CHC) ***************
                lda #<SND_TONE_A1S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_A1S_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune


                jsr SoundTickHalf

            ;7/12 break
            ;*************** sound to AY1_2 (SND_TONE_A4_CHB_OFF) ***************
                lda #<SND_TONE_A4_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_F4S_OFF) ***************
                lda #<SND_TONE_F4S_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_F4S_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY1_2 (SND_TONE_C4S_OFF) ***************
                lda #<SND_TONE_C4S_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_C4S_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune                 
            ;*************** sound to AY3_4 (SND_TONE_A2S_CHB) ***************
                lda #<SND_TONE_A2S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A2S_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_A1S_CHC) ***************
                lda #<SND_TONE_A1S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_A1S_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune


                jsr SoundTickHalf

            ;8/12
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_A2S_CHB) ***************
                lda #<SND_TONE_A2S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A2S_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_A1S_CHC) ***************
                lda #<SND_TONE_A1S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_A1S_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune


                jsr SoundTickHalf

            ;8/12 break
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_A2S_CHB) ***************
                lda #<SND_TONE_A2S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A2S_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_A1S_CHC) ***************
                lda #<SND_TONE_A1S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_A1S_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune


                jsr SoundTickHalf

            ;9/12
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_F4S) ***************
                lda #<SND_TONE_F4S
                sta TUNE_PTR_LO
                lda #>SND_TONE_F4S
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY1_2 (SND_TONE_C4S) ***************
                lda #<SND_TONE_C4S
                sta TUNE_PTR_LO
                lda #>SND_TONE_C4S
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune                 
            ;*************** sound to AY3_4 (SND_TONE_A2S_CHB) ***************
                lda #<SND_TONE_A2S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A2S_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_A1S_CHC) ***************
                lda #<SND_TONE_A1S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_A1S_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune


                jsr SoundTickHalf

            ;9/12 break
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_F4S_OFF) ***************
                lda #<SND_TONE_F4S_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_F4S_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY1_2 (SND_TONE_C4S_OFF) ***************
                lda #<SND_TONE_C4S_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_C4S_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune                 
            ;*************** sound to AY3_4 (SND_TONE_A2S_CHB_OFF) ***************
                lda #<SND_TONE_A2S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A2S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_A1S_CHC_OFF) ***************
                lda #<SND_TONE_A1S_CHC_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A1S_CHC_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune


                jsr SoundTickHalf

            ;10/12
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_A2S_CHB) ***************
                lda #<SND_TONE_A2S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A2S_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_A1S_CHC) ***************
                lda #<SND_TONE_A1S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_A1S_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune


                jsr SoundTickHalf

            ;10/12 break
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_A2S_CHB_OFF) ***************
                lda #<SND_TONE_A2S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A2S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_A1S_CHC_OFF) ***************
                lda #<SND_TONE_A1S_CHC_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A1S_CHC_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune


                jsr SoundTickHalf

            ;11/12
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_F4S) ***************
                lda #<SND_TONE_F4S
                sta TUNE_PTR_LO
                lda #>SND_TONE_F4S
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY1_2 (SND_TONE_C4S) ***************
                lda #<SND_TONE_C4S
                sta TUNE_PTR_LO
                lda #>SND_TONE_C4S
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune                 
            ;*************** sound to AY3_4 (SND_TONE_A2S_CHB) ***************
                lda #<SND_TONE_A2S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A2S_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_A1S_CHC) ***************
                lda #<SND_TONE_A1S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_A1S_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune


                jsr SoundTickHalf

            ;11/12 break
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_F4S_OFF) ***************
                lda #<SND_TONE_F4S_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_F4S_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY1_2 (SND_TONE_C4S_OFF) ***************
                lda #<SND_TONE_C4S_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_C4S_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune                 
            ;*************** sound to AY3_4 (SND_TONE_A2S_CHB) ***************
                lda #<SND_TONE_A2S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A2S_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_A1S_CHC) ***************
                lda #<SND_TONE_A1S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_A1S_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune


                jsr SoundTickHalf

            ;12/12
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_A2S_CHB) ***************
                lda #<SND_TONE_A2S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A2S_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_A1S_CHC) ***************
                lda #<SND_TONE_A1S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_A1S_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune


                jsr SoundTickHalf

            ;12/12 break
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_F4S_OFF) ***************
                lda #<SND_TONE_F4S_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_F4S_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY1_2 (SND_TONE_C4S_OFF) ***************
                lda #<SND_TONE_C4S_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_C4S_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune                 
            ;*************** sound to AY3_4 (SND_TONE_A2S_CHB_OFF) ***************
                lda #<SND_TONE_A2S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A2S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_A1S_CHC_OFF) ***************
                lda #<SND_TONE_A1S_CHC_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A1S_CHC_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune


                jsr SoundTickHalf
    
        Measure15_top:
            ;play twice
            lda #0
            sta PlaySong_MeasureLoop
        Measure15:

            ;1/12
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_G4) ***************
                lda #<SND_TONE_G4
                sta TUNE_PTR_LO
                lda #>SND_TONE_G4
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY1_2 (SND_TONE_D4S) ***************
                lda #<SND_TONE_D4S
                sta TUNE_PTR_LO
                lda #>SND_TONE_D4S
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune                 
            ;*************** sound to AY3_4 (SND_TONE_D3S_CHB) ***************
                lda #<SND_TONE_D3S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_D3S_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_D2S_CHC) ***************
                lda #<SND_TONE_D2S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_D2S_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune


                jsr SoundTickHalf

            ;1/12 break
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_G4_OFF) ***************
                lda #<SND_TONE_G4_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_G4_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY1_2 (SND_TONE_D4S_OFF) ***************
                lda #<SND_TONE_D4S_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_D4S_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune                 
            ;*************** sound to AY3_4 (SND_TONE_D3S_CHB) ***************
                lda #<SND_TONE_D3S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_D3S_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_D2S_CHC) ***************
                lda #<SND_TONE_D2S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_D2S_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune


                jsr SoundTickHalf

            ;2/12
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_D3S_CHB) ***************
                lda #<SND_TONE_D3S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_D3S_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_D2S_CHC) ***************
                lda #<SND_TONE_D2S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_D2S_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune


                jsr SoundTickHalf

            ;2/12 break
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_D3S_CHB) ***************
                lda #<SND_TONE_D3S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_D3S_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_D2S_CHC) ***************
                lda #<SND_TONE_D2S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_D2S_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune


                jsr SoundTickHalf

            ;3/12
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_D3S_CHB) ***************
                lda #<SND_TONE_D3S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_D3S_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_D2S_CHC) ***************
                lda #<SND_TONE_D2S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_D2S_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune


                jsr SoundTickHalf

            ;3/12 break
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_D3S_CHB_OFF) ***************
                lda #<SND_TONE_D3S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_D3S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_D2S_CHC_OFF) ***************
                lda #<SND_TONE_D2S_CHC_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_D2S_CHC_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune


                jsr SoundTickHalf

            ;4/12
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_G4) ***************
                lda #<SND_TONE_G4
                sta TUNE_PTR_LO
                lda #>SND_TONE_G4
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY1_2 (SND_TONE_D4S) ***************
                lda #<SND_TONE_D4S
                sta TUNE_PTR_LO
                lda #>SND_TONE_D4S
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune                 
            ;*************** sound to AY3_4 (SND_TONE_D3S_CHB) ***************
                lda #<SND_TONE_D3S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_D3S_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_D2S_CHC) ***************
                lda #<SND_TONE_D2S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_D2S_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune


                jsr SoundTickHalf

            ;4/12 break
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_G4_OFF) ***************
                lda #<SND_TONE_G4_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_G4_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY1_2 (SND_TONE_D4S_OFF) ***************
                lda #<SND_TONE_D4S_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_D4S_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune                 
            ;*************** sound to AY3_4 (SND_TONE_D3S_CHB_OFF) ***************
                lda #<SND_TONE_D3S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_D3S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_D2S_CHC_OFF) ***************
                lda #<SND_TONE_D2S_CHC_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_D2S_CHC_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune


                jsr SoundTickHalf

            ;5/12
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_D3S_CHB) ***************
                lda #<SND_TONE_D3S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_D3S_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_D2S_CHC) ***************
                lda #<SND_TONE_D2S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_D2S_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune


                jsr SoundTickHalf

            ;5/12 break
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_D3S_CHB) ***************
                lda #<SND_TONE_D3S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_D3S_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_D2S_CHC) ***************
                lda #<SND_TONE_D2S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_D2S_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune


                jsr SoundTickHalf

            ;6/12
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_D3S_CHB) ***************
                lda #<SND_TONE_D3S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_D3S_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_D2S_CHC) ***************
                lda #<SND_TONE_D2S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_D2S_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune


                jsr SoundTickHalf

            ;6/12 break
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_D3S_CHB_OFF) ***************
                lda #<SND_TONE_D3S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_D3S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_D2S_CHC_OFF) ***************
                lda #<SND_TONE_D2S_CHC_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_D2S_CHC_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune


                jsr SoundTickHalf

            ;7/12
            ;*************** sound to AY1_2 (SND_TONE_A4_CHB) ***************
                lda #<SND_TONE_A4_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_G4) ***************
                lda #<SND_TONE_G4
                sta TUNE_PTR_LO
                lda #>SND_TONE_G4
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY1_2 (SND_TONE_D4S) ***************
                lda #<SND_TONE_D4S
                sta TUNE_PTR_LO
                lda #>SND_TONE_D4S
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune                 
            ;*************** sound to AY3_4 (SND_TONE_D3S_CHB) ***************
                lda #<SND_TONE_D3S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_D3S_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_D2S_CHC) ***************
                lda #<SND_TONE_D2S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_D2S_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune


                jsr SoundTickHalf

            ;7/12 break
            ;*************** sound to AY1_2 (SND_TONE_A4_CHB_OFF) ***************
                lda #<SND_TONE_A4_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_G4_OFF) ***************
                lda #<SND_TONE_G4_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_G4_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY1_2 (SND_TONE_D4S_OFF) ***************
                lda #<SND_TONE_D4S_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_D4S_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune                 
            ;*************** sound to AY3_4 (SND_TONE_D3S_CHB) ***************
                lda #<SND_TONE_D3S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_D3S_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_D2S_CHC) ***************
                lda #<SND_TONE_D2S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_D2S_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune


                jsr SoundTickHalf

            ;8/12
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_D3S_CHB) ***************
                lda #<SND_TONE_D3S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_D3S_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_D2S_CHC) ***************
                lda #<SND_TONE_D2S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_D2S_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune


                jsr SoundTickHalf

            ;8/12 break
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_D3S_CHB) ***************
                lda #<SND_TONE_D3S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_D3S_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_D2S_CHC) ***************
                lda #<SND_TONE_D2S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_D2S_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune


                jsr SoundTickHalf

            ;9/12
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_G4) ***************
                lda #<SND_TONE_G4
                sta TUNE_PTR_LO
                lda #>SND_TONE_G4
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY1_2 (SND_TONE_D4S) ***************
                lda #<SND_TONE_D4S
                sta TUNE_PTR_LO
                lda #>SND_TONE_D4S
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune                 
            ;*************** sound to AY3_4 (SND_TONE_D3S_CHB) ***************
                lda #<SND_TONE_D3S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_D3S_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_D2S_CHC) ***************
                lda #<SND_TONE_D2S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_D2S_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune


                jsr SoundTickHalf

            ;9/12 break
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_G4_OFF) ***************
                lda #<SND_TONE_G4_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_G4_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY1_2 (SND_TONE_D4S_OFF) ***************
                lda #<SND_TONE_D4S_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_D4S_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune                 
            ;*************** sound to AY3_4 (SND_TONE_D3S_CHB_OFF) ***************
                lda #<SND_TONE_D3S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_D3S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_D2S_CHC_OFF) ***************
                lda #<SND_TONE_D2S_CHC_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_D2S_CHC_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune


                jsr SoundTickHalf

            ;10/12
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_D3S_CHB) ***************
                lda #<SND_TONE_D3S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_D3S_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_D2S_CHC) ***************
                lda #<SND_TONE_D2S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_D2S_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune


                jsr SoundTickHalf

            ;10/12 break
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_D3S_CHB_OFF) ***************
                lda #<SND_TONE_D3S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_D3S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_D2S_CHC_OFF) ***************
                lda #<SND_TONE_D2S_CHC_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_D2S_CHC_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune


                jsr SoundTickHalf

            ;11/12
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_G4) ***************
                lda #<SND_TONE_G4
                sta TUNE_PTR_LO
                lda #>SND_TONE_G4
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY1_2 (SND_TONE_D4S) ***************
                lda #<SND_TONE_D4S
                sta TUNE_PTR_LO
                lda #>SND_TONE_D4S
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune                 
            ;*************** sound to AY3_4 (SND_TONE_D3S_CHB) ***************
                lda #<SND_TONE_D3S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_D3S_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_D2S_CHC) ***************
                lda #<SND_TONE_D2S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_D2S_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune


                jsr SoundTickHalf

            ;11/12 break
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_G4_OFF) ***************
                lda #<SND_TONE_G4_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_G4_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY1_2 (SND_TONE_D4S_OFF) ***************
                lda #<SND_TONE_D4S_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_D4S_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune                 
            ;*************** sound to AY3_4 (SND_TONE_D3S_CHB) ***************
                lda #<SND_TONE_D3S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_D3S_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_D2S_CHC) ***************
                lda #<SND_TONE_D2S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_D2S_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune


                jsr SoundTickHalf

            ;12/12
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_D3S_CHB) ***************
                lda #<SND_TONE_D3S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_D3S_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_D2S_CHC) ***************
                lda #<SND_TONE_D2S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_D2S_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune


                jsr SoundTickHalf

            ;12/12 break
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_D3S_CHB_OFF) ***************
                lda #<SND_TONE_D3S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_D3S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_D2S_CHC_OFF) ***************
                lda #<SND_TONE_D2S_CHC_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_D2S_CHC_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune


                jsr SoundTickHalf

        Measure16_top:
            ;play twice
            lda #0
            sta PlaySong_MeasureLoop
        Measure16:
            ;1/12
            ;*************** sound to AY1_2 (SND_TONE_A4_CHB) ***************
                lda #<SND_TONE_A4_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_F4S) ***************
                lda #<SND_TONE_F4S
                sta TUNE_PTR_LO
                lda #>SND_TONE_F4S
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY1_2 (SND_TONE_D4S) ***************
                lda #<SND_TONE_D4S
                sta TUNE_PTR_LO
                lda #>SND_TONE_D4S
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune                 
            ;*************** sound to AY3_4 (SND_TONE_B2_CHB) ***************
                lda #<SND_TONE_B2_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_B2_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_B1_CHC) ***************
                lda #<SND_TONE_B1_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_B1_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune


                jsr SoundTickHalf

            ;1/12 break
            ;*************** sound to AY1_2 (SND_TONE_A4_CHB_OFF) ***************
                lda #<SND_TONE_A4_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_F4S_OFF) ***************
                lda #<SND_TONE_F4S_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_F4S_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY1_2 (SND_TONE_D4S_OFF) ***************
                lda #<SND_TONE_D4S_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_D4S_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune                 
            ;*************** sound to AY3_4 (SND_TONE_B2_CHB) ***************
                lda #<SND_TONE_B2_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_B2_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_B1_CHC) ***************
                lda #<SND_TONE_B1_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_B1_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune


                jsr SoundTickHalf

            ;2/12
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_B2_CHB) ***************
                lda #<SND_TONE_B2_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_B2_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_B1_CHC) ***************
                lda #<SND_TONE_B1_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_B1_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune


                jsr SoundTickHalf

            ;2/12 break
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_B2_CHB) ***************
                lda #<SND_TONE_B2_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_B2_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_B1_CHC) ***************
                lda #<SND_TONE_B1_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_B1_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune


                jsr SoundTickHalf

            ;3/12
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_B2_CHB) ***************
                lda #<SND_TONE_B2_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_B2_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_B1_CHC) ***************
                lda #<SND_TONE_B1_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_B1_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune


                jsr SoundTickHalf

            ;3/12 break
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_B2_CHB_OFF) ***************
                lda #<SND_TONE_B2_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_B2_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_B1_CHC_OFF) ***************
                lda #<SND_TONE_B1_CHC_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_B1_CHC_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune


                jsr SoundTickHalf

            ;4/12
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_F4S) ***************
                lda #<SND_TONE_F4S
                sta TUNE_PTR_LO
                lda #>SND_TONE_F4S
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY1_2 (SND_TONE_D4S) ***************
                lda #<SND_TONE_D4S
                sta TUNE_PTR_LO
                lda #>SND_TONE_D4S
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune                 
            ;*************** sound to AY3_4 (SND_TONE_B2_CHB) ***************
                lda #<SND_TONE_B2_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_B2_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_B1_CHC) ***************
                lda #<SND_TONE_B1_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_B1_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune


                jsr SoundTickHalf

            ;4/12 break
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_F4S_OFF) ***************
                lda #<SND_TONE_F4S_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_F4S_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY1_2 (SND_TONE_D4S_OFF) ***************
                lda #<SND_TONE_D4S_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_D4S
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune                 
            ;*************** sound to AY3_4 (SND_TONE_B2_CHB_OFF) ***************
                lda #<SND_TONE_B2_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_B2_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_B1_CHC_OFF) ***************
                lda #<SND_TONE_B1_CHC_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_B1_CHC_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune


                jsr SoundTickHalf

            ;5/12
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_B2_CHB) ***************
                lda #<SND_TONE_B2_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_B2_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_B1_CHC) ***************
                lda #<SND_TONE_B1_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_B1_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune


                jsr SoundTickHalf

            ;5/12 break
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_B2_CHB) ***************
                lda #<SND_TONE_B2_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_B2_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_B1_CHC) ***************
                lda #<SND_TONE_B1_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_B1_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune


                jsr SoundTickHalf

            ;6/12
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_B2_CHB) ***************
                lda #<SND_TONE_B2_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_B2_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_B1_CHC) ***************
                lda #<SND_TONE_B1_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_B1_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune


                jsr SoundTickHalf

            ;6/12 break
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_A2S_CHB_OFF) ***************
                lda #<SND_TONE_A2S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A2S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_A1S_CHC_OFF) ***************
                lda #<SND_TONE_A1S_CHC_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A1S_CHC_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune


                jsr SoundTickHalf

            ;7/12
            ;*************** sound to AY1_2 (SND_TONE_A4_CHB) ***************
                lda #<SND_TONE_A4_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_F4S) ***************
                lda #<SND_TONE_F4S
                sta TUNE_PTR_LO
                lda #>SND_TONE_F4S
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY1_2 (SND_TONE_D4S) ***************
                lda #<SND_TONE_D4S
                sta TUNE_PTR_LO
                lda #>SND_TONE_D4S
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune                 
            ;*************** sound to AY3_4 (SND_TONE_B2_CHB) ***************
                lda #<SND_TONE_B2_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_B2_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_B1_CHC) ***************
                lda #<SND_TONE_B1_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_B1_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune


                jsr SoundTickHalf

            ;7/12 break
            ;*************** sound to AY1_2 (SND_TONE_A4_CHB_OFF) ***************
                lda #<SND_TONE_A4_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_F4S_OFF) ***************
                lda #<SND_TONE_F4S_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_F4S_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY1_2 (SND_TONE_D4S_OFF) ***************
                lda #<SND_TONE_D4S_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_D4S_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune                 
            ;*************** sound to AY3_4 (SND_TONE_B2_CHB) ***************
                lda #<SND_TONE_B2_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_B2_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_B1_CHC) ***************
                lda #<SND_TONE_B1_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_B1_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune


                jsr SoundTickHalf

            ;8/12
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_B2_CHB) ***************
                lda #<SND_TONE_B2_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_B2_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_B1_CHC) ***************
                lda #<SND_TONE_B1_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_B1_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune


                jsr SoundTickHalf

            ;8/12 break
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_B2_CHB) ***************
                lda #<SND_TONE_B2_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_B2_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_B1_CHC) ***************
                lda #<SND_TONE_B1_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_B1_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune


                jsr SoundTickHalf

            ;9/12
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_F4S) ***************
                lda #<SND_TONE_F4S
                sta TUNE_PTR_LO
                lda #>SND_TONE_F4S
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY1_2 (SND_TONE_D4S) ***************
                lda #<SND_TONE_D4S
                sta TUNE_PTR_LO
                lda #>SND_TONE_D4S
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune                 
            ;*************** sound to AY3_4 (SND_TONE_B2_CHB) ***************
                lda #<SND_TONE_B2_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_B2_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_B1_CHC) ***************
                lda #<SND_TONE_B1_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_B1_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune


                jsr SoundTickHalf

            ;9/12 break
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_F4S_OFF) ***************
                lda #<SND_TONE_F4S_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_F4S_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY1_2 (SND_TONE_D4S_OFF) ***************
                lda #<SND_TONE_D4S_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_D4S_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune                 
            ;*************** sound to AY3_4 (SND_TONE_B2_CHB_OFF) ***************
                lda #<SND_TONE_B2_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_B2_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_B1_CHC_OFF) ***************
                lda #<SND_TONE_B1_CHC_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_B1_CHC_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune


                jsr SoundTickHalf

            ;10/12
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_B2_CHB) ***************
                lda #<SND_TONE_B2_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_B2_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_B1_CHC) ***************
                lda #<SND_TONE_B1_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_B1_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune


                jsr SoundTickHalf

            ;10/12 break
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_B2_CHB_OFF) ***************
                lda #<SND_TONE_B2_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_B2_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_B1_CHC_OFF) ***************
                lda #<SND_TONE_B1_CHC_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_B1_CHC_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune


                jsr SoundTickHalf

            ;11/12
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_F4S) ***************
                lda #<SND_TONE_F4S
                sta TUNE_PTR_LO
                lda #>SND_TONE_F4S
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY1_2 (SND_TONE_D4S) ***************
                lda #<SND_TONE_D4S
                sta TUNE_PTR_LO
                lda #>SND_TONE_D4S
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune                 
            ;*************** sound to AY3_4 (SND_TONE_B2_CHB) ***************
                lda #<SND_TONE_B2_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_B2_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_B1_CHC) ***************
                lda #<SND_TONE_B1_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_B1_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune


                jsr SoundTickHalf

            ;11/12 break
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_F4S_OFF) ***************
                lda #<SND_TONE_F4S_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_F4S_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY1_2 (SND_TONE_D4S_OFF) ***************
                lda #<SND_TONE_D4S_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_D4S_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune                 
            ;*************** sound to AY3_4 (SND_TONE_B2_CHB) ***************
                lda #<SND_TONE_B2_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_B2_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_B1_CHC) ***************
                lda #<SND_TONE_B1_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_B1_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune


                jsr SoundTickHalf

            ;12/12
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_B2_CHB) ***************
                lda #<SND_TONE_B2_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_B2_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_B1_CHC) ***************
                lda #<SND_TONE_B1_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_B1_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune


                jsr SoundTickHalf

            ;12/12 break
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_B2_CHB_OFF) ***************
                lda #<SND_TONE_B2_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_B2_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_B1_CHC_OFF) ***************
                lda #<SND_TONE_B1_CHC_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_B1_CHC_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune


                jsr SoundTickHalf

        Measure17_top:
            ;play twice
            lda #0
            sta PlaySong_MeasureLoop
        Measure17:

            ;1/12
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_G4) ***************
                lda #<SND_TONE_G4
                sta TUNE_PTR_LO
                lda #>SND_TONE_G4
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY1_2 (SND_TONE_D4) ***************
                lda #<SND_TONE_D4
                sta TUNE_PTR_LO
                lda #>SND_TONE_D4
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune                 
            ;*************** sound to AY3_4 (SND_TONE_G3_CHB) ***************
                lda #<SND_TONE_G3_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_G3_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_D3_CHC) ***************
                lda #<SND_TONE_D3_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_D3_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G2_CHC) ***************
                lda #<SND_TONE_G2_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_G2_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

                jsr SoundTickHalf

            ;1/12 break
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_G4_OFF) ***************
                lda #<SND_TONE_G4_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_G4_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY1_2 (SND_TONE_D4_OFF) ***************
                lda #<SND_TONE_D4_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_D4_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune                 
            ;*************** sound to AY3_4 (SND_TONE_G3_CHB) ***************
                lda #<SND_TONE_G3_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_G3_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_D3_CHC) ***************
                lda #<SND_TONE_D3_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_D3_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G2_CHC) ***************
                lda #<SND_TONE_G2_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_G2_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

                jsr SoundTickHalf

            ;2/12
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_G3_CHB) ***************
                lda #<SND_TONE_G3_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_G3_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_D3_CHC) ***************
                lda #<SND_TONE_D3_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_D3_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G2_CHC) ***************
                lda #<SND_TONE_G2_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_G2_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

                jsr SoundTickHalf

            ;2/12 break
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_G3_CHB) ***************
                lda #<SND_TONE_G3_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_G3_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_D3_CHC) ***************
                lda #<SND_TONE_D3_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_D3_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G2_CHC) ***************
                lda #<SND_TONE_G2_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_G2_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

                jsr SoundTickHalf

            ;3/12
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_G3_CHB) ***************
                lda #<SND_TONE_G3_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_G3_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_D3_CHC) ***************
                lda #<SND_TONE_D3_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_D3_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G2_CHC) ***************
                lda #<SND_TONE_G2_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_G2_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY1_PlayTune

                jsr SoundTickHalf

            ;3/12 break
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_G3_CHB_OFF) ***************
                lda #<SND_TONE_G3_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_G3_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_D3_CHC_OFF) ***************
                lda #<SND_TONE_D3_CHC_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_D3_CHC_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G2_CHC_OFF) ***************
                lda #<SND_TONE_G2_CHC_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_G2_CHC_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

                jsr SoundTickHalf

            ;4/12
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_G4) ***************
                lda #<SND_TONE_G4
                sta TUNE_PTR_LO
                lda #>SND_TONE_G4
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY1_2 (SND_TONE_D4) ***************
                lda #<SND_TONE_D4
                sta TUNE_PTR_LO
                lda #>SND_TONE_D4
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune                 

            ;*************** sound to AY1_2 (SND_TONE_G2_CHC) ***************
                lda #<SND_TONE_G2_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_G2_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

                jsr SoundTickHalf
            ;*************** sound to AY3_4 (SND_TONE_G1_CHC) ***************
                lda #<SND_TONE_G1_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_G1_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune

                jsr SoundTickHalf

            ;4/12 break
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_G4_OFF) ***************
                lda #<SND_TONE_G4_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_G4_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY1_2 (SND_TONE_D4_OFF) ***************
                lda #<SND_TONE_D4_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_D4_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune                 
            ;*************** sound to AY1_2 (SND_TONE_G2_CHC_OFF) ***************
                lda #<SND_TONE_G2_CHC_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_G2_CHC_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

                jsr SoundTickHalf
            ;*************** sound to AY3_4 (SND_TONE_G1_CHC_OFF) ***************
                lda #<SND_TONE_G1_CHC_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_G1_CHC_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune

                jsr SoundTickHalf

            ;5/12
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_G2_CHB) ***************
                lda #<SND_TONE_G2_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_G2_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G1_CHC) ***************
                lda #<SND_TONE_G1_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_G1_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune


                jsr SoundTickHalf

            ;5/12 break
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_G2_CHB) ***************
                lda #<SND_TONE_G2_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_G2_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G1_CHC) ***************
                lda #<SND_TONE_G1_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_G1_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune


                jsr SoundTickHalf

            ;6/12
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_G2_CHB) ***************
                lda #<SND_TONE_G2_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_G2_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G1_CHC) ***************
                lda #<SND_TONE_G1_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_G1_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune


                jsr SoundTickHalf

            ;6/12 break
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_G2_CHB_OFF) ***************
                lda #<SND_TONE_G2_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_G2_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G1_CHC_OFF) ***************
                lda #<SND_TONE_G1_CHC_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_G1_CHC_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune


                jsr SoundTickHalf

            ;7/12
            ;*************** sound to AY1_2 (SND_TONE_A4_CHB) ***************
                lda #<SND_TONE_A4_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_G4) ***************
                lda #<SND_TONE_G4
                sta TUNE_PTR_LO
                lda #>SND_TONE_G4
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY1_2 (SND_TONE_D4) ***************
                lda #<SND_TONE_D4
                sta TUNE_PTR_LO
                lda #>SND_TONE_D4
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune                 
            ;*************** sound to AY3_4 (SND_TONE_G2_CHB) ***************
                lda #<SND_TONE_G2_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_G2_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G1_CHC) ***************
                lda #<SND_TONE_G1_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_G1_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune


                jsr SoundTickHalf

            ;7/12 break
            ;*************** sound to AY1_2 (SND_TONE_A4_CHB_OFF) ***************
                lda #<SND_TONE_A4_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_G4_OFF) ***************
                lda #<SND_TONE_G4_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_G4_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY1_2 (SND_TONE_D4_OFF) ***************
                lda #<SND_TONE_D4_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_D4_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune                 
            ;*************** sound to AY3_4 (SND_TONE_G2_CHB) ***************
                lda #<SND_TONE_G2_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_G2_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G1_CHC) ***************
                lda #<SND_TONE_G1_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_G1_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune


                jsr SoundTickHalf

            ;8/12
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_G2_CHB) ***************
                lda #<SND_TONE_G2_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_G2_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G1_CHC) ***************
                lda #<SND_TONE_G1_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_G1_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune


                jsr SoundTickHalf

            ;8/12 break
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_G2_CHB) ***************
                lda #<SND_TONE_G2_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_G2_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G1_CHC) ***************
                lda #<SND_TONE_G1_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_G1_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune


                jsr SoundTickHalf

            ;9/12
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_G4) ***************
                lda #<SND_TONE_G4
                sta TUNE_PTR_LO
                lda #>SND_TONE_G4
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY1_2 (SND_TONE_D4) ***************
                lda #<SND_TONE_D4
                sta TUNE_PTR_LO
                lda #>SND_TONE_D4
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune                 
            ;*************** sound to AY3_4 (SND_TONE_G2_CHB) ***************
                lda #<SND_TONE_G2_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_G2_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G1_CHC) ***************
                lda #<SND_TONE_G1_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_G1_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune


                jsr SoundTickHalf

            ;9/12 break
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_G4_OFF) ***************
                lda #<SND_TONE_G4_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_G4_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY1_2 (SND_TONE_D4_OFF) ***************
                lda #<SND_TONE_D4_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_D4_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune                 
            ;*************** sound to AY3_4 (SND_TONE_G2_CHB_OFF) ***************
                lda #<SND_TONE_G2_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_G2_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G1_CHC_OFF) ***************
                lda #<SND_TONE_G1_CHC_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_G1_CHC_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune


                jsr SoundTickHalf

            ;10/12
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_G2_CHB) ***************
                lda #<SND_TONE_G2_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_G2_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G1_CHC) ***************
                lda #<SND_TONE_G1_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_G1_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune


                jsr SoundTickHalf

            ;10/12 break
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_G2_CHB_OFF) ***************
                lda #<SND_TONE_G2_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_G2_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G1_CHC_OFF) ***************
                lda #<SND_TONE_G1_CHC_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_G1_CHC_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune


                jsr SoundTickHalf

            ;11/12
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_G4) ***************
                lda #<SND_TONE_G4
                sta TUNE_PTR_LO
                lda #>SND_TONE_G4
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY1_2 (SND_TONE_D4) ***************
                lda #<SND_TONE_D4
                sta TUNE_PTR_LO
                lda #>SND_TONE_D4
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune                 
            ;*************** sound to AY3_4 (SND_TONE_G2_CHB) ***************
                lda #<SND_TONE_G2_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_G2_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G1_CHC) ***************
                lda #<SND_TONE_G1_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_G1_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune


                jsr SoundTickHalf

            ;11/12 break
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_G4_OFF) ***************
                lda #<SND_TONE_G4_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_G4_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY1_2 (SND_TONE_D4_OFF) ***************
                lda #<SND_TONE_D4_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_D4_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune                 
            ;*************** sound to AY3_4 (SND_TONE_G2_CHB) ***************
                lda #<SND_TONE_G2_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_G2_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G1_CHC) ***************
                lda #<SND_TONE_G1_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_G1_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune


                jsr SoundTickHalf

            ;12/12
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_G2_CHB) ***************
                lda #<SND_TONE_G2_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_G2_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G1_CHC) ***************
                lda #<SND_TONE_G1_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_G1_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune


                jsr SoundTickHalf

            ;12/12 break
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_G4_OFF) ***************
                lda #<SND_TONE_G4_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_G4_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY1_2 (SND_TONE_D4_OFF) ***************
                lda #<SND_TONE_D4_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_D4_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune                 
            ;*************** sound to AY3_4 (SND_TONE_G2_CHB_OFF) ***************
                lda #<SND_TONE_G2_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_G2_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G1_CHC_OFF) ***************
                lda #<SND_TONE_G1_CHC_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_G1_CHC_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune


                jsr SoundTickHalf

        Measure18_top:
            ;play twice
            lda #0
            sta PlaySong_MeasureLoop
        Measure18:
            ;1/12
            ;*************** sound to AY1_2 (SND_TONE_A4_CHB) ***************
                lda #<SND_TONE_A4_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G4) ***************
                lda #<SND_TONE_G4
                sta TUNE_PTR_LO
                lda #>SND_TONE_G4
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_C4S) ***************
                lda #<SND_TONE_C4S
                sta TUNE_PTR_LO
                lda #>SND_TONE_C4S
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_A3S_CHB) ***************
                lda #<SND_TONE_A3S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A3S_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_F3S_CHC) ***************
                lda #<SND_TONE_F3S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_F3S_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   

            ;1/12 break
            ;*************** sound to AY1_2 (SND_TONE_A4_CHB_OFF) ***************
                lda #<SND_TONE_A4_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G4_OFF) ***************
                lda #<SND_TONE_G4_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_G4_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_C4S) ***************
                lda #<SND_TONE_C4S
                sta TUNE_PTR_LO
                lda #>SND_TONE_C4S
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_A3S_CHB) ***************
                lda #<SND_TONE_A3S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A3S_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_F3S_CHC) ***************
                lda #<SND_TONE_F3S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_F3S_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   

            ;2/12
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

                lda #<SND_TONE_A1S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_A1S_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune


                jsr SoundTickHalf
            ;*************** sound to AY3_4 (SND_TONE_C4S) ***************
                lda #<SND_TONE_C4S
                sta TUNE_PTR_LO
                lda #>SND_TONE_C4S
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_A3S_CHB) ***************
                lda #<SND_TONE_A3S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A3S_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_F3S_CHC) ***************
                lda #<SND_TONE_F3S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_F3S_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   

            ;2/12 break
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_C4S) ***************
                lda #<SND_TONE_C4S
                sta TUNE_PTR_LO
                lda #>SND_TONE_C4S
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_A3S_CHB) ***************
                lda #<SND_TONE_A3S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A3S_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_F3S_CHC) ***************
                lda #<SND_TONE_F3S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_F3S_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   

            ;3/12
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

                lda #<SND_TONE_A1S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_A1S_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune


                jsr SoundTickHalf
            ;*************** sound to AY3_4 (SND_TONE_C4S) ***************
                lda #<SND_TONE_C4S
                sta TUNE_PTR_LO
                lda #>SND_TONE_C4S
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_A3S_CHB) ***************
                lda #<SND_TONE_A3S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A3S_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_F3S_CHC) ***************
                lda #<SND_TONE_F3S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_F3S_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   

            ;3/12 break
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_C4S_OFF) ***************
                lda #<SND_TONE_C4S_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_C4S_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_A3S_CHB_OFF) ***************
                lda #<SND_TONE_A3S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A3S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_F3S_CHC_OFF) ***************
                lda #<SND_TONE_F3S_CHC_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_F3S_CHC_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   

            ;4/12
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_F4S) ***************
                lda #<SND_TONE_F4S
                sta TUNE_PTR_LO
                lda #>SND_TONE_F4S
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY1_2 (SND_TONE_C4S) ***************
                lda #<SND_TONE_C4S
                sta TUNE_PTR_LO
                lda #>SND_TONE_C4S
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune                 
            ;*************** sound to AY3_4 (SND_TONE_A2S_CHB) ***************
                lda #<SND_TONE_A2S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A2S_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_A1S_CHC) ***************
                lda #<SND_TONE_A1S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_A1S_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune


                jsr SoundTickHalf

            ;4/12 break
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_F4S_OFF) ***************
                lda #<SND_TONE_F4S_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_F4S_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY1_2 (SND_TONE_C4S_OFF) ***************
                lda #<SND_TONE_C4S_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_C4S_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune                 
            ;*************** sound to AY3_4 (SND_TONE_A2S_CHB_OFF) ***************
                lda #<SND_TONE_A2S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A2S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_A1S_CHC_OFF) ***************
                lda #<SND_TONE_A1S_CHC_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A1S_CHC_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune


                jsr SoundTickHalf

            ;5/12
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_A2S_CHB) ***************
                lda #<SND_TONE_A2S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A2S_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_A1S_CHC) ***************
                lda #<SND_TONE_A1S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_A1S_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune


                jsr SoundTickHalf

            ;5/12 break
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_A2S_CHB) ***************
                lda #<SND_TONE_A2S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A2S_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_A1S_CHC) ***************
                lda #<SND_TONE_A1S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_A1S_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune


                jsr SoundTickHalf

            ;6/12
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_A2S_CHB) ***************
                lda #<SND_TONE_A2S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A2S_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_A1S_CHC) ***************
                lda #<SND_TONE_A1S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_A1S_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune


                jsr SoundTickHalf

            ;6/12 break
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_A2S_CHB_OFF) ***************
                lda #<SND_TONE_A2S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A2S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_A1S_CHC_OFF) ***************
                lda #<SND_TONE_A1S_CHC_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A1S_CHC_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune


                jsr SoundTickHalf

            ;7/12
            ;*************** sound to AY1_2 (SND_TONE_A4_CHB) ***************
                lda #<SND_TONE_A4_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G4) ***************
                lda #<SND_TONE_G4
                sta TUNE_PTR_LO
                lda #>SND_TONE_G4
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_D4) ***************
                lda #<SND_TONE_D4
                sta TUNE_PTR_LO
                lda #>SND_TONE_D4
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_A2S_CHB) ***************
                lda #<SND_TONE_A2S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A2S_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_A1S_CHC) ***************
                lda #<SND_TONE_A1S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_A1S_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune


                jsr SoundTickHalf

            ;7/12 break
            ;*************** sound to AY1_2 (SND_TONE_A4_CHB_OFF) ***************
                lda #<SND_TONE_A4_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G4_OFF) ***************
                lda #<SND_TONE_G4_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_G4_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_D4_OFF) ***************
                lda #<SND_TONE_D4_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_D4_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_A2S_CHB) ***************
                lda #<SND_TONE_A2S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A2S_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_A1S_CHC) ***************
                lda #<SND_TONE_A1S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_A1S_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune


                jsr SoundTickHalf

            ;8/12
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_A2S_CHB) ***************
                lda #<SND_TONE_A2S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A2S_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_A1S_CHC) ***************
                lda #<SND_TONE_A1S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_A1S_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune


                jsr SoundTickHalf

            ;8/12 break
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_A2S_CHB) ***************
                lda #<SND_TONE_A2S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A2S_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_A1S_CHC) ***************
                lda #<SND_TONE_A1S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_A1S_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune


                jsr SoundTickHalf

            ;9/12
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_F4S) ***************
                lda #<SND_TONE_F4S
                sta TUNE_PTR_LO
                lda #>SND_TONE_F4S
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY1_2 (SND_TONE_C4S) ***************
                lda #<SND_TONE_C4S
                sta TUNE_PTR_LO
                lda #>SND_TONE_C4S
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune                 
            ;*************** sound to AY3_4 (SND_TONE_A2S_CHB) ***************
                lda #<SND_TONE_A2S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A2S_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_A1S_CHC) ***************
                lda #<SND_TONE_A1S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_A1S_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune


                jsr SoundTickHalf

            ;9/12 break
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_F4S_OFF) ***************
                lda #<SND_TONE_F4S_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_F4S_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY1_2 (SND_TONE_C4S_OFF) ***************
                lda #<SND_TONE_C4S_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_C4S_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune                 
            ;*************** sound to AY3_4 (SND_TONE_A2S_CHB_OFF) ***************
                lda #<SND_TONE_A2S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A2S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_A1S_CHC_OFF) ***************
                lda #<SND_TONE_A1S_CHC_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A1S_CHC_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune


                jsr SoundTickHalf

            ;10/12
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_A2S_CHB) ***************
                lda #<SND_TONE_A2S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A2S_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_A1S_CHC) ***************
                lda #<SND_TONE_A1S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_A1S_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune


                jsr SoundTickHalf

            ;10/12 break
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_A2S_CHB_OFF) ***************
                lda #<SND_TONE_A2S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A2S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_A1S_CHC_OFF) ***************
                lda #<SND_TONE_A1S_CHC_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A1S_CHC_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune


                jsr SoundTickHalf

            ;11/12
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_F4S) ***************
                lda #<SND_TONE_F4S
                sta TUNE_PTR_LO
                lda #>SND_TONE_F4S
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY1_2 (SND_TONE_C4S) ***************
                lda #<SND_TONE_C4S
                sta TUNE_PTR_LO
                lda #>SND_TONE_C4S
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune                 
            ;*************** sound to AY3_4 (SND_TONE_A2S_CHB) ***************
                lda #<SND_TONE_A2S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A2S_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_A1S_CHC) ***************
                lda #<SND_TONE_A1S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_A1S_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune


                jsr SoundTickHalf

            ;11/12 break
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_F4S_OFF) ***************
                lda #<SND_TONE_F4S_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_F4S_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY1_2 (SND_TONE_C4S_OFF) ***************
                lda #<SND_TONE_C4S_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_C4S_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune                 
            ;*************** sound to AY3_4 (SND_TONE_A2S_CHB) ***************
                lda #<SND_TONE_A2S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A2S_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_A1S_CHC) ***************
                lda #<SND_TONE_A1S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_A1S_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune


                jsr SoundTickHalf

            ;12/12
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_A2S_CHB) ***************
                lda #<SND_TONE_A2S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A2S_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_A1S_CHC) ***************
                lda #<SND_TONE_A1S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_A1S_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune


                jsr SoundTickHalf

            ;12/12 break
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_A2S_CHB_OFF) ***************
                lda #<SND_TONE_A2S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A2S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_A1S_CHC_OFF) ***************
                lda #<SND_TONE_A1S_CHC_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A1S_CHC_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune


                jsr SoundTickHalf

        Measure19_top:
            ;play twice
            ;lda #0
            ;sta PlaySong_MeasureLoop
        Measure19:

            ;1/12
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_G4) ***************
                lda #<SND_TONE_G4
                sta TUNE_PTR_LO
                lda #>SND_TONE_G4
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY1_2 (SND_TONE_D4S) ***************
                lda #<SND_TONE_D4S
                sta TUNE_PTR_LO
                lda #>SND_TONE_D4S
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune                 
            ;*************** sound to AY3_4 (SND_TONE_G3_CHB) ***************
                lda #<SND_TONE_G3_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_G3_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_D3S_CHC) ***************
                lda #<SND_TONE_D3S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_D3S_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_A2S_CHC) ***************
                lda #<SND_TONE_A2S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_A2S_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

            jsr SoundTickHalf

            ;1/12 break
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_G4_OFF) ***************
                lda #<SND_TONE_G4_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_G4_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY1_2 (SND_TONE_D4_OFF) ***************
                lda #<SND_TONE_D4_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_D4_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune                 
            ;*************** sound to AY3_4 (SND_TONE_G3_CHB) ***************
                lda #<SND_TONE_G3_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_G3_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_D3S_CHC) ***************
                lda #<SND_TONE_D3S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_D3S_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_A2S_CHC) ***************
                lda #<SND_TONE_A2S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_A2S_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

            jsr SoundTickHalf

            ;2/12
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_G3_CHB) ***************
                lda #<SND_TONE_G3_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_G3_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_D3S_CHC) ***************
                lda #<SND_TONE_D3S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_D3S_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_A2S_CHC) ***************
                lda #<SND_TONE_A2S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_A2S_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

            jsr SoundTickHalf

            ;2/12 break
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_G3_CHB) ***************
                lda #<SND_TONE_G3_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_G3_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_D3S_CHC) ***************
                lda #<SND_TONE_D3S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_D3S_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_A2S_CHC) ***************
                lda #<SND_TONE_A2S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_A2S_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

            jsr SoundTickHalf

            ;3/12
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_G3_CHB) ***************
                lda #<SND_TONE_G3_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_G3_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_D3S_CHC) ***************
                lda #<SND_TONE_D3S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_D3S_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_A2S_CHC) ***************
                lda #<SND_TONE_A2S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_A2S_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

            jsr SoundTickHalf

            ;3/12 break
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_G3_CHB_OFF) ***************
                lda #<SND_TONE_G3_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_G3_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_D3S_CHC_OFF) ***************
                lda #<SND_TONE_D3S_CHC_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_D3S_CHC_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_A2S_CHC_OFF) ***************
                lda #<SND_TONE_A2S_CHC_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A2S_CHC_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

            jsr SoundTickHalf

            ;4/12
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_G4) ***************
                lda #<SND_TONE_G4
                sta TUNE_PTR_LO
                lda #>SND_TONE_G4
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY1_2 (SND_TONE_D4S) ***************
                lda #<SND_TONE_D4S
                sta TUNE_PTR_LO
                lda #>SND_TONE_D4S
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune                 
            ;*************** sound to AY3_4 (SND_TONE_D3S_CHC) ***************
                lda #<SND_TONE_D3S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_D3S_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_D2S_CHC) ***************
                lda #<SND_TONE_D2S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_D2S_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

            jsr SoundTickHalf

            ;4/12 break
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_G4_OFF) ***************
                lda #<SND_TONE_G4_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_G4_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY1_2 (SND_TONE_D4_OFF) ***************
                lda #<SND_TONE_D4_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_D4_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune                 
            ;*************** sound to AY3_4 (SND_TONE_D3S_CHC_OFF) ***************
                lda #<SND_TONE_D3S_CHC_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_D3S_CHC_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_D2S_CHC_OFF) ***************
                lda #<SND_TONE_D2S_CHC_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_D2S_CHC_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

            jsr SoundTickHalf

            ;5/12
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_D3S_CHC) ***************
                lda #<SND_TONE_D3S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_D3S_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_D2S_CHC) ***************
                lda #<SND_TONE_D2S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_D2S_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

            jsr SoundTickHalf

            ;5/12 break
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_D3S_CHC) ***************
                lda #<SND_TONE_D3S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_D3S_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_D2S_CHC) ***************
                lda #<SND_TONE_D2S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_D2S_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

            jsr SoundTickHalf

            ;6/12
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_D3S_CHC) ***************
                lda #<SND_TONE_D3S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_D3S_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_D2S_CHC) ***************
                lda #<SND_TONE_D2S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_D2S_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

            jsr SoundTickHalf

            ;6/12 break
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_D3S_CHC_OFF) ***************
                lda #<SND_TONE_D3S_CHC_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_D3S_CHC_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_D2S_CHC_OFF) ***************
                lda #<SND_TONE_D2S_CHC_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_D2S_CHC_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

            jsr SoundTickHalf

            ;7/12
            ;*************** sound to AY1_2 (SND_TONE_A4_CHB) ***************
                lda #<SND_TONE_A4_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_G4) ***************
                lda #<SND_TONE_G4
                sta TUNE_PTR_LO
                lda #>SND_TONE_G4
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY1_2 (SND_TONE_D4S) ***************
                lda #<SND_TONE_D4S
                sta TUNE_PTR_LO
                lda #>SND_TONE_D4S
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune                 
            ;*************** sound to AY3_4 (SND_TONE_D3S_CHC) ***************
                lda #<SND_TONE_D3S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_D3S_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_D2S_CHC) ***************
                lda #<SND_TONE_D2S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_D2S_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

            jsr SoundTickHalf

            ;7/12 break
            ;*************** sound to AY1_2 (SND_TONE_A4_CHB_OFF) ***************
                lda #<SND_TONE_A4_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_G4_OFF) ***************
                lda #<SND_TONE_G4_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_G4_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY1_2 (SND_TONE_D4S_OFF) ***************
                lda #<SND_TONE_D4S_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_D4S_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune                 
            ;*************** sound to AY3_4 (SND_TONE_D3S_CHC) ***************
                lda #<SND_TONE_D3S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_D3S_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_D2S_CHC) ***************
                lda #<SND_TONE_D2S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_D2S_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

            jsr SoundTickHalf

            ;8/12
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_D3S_CHC) ***************
                lda #<SND_TONE_D3S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_D3S_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_D2S_CHC) ***************
                lda #<SND_TONE_D2S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_D2S_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

            jsr SoundTickHalf

            ;8/12 break
            ;*************** sound to AY1_2 (SND_TONE_A4_CHB_OFF) ***************
                lda #<SND_TONE_A4_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_D3S_CHC) ***************
                lda #<SND_TONE_D3S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_D3S_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_D2S_CHC) ***************
                lda #<SND_TONE_D2S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_D2S_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

            jsr SoundTickHalf

            ;9/12
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_G4) ***************
                lda #<SND_TONE_G4
                sta TUNE_PTR_LO
                lda #>SND_TONE_G4
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY1_2 (SND_TONE_D4S) ***************
                lda #<SND_TONE_D4S
                sta TUNE_PTR_LO
                lda #>SND_TONE_D4S
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune                 
            ;*************** sound to AY3_4 (SND_TONE_D3S_CHC) ***************
                lda #<SND_TONE_D3S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_D3S_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_D2S_CHC) ***************
                lda #<SND_TONE_D2S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_D2S_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

            jsr SoundTickHalf

            ;9/12 break
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_G4_OFF) ***************
                lda #<SND_TONE_G4_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_G4_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY1_2 (SND_TONE_D4S_OFF) ***************
                lda #<SND_TONE_D4S_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_D4S_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune                 
            ;*************** sound to AY3_4 (SND_TONE_D3S_CHC_OFF) ***************
                lda #<SND_TONE_D3S_CHC_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_D3S_CHC_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_D2S_CHC_OFF) ***************
                lda #<SND_TONE_D2S_CHC_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_D2S_CHC_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

            jsr SoundTickHalf

            ;10/12
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_D3S_CHC) ***************
                lda #<SND_TONE_D3S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_D3S_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_D2S_CHC) ***************
                lda #<SND_TONE_D2S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_D2S_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

            jsr SoundTickHalf

            ;10/12 break
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_D3S_CHC_OFF) ***************
                lda #<SND_TONE_D3S_CHC_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_D3S_CHC_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_D2S_CHC_OFF) ***************
                lda #<SND_TONE_D2S_CHC_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_D2S_CHC_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

            jsr SoundTickHalf

            ;11/12
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_G4) ***************
                lda #<SND_TONE_G4
                sta TUNE_PTR_LO
                lda #>SND_TONE_G4
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY1_2 (SND_TONE_D4S) ***************
                lda #<SND_TONE_D4S
                sta TUNE_PTR_LO
                lda #>SND_TONE_D4S
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune                 
            ;*************** sound to AY3_4 (SND_TONE_D3S_CHC) ***************
                lda #<SND_TONE_D3S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_D3S_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_D2S_CHC) ***************
                lda #<SND_TONE_D2S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_D2S_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

            jsr SoundTickHalf

            ;11/12 break
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_G4_OFF) ***************
                lda #<SND_TONE_G4_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_G4_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY1_2 (SND_TONE_D4S_OFF) ***************
                lda #<SND_TONE_D4S_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_D4S_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune                 
            ;*************** sound to AY3_4 (SND_TONE_D3S_CHC) ***************
                lda #<SND_TONE_D3S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_D3S_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_D2S_CHC) ***************
                lda #<SND_TONE_D2S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_D2S_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

            jsr SoundTickHalf

            ;12/12
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_D3S_CHC) ***************
                lda #<SND_TONE_D3S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_D3S_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_D2S_CHC) ***************
                lda #<SND_TONE_D2S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_D2S_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

            jsr SoundTickHalf

            ;12/12 break
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_D3S_CHC_OFF) ***************
                lda #<SND_TONE_D3S_CHC_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_D3S_CHC_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_D2S_CHC_OFF) ***************
                lda #<SND_TONE_D2S_CHC_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_D2S_CHC_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

            jsr SoundTickHalf

        Measure20_top:
            ;play twice
            ;lda #0
            ;sta PlaySong_MeasureLoop
        Measure20:
            ;1/12
            ;*************** sound to AY1_2 (SND_TONE_A4_CHB) ***************
                lda #<SND_TONE_A4_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G4) ***************
                lda #<SND_TONE_G4
                sta TUNE_PTR_LO
                lda #>SND_TONE_G4
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_D4S) ***************
                lda #<SND_TONE_D4S
                sta TUNE_PTR_LO
                lda #>SND_TONE_D4S
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune                 
            ;*************** sound to AY3_4 (SND_TONE_B3_CHB) ***************
                lda #<SND_TONE_B3_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_B3_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY1_2 (SND_TONE_F3S_CHC) ***************
                lda #<SND_TONE_F3S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_F3S_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_D3S_CHC) ***************
                lda #<SND_TONE_D3S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_D3S_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   

            jsr SoundTickHalf

            ;1/12 break
            ;*************** sound to AY1_2 (SND_TONE_A4_CHB_OFF) ***************
                lda #<SND_TONE_A4_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G4_OFF) ***************
                lda #<SND_TONE_G4_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_G4_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_D4S_OFF) ***************
                lda #<SND_TONE_D4S_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_D4S_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune                 
            ;*************** sound to AY3_4 (SND_TONE_B3_CHB) ***************
                lda #<SND_TONE_B3_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_B3_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY1_2 (SND_TONE_F3S_CHC) ***************
                lda #<SND_TONE_F3S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_F3S_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_D3S_CHC) ***************
                lda #<SND_TONE_D3S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_D3S_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   

            jsr SoundTickHalf

            ;2/12
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_B3_CHB) ***************
                lda #<SND_TONE_B3_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_B3_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY1_2 (SND_TONE_F3S_CHC) ***************
                lda #<SND_TONE_F3S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_F3S_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_D3S_CHC) ***************
                lda #<SND_TONE_D3S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_D3S_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   

            jsr SoundTickHalf

            ;2/12 break
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_B3_CHB) ***************
                lda #<SND_TONE_B3_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_B3_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY1_2 (SND_TONE_F3S_CHC) ***************
                lda #<SND_TONE_F3S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_F3S_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_D3S_CHC) ***************
                lda #<SND_TONE_D3S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_D3S_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   

            jsr SoundTickHalf

            ;3/12
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_B3_CHB) ***************
                lda #<SND_TONE_B3_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_B3_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY1_2 (SND_TONE_F3S_CHC) ***************
                lda #<SND_TONE_F3S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_F3S_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_D3S_CHC) ***************
                lda #<SND_TONE_D3S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_D3S_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   

            jsr SoundTickHalf

            ;3/12 break
            ;*************** sound to AY1_2 (SND_TONE_A4_CHB_OFF) ***************
                lda #<SND_TONE_A4_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_B3_CHB_OFF) ***************
                lda #<SND_TONE_B3_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_B3_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY1_2 (SND_TONE_F3S_CHC_OFF) ***************
                lda #<SND_TONE_F3S_CHC_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_F3S_CHC_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_D3S_CHC_OFF) ***************
                lda #<SND_TONE_D3S_CHC_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_D3S_CHC_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   

            jsr SoundTickHalf

            ;4/12
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_F4S) ***************
                lda #<SND_TONE_F4S
                sta TUNE_PTR_LO
                lda #>SND_TONE_F4S
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_D4S) ***************
                lda #<SND_TONE_D4S
                sta TUNE_PTR_LO
                lda #>SND_TONE_D4S
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune                 
            ;*************** sound to AY1_2 (SND_TONE_B2_CHC) ***************
                lda #<SND_TONE_B2_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_B2_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_B1_CHC) ***************
                lda #<SND_TONE_B1_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_B1_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   

            jsr SoundTickHalf

            ;4/12 break
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_F4S_OFF) ***************
                lda #<SND_TONE_F4S_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_F4S_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_D4S_OFF) ***************
                lda #<SND_TONE_D4S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_D4S_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune                 
            ;*************** sound to AY1_2 (SND_TONE_B2_CHC_OFF) ***************
                lda #<SND_TONE_B2_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_B2_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_B1_CHC_OFF) ***************
                lda #<SND_TONE_B1_CHC_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_B1_CHC_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   

            jsr SoundTickHalf

            ;5/12
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_B2_CHC) ***************
                lda #<SND_TONE_B2_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_B2_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_B1_CHC) ***************
                lda #<SND_TONE_B1_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_B1_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   

            jsr SoundTickHalf

            ;5/12 break
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_B2_CHC) ***************
                lda #<SND_TONE_B2_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_B2_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_B1_CHC) ***************
                lda #<SND_TONE_B1_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_B1_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   

            jsr SoundTickHalf

            ;6/12
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_B2_CHC) ***************
                lda #<SND_TONE_B2_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_B2_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_B1_CHC) ***************
                lda #<SND_TONE_B1_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_B1_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   

            jsr SoundTickHalf

            ;6/12 break
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_B2_CHC_OFF) ***************
                lda #<SND_TONE_B2_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_B2_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_B1_CHC_OFF) ***************
                lda #<SND_TONE_B1_CHC_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_B1_CHC_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   

            jsr SoundTickHalf

            ;7/12
            ;*************** sound to AY1_2 (SND_TONE_A4_CHB) ***************
                lda #<SND_TONE_A4_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_F4S) ***************
                lda #<SND_TONE_F4S
                sta TUNE_PTR_LO
                lda #>SND_TONE_F4S
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune   
            ;*************** sound to AY1_2 (SND_TONE_D4S_CHC) ***************
                lda #<SND_TONE_D4S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_D4S_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune                 
            ;*************** sound to AY3_4 (SND_TONE_B2_CHB) ***************
                lda #<SND_TONE_B2_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_B2_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_B1_CHC) ***************
                lda #<SND_TONE_B1_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_B1_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   

            jsr SoundTickHalf

            ;7/12 break
            ;*************** sound to AY1_2 (SND_TONE_A4_CHB_OFF) ***************
                lda #<SND_TONE_A4_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_F4S_OFF) ***************
                lda #<SND_TONE_F4S_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_F4S_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune   
            ;*************** sound to AY1_2 (SND_TONE_D4S_CHC_OFF) ***************
                lda #<SND_TONE_D4S_CHC_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_D4S_CHC_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune                 
            ;*************** sound to AY3_4 (SND_TONE_B2_CHB_OFF) ***************
                lda #<SND_TONE_B2_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_B2_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_B1_CHC_OFF) ***************
                lda #<SND_TONE_B1_CHC_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_B1_CHC_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   

            jsr SoundTickHalf

            ;8/12
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_B2_CHB) ***************
                lda #<SND_TONE_B2_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_B2_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_B1_CHC) ***************
                lda #<SND_TONE_B1_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_B1_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   

            jsr SoundTickHalf

            ;8/12 break
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_B2_CHB) ***************
                lda #<SND_TONE_B2_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_B2_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_B1_CHC) ***************
                lda #<SND_TONE_B1_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_B1_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   

            jsr SoundTickHalf

            ;9/12
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_F4S) ***************
                lda #<SND_TONE_F4S
                sta TUNE_PTR_LO
                lda #>SND_TONE_F4S
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune   
            ;*************** sound to AY1_2 (SND_TONE_D4S_CHC) ***************
                lda #<SND_TONE_D4S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_D4S_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune                 
            ;*************** sound to AY3_4 (SND_TONE_B2_CHB) ***************
                lda #<SND_TONE_B2_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_B2_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_B1_CHC) ***************
                lda #<SND_TONE_B1_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_B1_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   

            jsr SoundTickHalf

            ;9/12 break
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_F4S_OFF) ***************
                lda #<SND_TONE_F4S_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_F4S_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune   
            ;*************** sound to AY1_2 (SND_TONE_D4S_CHC_OFF) ***************
                lda #<SND_TONE_D4S_CHC_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_D4S_CHC_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune                 
            ;*************** sound to AY3_4 (SND_TONE_B2_CHB_OFF) ***************
                lda #<SND_TONE_B2_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_B2_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_B1_CHC_OFF) ***************
                lda #<SND_TONE_B1_CHC_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_B1_CHC_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   

            jsr SoundTickHalf

            ;10/12
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_B2_CHB) ***************
                lda #<SND_TONE_B2_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_B2_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_B1_CHC) ***************
                lda #<SND_TONE_B1_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_B1_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   

            jsr SoundTickHalf

            ;10/12 break
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_B2_CHB_OFF) ***************
                lda #<SND_TONE_B2_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_B2_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_B1_CHC_OFF) ***************
                lda #<SND_TONE_B1_CHC_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_B1_CHC_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   

            jsr SoundTickHalf

            ;11/12
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_F4S) ***************
                lda #<SND_TONE_F4S
                sta TUNE_PTR_LO
                lda #>SND_TONE_F4S
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune   
            ;*************** sound to AY1_2 (SND_TONE_D4S_CHC) ***************
                lda #<SND_TONE_D4S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_D4S_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune                 
            ;*************** sound to AY3_4 (SND_TONE_B2_CHB) ***************
                lda #<SND_TONE_B2_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_B2_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_B1_CHC) ***************
                lda #<SND_TONE_B1_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_B1_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   

            jsr SoundTickHalf

            ;11/12 break
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_F4S_OFF) ***************
                lda #<SND_TONE_F4S_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_F4S_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune   
            ;*************** sound to AY1_2 (SND_TONE_D4S_CHC_OFF) ***************
                lda #<SND_TONE_D4S_CHC_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_D4S_CHC_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune                 
            ;*************** sound to AY3_4 (SND_TONE_B2_CHB) ***************
                lda #<SND_TONE_B2_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_B2_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_B1_CHC) ***************
                lda #<SND_TONE_B1_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_B1_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   

            jsr SoundTickHalf

            ;12/12
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_B2_CHB) ***************
                lda #<SND_TONE_B2_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_B2_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_B1_CHC) ***************
                lda #<SND_TONE_B1_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_B1_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   

            jsr SoundTickHalf

            ;12/12 break
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_B2_CHB_OFF) ***************
                lda #<SND_TONE_B2_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_B2_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_B1_CHC_OFF) ***************
                lda #<SND_TONE_B1_CHC_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_B1_CHC_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   

            jsr SoundTickHalf

        Measure21_top:
            ;play twice
            ;lda #0
            ;sta PlaySong_MeasureLoop
        Measure21:

            ;1/12
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_G4) ***************
                lda #<SND_TONE_G4
                sta TUNE_PTR_LO
                lda #>SND_TONE_G4
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY1_2 (SND_TONE_D4) ***************
                lda #<SND_TONE_D4
                sta TUNE_PTR_LO
                lda #>SND_TONE_D4
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune                 
            ;*************** sound to AY3_4 (SND_TONE_G3_CHB) ***************
                lda #<SND_TONE_G3_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_G3_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_D3_CHC) ***************
                lda #<SND_TONE_D3_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_D3_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G2_CHC) ***************
                lda #<SND_TONE_G2_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_G2_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

            jsr SoundTickHalf

            ;1/12 break
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_G4_OFF) ***************
                lda #<SND_TONE_G4_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_G4_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY1_2 (SND_TONE_D4_OFF) ***************
                lda #<SND_TONE_D4_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_D4_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune                 
            ;*************** sound to AY3_4 (SND_TONE_G3_CHB) ***************
                lda #<SND_TONE_G3_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_G3_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_D3_CHC) ***************
                lda #<SND_TONE_D3_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_D3_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G2_CHC) ***************
                lda #<SND_TONE_G2_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_G2_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

            jsr SoundTickHalf

            ;2/12
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_G3_CHB) ***************
                lda #<SND_TONE_G3_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_G3_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_D3_CHC) ***************
                lda #<SND_TONE_D3_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_D3_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G2_CHC) ***************
                lda #<SND_TONE_G2_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_G2_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

            jsr SoundTickHalf

            ;2/12 break
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_G3_CHB) ***************
                lda #<SND_TONE_G3_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_G3_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_D3_CHC) ***************
                lda #<SND_TONE_D3_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_D3_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G2_CHC) ***************
                lda #<SND_TONE_G2_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_G2_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

            jsr SoundTickHalf

            ;3/12
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_G3_CHB) ***************
                lda #<SND_TONE_G3_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_G3_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_D3_CHC) ***************
                lda #<SND_TONE_D3_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_D3_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G2_CHC) ***************
                lda #<SND_TONE_G2_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_G2_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY1_PlayTune

            jsr SoundTickHalf

            ;3/12 break
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_G3_CHB_OFF) ***************
                lda #<SND_TONE_G3_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_G3_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_D3_CHC_OFF) ***************
                lda #<SND_TONE_D3_CHC_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_D3_CHC_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G2_CHC_OFF) ***************
                lda #<SND_TONE_G2_CHC_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_G2_CHC_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

            jsr SoundTickHalf

            ;4/12
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_G4) ***************
                lda #<SND_TONE_G4
                sta TUNE_PTR_LO
                lda #>SND_TONE_G4
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY1_2 (SND_TONE_D4) ***************
                lda #<SND_TONE_D4
                sta TUNE_PTR_LO
                lda #>SND_TONE_D4
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune                 
            ;*************** sound to AY1_2 (SND_TONE_G2_CHC) ***************
                lda #<SND_TONE_G2_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_G2_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_G1_CHC) ***************
                lda #<SND_TONE_G1_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_G1_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune

            jsr SoundTickHalf

            ;4/12 break
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_G4_OFF) ***************
                lda #<SND_TONE_G4_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_G4_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY1_2 (SND_TONE_D4_OFF) ***************
                lda #<SND_TONE_D4_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_D4_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune                 
            ;*************** sound to AY1_2 (SND_TONE_G2_CHC_OFF) ***************
                lda #<SND_TONE_G2_CHC_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_G2_CHC_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_G1_CHC_OFF) ***************
                lda #<SND_TONE_G1_CHC_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_G1_CHC_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune

            jsr SoundTickHalf

            ;5/12
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_G2_CHB) ***************
                lda #<SND_TONE_G2_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_G2_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G1_CHC) ***************
                lda #<SND_TONE_G1_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_G1_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

            jsr SoundTickHalf

            ;5/12 break
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_G2_CHB) ***************
                lda #<SND_TONE_G2_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_G2_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G1_CHC) ***************
                lda #<SND_TONE_G1_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_G1_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

            jsr SoundTickHalf

            ;6/12
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_G2_CHB) ***************
                lda #<SND_TONE_G2_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_G2_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G1_CHC) ***************
                lda #<SND_TONE_G1_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_G1_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

            jsr SoundTickHalf

            ;6/12 break
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_G2_CHB_OFF) ***************
                lda #<SND_TONE_G2_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_G2_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G1_CHC_OFF) ***************
                lda #<SND_TONE_G1_CHC_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_G1_CHC_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

            jsr SoundTickHalf

            ;7/12
            ;*************** sound to AY1_2 (SND_TONE_A4_CHB) ***************
                lda #<SND_TONE_A4_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_G4) ***************
                lda #<SND_TONE_G4
                sta TUNE_PTR_LO
                lda #>SND_TONE_G4
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_D5_CHC) ***************
                lda #<SND_TONE_D5_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_D5_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G3) ***************
                lda #<SND_TONE_G3
                sta TUNE_PTR_LO
                lda #>SND_TONE_G3
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

            jsr SoundTickHalf

            ;7/12 break
            ;*************** sound to AY1_2 (SND_TONE_A4_CHB_OFF) ***************
                lda #<SND_TONE_A4_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_G4_OFF) ***************
                lda #<SND_TONE_G4_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_G4_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_D5_CHC_OFF) ***************
                lda #<SND_TONE_D5_CHC_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_D5_CHC_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G3_OFF) ***************
                lda #<SND_TONE_G3_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_G3_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

            jsr SoundTickHalf

            ;8/12
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_D5_CHC) ***************
                lda #<SND_TONE_D5_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_D5_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G3) ***************
                lda #<SND_TONE_G3
                sta TUNE_PTR_LO
                lda #>SND_TONE_G3
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

            jsr SoundTickHalf

            ;8/12 break
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_D5_CHC_OFF) ***************
                lda #<SND_TONE_D5_CHC_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_D5_CHC_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G3_OFF) ***************
                lda #<SND_TONE_G3_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_G3_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

            jsr SoundTickHalf

            ;9/12
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_G4) ***************
                lda #<SND_TONE_G4
                sta TUNE_PTR_LO
                lda #>SND_TONE_G4
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY1_2 (SND_TONE_D4) ***************
                lda #<SND_TONE_D4
                sta TUNE_PTR_LO
                lda #>SND_TONE_D4
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune                 
            ;*************** sound to AY3_4 (SND_TONE_D5_CHC) ***************
                lda #<SND_TONE_D5_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_D5_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G3_CHC) ***************
                lda #<SND_TONE_G3_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_G3_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

            jsr SoundTickHalf

            ;9/12 break
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_G4_OFF) ***************
                lda #<SND_TONE_G4_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_G4_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY1_2 (SND_TONE_D4_OFF) ***************
                lda #<SND_TONE_D4_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_D4_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune                 
            ;*************** sound to AY3_4 (SND_TONE_D5_CHC_OFF) ***************
                lda #<SND_TONE_D5_CHC_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_D5_CHC_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G3_CHC_OFF) ***************
                lda #<SND_TONE_G3_CHC_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_G3_CHC_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

            jsr SoundTickHalf

            ;10/12
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_G2_CHB) ***************
                lda #<SND_TONE_G2_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_G2_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G1_CHC) ***************
                lda #<SND_TONE_G1_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_G1_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

            jsr SoundTickHalf

            ;10/12 break
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_G2_CHB_OFF) ***************
                lda #<SND_TONE_G2_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_G2_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G1_CHC_OFF) ***************
                lda #<SND_TONE_G1_CHC_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_G1_CHC_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

            jsr SoundTickHalf

            ;11/12
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_G4) ***************
                lda #<SND_TONE_G4
                sta TUNE_PTR_LO
                lda #>SND_TONE_G4
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY1_2 (SND_TONE_D4) ***************
                lda #<SND_TONE_D4
                sta TUNE_PTR_LO
                lda #>SND_TONE_D4
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune                 
            ;*************** sound to AY3_4 (SND_TONE_G2_CHB) ***************
                lda #<SND_TONE_G2_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_G2_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G1_CHC) ***************
                lda #<SND_TONE_G1_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_G1_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

            jsr SoundTickHalf

            ;11/12 break
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_G4_OFF) ***************
                lda #<SND_TONE_G4_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_G4_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY1_2 (SND_TONE_D4_OFF) ***************
                lda #<SND_TONE_D4_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_D4_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune                 
            ;*************** sound to AY3_4 (SND_TONE_G2_CHB) ***************
                lda #<SND_TONE_G2_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_G2_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G1_CHC) ***************
                lda #<SND_TONE_G1_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_G1_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

            jsr SoundTickHalf

            ;12/12
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_G2_CHB) ***************
                lda #<SND_TONE_G2_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_G2_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G1_CHC) ***************
                lda #<SND_TONE_G1_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_G1_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

            jsr SoundTickHalf

            ;12/12 break
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_G4_OFF) ***************
                lda #<SND_TONE_G4_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_G4_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY1_2 (SND_TONE_D4_OFF) ***************
                lda #<SND_TONE_D4_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_D4_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune                 
            ;*************** sound to AY3_4 (SND_TONE_G2_CHB_OFF) ***************
                lda #<SND_TONE_G2_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_G2_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G1_CHC_OFF) ***************
                lda #<SND_TONE_G1_CHC_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_G1_CHC_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

            jsr SoundTickHalf

        Measure22_top:
            ;play twice
            ;lda #0
            ;sta PlaySong_MeasureLoop
        Measure22:
            ;1/12
            ;*************** sound to AY1_2 (SND_TONE_A4_CHB) ***************
                lda #<SND_TONE_A4_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G4) ***************
                lda #<SND_TONE_G4
                sta TUNE_PTR_LO
                lda #>SND_TONE_G4
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_C4S) ***************
                lda #<SND_TONE_C4S
                sta TUNE_PTR_LO
                lda #>SND_TONE_C4S
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_A3S_CHB) ***************
                lda #<SND_TONE_A3S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A3S_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_F3S_CHC) ***************
                lda #<SND_TONE_F3S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_F3S_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   

            jsr SoundTickHalf

            ;1/12 break
            ;*************** sound to AY1_2 (SND_TONE_A4_CHB_OFF) ***************
                lda #<SND_TONE_A4_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G4_OFF) ***************
                lda #<SND_TONE_G4_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_G4_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_C4S) ***************
                lda #<SND_TONE_C4S
                sta TUNE_PTR_LO
                lda #>SND_TONE_C4S
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_A3S_CHB) ***************
                lda #<SND_TONE_A3S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A3S_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_F3S_CHC) ***************
                lda #<SND_TONE_F3S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_F3S_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   

            jsr SoundTickHalf

            ;2/12
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_C4S) ***************
                lda #<SND_TONE_C4S
                sta TUNE_PTR_LO
                lda #>SND_TONE_C4S
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_A3S_CHB) ***************
                lda #<SND_TONE_A3S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A3S_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_F3S_CHC) ***************
                lda #<SND_TONE_F3S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_F3S_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   

            jsr SoundTickHalf

            ;2/12 break
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_C4S) ***************
                lda #<SND_TONE_C4S
                sta TUNE_PTR_LO
                lda #>SND_TONE_C4S
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_A3S_CHB) ***************
                lda #<SND_TONE_A3S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A3S_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_F3S_CHC) ***************
                lda #<SND_TONE_F3S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_F3S_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   

            jsr SoundTickHalf

            ;3/12
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_C4S) ***************
                lda #<SND_TONE_C4S
                sta TUNE_PTR_LO
                lda #>SND_TONE_C4S
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_A3S_CHB) ***************
                lda #<SND_TONE_A3S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A3S_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_F3S_CHC) ***************
                lda #<SND_TONE_F3S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_F3S_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   

            jsr SoundTickHalf

            ;3/12 break
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_C4S_OFF) ***************
                lda #<SND_TONE_C4S_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_C4S_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_A3S_CHB_OFF) ***************
                lda #<SND_TONE_A3S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A3S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_F3S_CHC_OFF) ***************
                lda #<SND_TONE_F3S_CHC_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_F3S_CHC_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   

            jsr SoundTickHalf

            ;4/12
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_F4S) ***************
                lda #<SND_TONE_F4S
                sta TUNE_PTR_LO
                lda #>SND_TONE_F4S
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY1_2 (SND_TONE_C4S) ***************
                lda #<SND_TONE_C4S
                sta TUNE_PTR_LO
                lda #>SND_TONE_C4S
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune                 
            ;*************** sound to AY3_4 (SND_TONE_A2S_CHB) ***************
                lda #<SND_TONE_A2S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A2S_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_A1S_CHC) ***************
                lda #<SND_TONE_A1S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_A1S_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

            jsr SoundTickHalf

            ;4/12 break
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_F4S_OFF) ***************
                lda #<SND_TONE_F4S_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_F4S_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY1_2 (SND_TONE_C4S_OFF) ***************
                lda #<SND_TONE_C4S_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_C4S_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune                 
            ;*************** sound to AY3_4 (SND_TONE_A2S_CHB_OFF) ***************
                lda #<SND_TONE_A2S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A2S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_A1S_CHC_OFF) ***************
                lda #<SND_TONE_A1S_CHC_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A1S_CHC_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

            jsr SoundTickHalf

            ;5/12
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_A2S_CHB) ***************
                lda #<SND_TONE_A2S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A2S_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_A1S_CHC) ***************
                lda #<SND_TONE_A1S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_A1S_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

            jsr SoundTickHalf

            ;5/12 break
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_A2S_CHB) ***************
                lda #<SND_TONE_A2S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A2S_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_A1S_CHC) ***************
                lda #<SND_TONE_A1S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_A1S_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

            jsr SoundTickHalf

            ;6/12
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_A2S_CHB) ***************
                lda #<SND_TONE_A2S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A2S_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_A1S_CHC) ***************
                lda #<SND_TONE_A1S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_A1S_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

            jsr SoundTickHalf

            ;6/12 break
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_A2S_CHB_OFF) ***************
                lda #<SND_TONE_A2S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A2S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_A1S_CHC_OFF) ***************
                lda #<SND_TONE_A1S_CHC_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A1S_CHC_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

            jsr SoundTickHalf

            ;7/12
            ;*************** sound to AY1_2 (SND_TONE_A4_CHB) ***************
                lda #<SND_TONE_A4_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_F4S) ***************
                lda #<SND_TONE_F4S
                sta TUNE_PTR_LO
                lda #>SND_TONE_F4S
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_C4S) ***************
                lda #<SND_TONE_C4S
                sta TUNE_PTR_LO
                lda #>SND_TONE_C4S
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_A3S_CHB) ***************
                lda #<SND_TONE_A3S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A3S_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   

            jsr SoundTickHalf

            ;7/12 break
            ;*************** sound to AY1_2 (SND_TONE_A4_CHB_OFF) ***************
                lda #<SND_TONE_A4_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_F4S) ***************
                lda #<SND_TONE_F4S
                sta TUNE_PTR_LO
                lda #>SND_TONE_F4S
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_C4S) ***************
                lda #<SND_TONE_C4S
                sta TUNE_PTR_LO
                lda #>SND_TONE_C4S
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_A3S_CHB) ***************
                lda #<SND_TONE_A3S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A3S_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   

            jsr SoundTickHalf

            ;8/12
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_F4S) ***************
                lda #<SND_TONE_F4S
                sta TUNE_PTR_LO
                lda #>SND_TONE_F4S
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_C4S) ***************
                lda #<SND_TONE_C4S
                sta TUNE_PTR_LO
                lda #>SND_TONE_C4S
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_A3S_CHB) ***************
                lda #<SND_TONE_A3S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A3S_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   

            jsr SoundTickHalf

            ;8/12 break
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_F4S) ***************
                lda #<SND_TONE_F4S
                sta TUNE_PTR_LO
                lda #>SND_TONE_F4S
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_C4S) ***************
                lda #<SND_TONE_C4S
                sta TUNE_PTR_LO
                lda #>SND_TONE_C4S
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_A3S_CHB) ***************
                lda #<SND_TONE_A3S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A3S_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   

            jsr SoundTickHalf

            ;9/12
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_F4S) ***************
                lda #<SND_TONE_F4S
                sta TUNE_PTR_LO
                lda #>SND_TONE_F4S
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY1_2 (SND_TONE_C4S) ***************
                lda #<SND_TONE_C4S
                sta TUNE_PTR_LO
                lda #>SND_TONE_C4S
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune                 
            ;*************** sound to AY3_4 (SND_TONE_A3S_CHB) ***************
                lda #<SND_TONE_A3S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A3S_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   

            jsr SoundTickHalf

            ;9/12 break
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_F4S_OFF) ***************
                lda #<SND_TONE_F4S_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_F4S_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY1_2 (SND_TONE_C4S_OFF) ***************
                lda #<SND_TONE_C4S_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_C4S_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune                 
            ;*************** sound to AY3_4 (SND_TONE_A3S_CHB_OFF) ***************
                lda #<SND_TONE_A3S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A3S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   

            jsr SoundTickHalf

            ;10/12
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_A2S_CHB) ***************
                lda #<SND_TONE_A2S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A2S_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_A1S_CHC) ***************
                lda #<SND_TONE_A1S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_A1S_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

            jsr SoundTickHalf

            ;10/12 break
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_A2S_CHB_OFF) ***************
                lda #<SND_TONE_A2S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A2S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_A1S_CHC_OFF) ***************
                lda #<SND_TONE_A1S_CHC_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A1S_CHC_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

            jsr SoundTickHalf

            ;11/12
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_F4S) ***************
                lda #<SND_TONE_F4S
                sta TUNE_PTR_LO
                lda #>SND_TONE_F4S
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY1_2 (SND_TONE_C4S) ***************
                lda #<SND_TONE_C4S
                sta TUNE_PTR_LO
                lda #>SND_TONE_C4S
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune                 
            ;*************** sound to AY3_4 (SND_TONE_A2S_CHB) ***************
                lda #<SND_TONE_A2S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A2S_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_A1S_CHC) ***************
                lda #<SND_TONE_A1S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_A1S_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

            jsr SoundTickHalf

            ;11/12 break
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_F4S_OFF) ***************
                lda #<SND_TONE_F4S_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_F4S_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY1_2 (SND_TONE_C4S_OFF) ***************
                lda #<SND_TONE_C4S_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_C4S_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune                 
            ;*************** sound to AY3_4 (SND_TONE_A2S_CHB) ***************
                lda #<SND_TONE_A2S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A2S_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_A1S_CHC) ***************
                lda #<SND_TONE_A1S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_A1S_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

            jsr SoundTickHalf

            ;12/12
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_A2S_CHB) ***************
                lda #<SND_TONE_A2S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A2S_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_A1S_CHC) ***************
                lda #<SND_TONE_A1S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_A1S_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

            jsr SoundTickHalf

            ;12/12 break
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_A2S_CHB_OFF) ***************
                lda #<SND_TONE_A2S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A2S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_A1S_CHC_OFF) ***************
                lda #<SND_TONE_A1S_CHC_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A1S_CHC_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

            jsr SoundTickHalf


        Measure23_top:
            ;play twice
            ;lda #0
            ;sta PlaySong_MeasureLoop
        Measure23:

            ;1/12
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_G4) ***************
                lda #<SND_TONE_G4
                sta TUNE_PTR_LO
                lda #>SND_TONE_G4
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY1_2 (SND_TONE_D4S) ***************
                lda #<SND_TONE_D4S
                sta TUNE_PTR_LO
                lda #>SND_TONE_D4S
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune                 
            ;*************** sound to AY3_4 (SND_TONE_G3_CHB) ***************
                lda #<SND_TONE_G3_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_G3_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_D3S_CHC) ***************
                lda #<SND_TONE_D3S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_D3S_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_A2S_CHC) ***************
                lda #<SND_TONE_A2S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_A2S_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

            jsr SoundTickHalf

            ;1/12 break
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_G4_OFF) ***************
                lda #<SND_TONE_G4_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_G4_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY1_2 (SND_TONE_D4_OFF) ***************
                lda #<SND_TONE_D4_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_D4_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune                 
            ;*************** sound to AY3_4 (SND_TONE_G3_CHB) ***************
                lda #<SND_TONE_G3_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_G3_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_D3S_CHC) ***************
                lda #<SND_TONE_D3S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_D3S_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_A2S_CHC) ***************
                lda #<SND_TONE_A2S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_A2S_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

            jsr SoundTickHalf

            ;2/12
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_G3_CHB) ***************
                lda #<SND_TONE_G3_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_G3_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_D3S_CHC) ***************
                lda #<SND_TONE_D3S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_D3S_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_A2S_CHC) ***************
                lda #<SND_TONE_A2S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_A2S_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

            jsr SoundTickHalf

            ;2/12 break
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_G3_CHB) ***************
                lda #<SND_TONE_G3_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_G3_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_D3S_CHC) ***************
                lda #<SND_TONE_D3S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_D3S_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_A2S_CHC) ***************
                lda #<SND_TONE_A2S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_A2S_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

            jsr SoundTickHalf

            ;3/12
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_G3_CHB) ***************
                lda #<SND_TONE_G3_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_G3_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_D3S_CHC) ***************
                lda #<SND_TONE_D3S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_D3S_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_A2S_CHC) ***************
                lda #<SND_TONE_A2S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_A2S_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

            jsr SoundTickHalf

            ;3/12 break
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_G3_CHB_OFF) ***************
                lda #<SND_TONE_G3_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_G3_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_D3S_CHC_OFF) ***************
                lda #<SND_TONE_D3S_CHC_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_D3S_CHC_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_A2S_CHC_OFF) ***************
                lda #<SND_TONE_A2S_CHC_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A2S_CHC_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

            jsr SoundTickHalf

            ;4/12
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_G4) ***************
                lda #<SND_TONE_G4
                sta TUNE_PTR_LO
                lda #>SND_TONE_G4
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY1_2 (SND_TONE_D4S) ***************
                lda #<SND_TONE_D4S
                sta TUNE_PTR_LO
                lda #>SND_TONE_D4S
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune                 
            ;*************** sound to AY3_4 (SND_TONE_D3S_CHC) ***************
                lda #<SND_TONE_D3S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_D3S_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_D2S_CHC) ***************
                lda #<SND_TONE_D2S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_D2S_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

            jsr SoundTickHalf

            ;4/12 break
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_G4_OFF) ***************
                lda #<SND_TONE_G4_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_G4_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY1_2 (SND_TONE_D4_OFF) ***************
                lda #<SND_TONE_D4_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_D4_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune                 
            ;*************** sound to AY3_4 (SND_TONE_D3S_CHC_OFF) ***************
                lda #<SND_TONE_D3S_CHC_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_D3S_CHC_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_D2S_CHC_OFF) ***************
                lda #<SND_TONE_D2S_CHC_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_D2S_CHC_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

            jsr SoundTickHalf

            ;5/12
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_D3S_CHC) ***************
                lda #<SND_TONE_D3S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_D3S_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_D2S_CHC) ***************
                lda #<SND_TONE_D2S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_D2S_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

            jsr SoundTickHalf

            ;5/12 break
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_D3S_CHC) ***************
                lda #<SND_TONE_D3S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_D3S_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_D2S_CHC) ***************
                lda #<SND_TONE_D2S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_D2S_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

            jsr SoundTickHalf

            ;6/12
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_D3S_CHC) ***************
                lda #<SND_TONE_D3S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_D3S_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_D2S_CHC) ***************
                lda #<SND_TONE_D2S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_D2S_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

            jsr SoundTickHalf

            ;6/12 break
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_D3S_CHC_OFF) ***************
                lda #<SND_TONE_D3S_CHC_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_D3S_CHC_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_D2S_CHC_OFF) ***************
                lda #<SND_TONE_D2S_CHC_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_D2S_CHC_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

            jsr SoundTickHalf

            ;7/12
            ;*************** sound to AY3_4 (SND_TONE_G4) ***************
                lda #<SND_TONE_G4
                sta TUNE_PTR_LO
                lda #>SND_TONE_G4
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY1_2 (SND_TONE_G4) ***************
                lda #<SND_TONE_G4
                sta TUNE_PTR_LO
                lda #>SND_TONE_G4
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune                 
            ;*************** sound to AY3_4 (SND_TONE_D4S_CHC) ***************
                lda #<SND_TONE_D4S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_D4S_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_A3S_CHB) ***************
                lda #<SND_TONE_A3S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A3S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

            jsr SoundTickHalf

            ;7/12 break
            ;*************** sound to AY3_4 (SND_TONE_G4_OFF) ***************
                lda #<SND_TONE_G4_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_G4_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY1_2 (SND_TONE_G4) ***************
                lda #<SND_TONE_G4
                sta TUNE_PTR_LO
                lda #>SND_TONE_G4
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune                 
            ;*************** sound to AY3_4 (SND_TONE_D4S_CHC) ***************
                lda #<SND_TONE_D4S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_D4S_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_A3S_CHB) ***************
                lda #<SND_TONE_A3S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A3S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

            jsr SoundTickHalf

            ;8/12
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G4) ***************
                lda #<SND_TONE_G4
                sta TUNE_PTR_LO
                lda #>SND_TONE_G4
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune                 
            ;*************** sound to AY3_4 (SND_TONE_D4S_CHC) ***************
                lda #<SND_TONE_D4S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_D4S_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_A3S_CHB) ***************
                lda #<SND_TONE_A3S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A3S_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune

            jsr SoundTickHalf

            ;8/12 break
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G4) ***************
                lda #<SND_TONE_G4
                sta TUNE_PTR_LO
                lda #>SND_TONE_G4
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune                 
            ;*************** sound to AY3_4 (SND_TONE_D4S_CHC) ***************
                lda #<SND_TONE_D4S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_D4S_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_A3S_CHB) ***************
                lda #<SND_TONE_A3S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A3S_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune

            jsr SoundTickHalf

            ;9/12
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_G4) ***************
                lda #<SND_TONE_G4
                sta TUNE_PTR_LO
                lda #>SND_TONE_G4
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY1_2 (SND_TONE_D4S_CHC) ***************
                lda #<SND_TONE_D4S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_D4S_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune                 
            ;*************** sound to AY1_2 (SND_TONE_G4) ***************
                lda #<SND_TONE_G4
                sta TUNE_PTR_LO
                lda #>SND_TONE_G4
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune                 
            ;*************** sound to AY3_4 (SND_TONE_D4S_CHC) ***************
                lda #<SND_TONE_D4S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_D4S_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_A3S_CHB) ***************
                lda #<SND_TONE_A3S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A3S_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune

            jsr SoundTickHalf

            ;9/12 break
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_G4_OFF) ***************
                lda #<SND_TONE_G4_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_G4_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY1_2 (SND_TONE_D4S_CHC_OFF) ***************
                lda #<SND_TONE_D4S_CHC_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_D4S_CHC_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune                 
            ;*************** sound to AY1_2 (SND_TONE_G4_OFF) ***************
                lda #<SND_TONE_G4_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_G4_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune                 
            ;*************** sound to AY3_4 (SND_TONE_D4S_CHC_OFF) ***************
                lda #<SND_TONE_D4S_CHC_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_D4S_CHC_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_A3S_CHB_OFF) ***************
                lda #<SND_TONE_A3S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A3S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune

            jsr SoundTickHalf

            ;10/12
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_D3S_CHC) ***************
                lda #<SND_TONE_D3S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_D3S_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_D2S_CHC) ***************
                lda #<SND_TONE_D2S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_D2S_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

            jsr SoundTickHalf

            ;10/12 break
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_D3S_CHC_OFF) ***************
                lda #<SND_TONE_D3S_CHC_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_D3S_CHC_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_D2S_CHC_OFF) ***************
                lda #<SND_TONE_D2S_CHC_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_D2S_CHC_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

            jsr SoundTickHalf

            ;11/12
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_G4) ***************
                lda #<SND_TONE_G4
                sta TUNE_PTR_LO
                lda #>SND_TONE_G4
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY1_2 (SND_TONE_D4S) ***************
                lda #<SND_TONE_D4S
                sta TUNE_PTR_LO
                lda #>SND_TONE_D4S
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune                 
            ;*************** sound to AY3_4 (SND_TONE_D3S_CHC) ***************
                lda #<SND_TONE_D3S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_D3S_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_D2S_CHC) ***************
                lda #<SND_TONE_D2S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_D2S_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

            jsr SoundTickHalf

            ;11/12 break
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_G4_OFF) ***************
                lda #<SND_TONE_G4_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_G4_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY1_2 (SND_TONE_D4S_OFF) ***************
                lda #<SND_TONE_D4S_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_D4S_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune                 
            ;*************** sound to AY3_4 (SND_TONE_D3S_CHC) ***************
                lda #<SND_TONE_D3S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_D3S_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_D2S_CHC) ***************
                lda #<SND_TONE_D2S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_D2S_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

            jsr SoundTickHalf

            ;12/12
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_D3S_CHC) ***************
                lda #<SND_TONE_D3S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_D3S_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_D2S_CHC) ***************
                lda #<SND_TONE_D2S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_D2S_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

            jsr SoundTickHalf

            ;12/12 break
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_D3S_CHC_OFF) ***************
                lda #<SND_TONE_D3S_CHC_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_D3S_CHC_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_D2S_CHC_OFF) ***************
                lda #<SND_TONE_D2S_CHC_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_D2S_CHC_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

            jsr SoundTickHalf

        Measure24_top:
            ;play twice
            ;lda #0
            ;sta PlaySong_MeasureLoop
        Measure24:
            ;1/12
            ;*************** sound to AY1_2 (SND_TONE_A4_CHB) ***************
                lda #<SND_TONE_A4_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G4) ***************
                lda #<SND_TONE_G4
                sta TUNE_PTR_LO
                lda #>SND_TONE_G4
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_D4S) ***************
                lda #<SND_TONE_D4S
                sta TUNE_PTR_LO
                lda #>SND_TONE_D4S
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune                 
            ;*************** sound to AY3_4 (SND_TONE_B3_CHB) ***************
                lda #<SND_TONE_B3_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_B3_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY1_2 (SND_TONE_F3S_CHC) ***************
                lda #<SND_TONE_F3S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_F3S_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_D3S_CHC) ***************
                lda #<SND_TONE_D3S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_D3S_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   

            jsr SoundTickHalf

            ;1/12 break
            ;*************** sound to AY1_2 (SND_TONE_A4_CHB_OFF) ***************
                lda #<SND_TONE_A4_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G4_OFF) ***************
                lda #<SND_TONE_G4_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_G4_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_D4S_OFF) ***************
                lda #<SND_TONE_D4S_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_D4S_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune                 
            ;*************** sound to AY3_4 (SND_TONE_B3_CHB) ***************
                lda #<SND_TONE_B3_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_B3_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY1_2 (SND_TONE_F3S_CHC) ***************
                lda #<SND_TONE_F3S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_F3S_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_D3S_CHC) ***************
                lda #<SND_TONE_D3S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_D3S_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   

            jsr SoundTickHalf

            ;2/12
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_B3_CHB) ***************
                lda #<SND_TONE_B3_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_B3_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY1_2 (SND_TONE_F3S_CHC) ***************
                lda #<SND_TONE_F3S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_F3S_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_D3S_CHC) ***************
                lda #<SND_TONE_D3S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_D3S_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   

            jsr SoundTickHalf

            ;2/12 break
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_B3_CHB) ***************
                lda #<SND_TONE_B3_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_B3_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY1_2 (SND_TONE_F3S_CHC) ***************
                lda #<SND_TONE_F3S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_F3S_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_D3S_CHC) ***************
                lda #<SND_TONE_D3S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_D3S_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   

            jsr SoundTickHalf

            ;3/12
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_B3_CHB) ***************
                lda #<SND_TONE_B3_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_B3_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY1_2 (SND_TONE_F3S_CHC) ***************
                lda #<SND_TONE_F3S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_F3S_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_D3S_CHC) ***************
                lda #<SND_TONE_D3S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_D3S_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   

            jsr SoundTickHalf

            ;3/12 break
            ;*************** sound to AY1_2 (SND_TONE_A4_CHB_OFF) ***************
                lda #<SND_TONE_A4_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_B3_CHB_OFF) ***************
                lda #<SND_TONE_B3_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_B3_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY1_2 (SND_TONE_F3S_CHC_OFF) ***************
                lda #<SND_TONE_F3S_CHC_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_F3S_CHC_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_D3S_CHC_OFF) ***************
                lda #<SND_TONE_D3S_CHC_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_D3S_CHC_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   

            jsr SoundTickHalf

            ;4/12
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_F4S) ***************
                lda #<SND_TONE_F4S
                sta TUNE_PTR_LO
                lda #>SND_TONE_F4S
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_D4S) ***************
                lda #<SND_TONE_D4S
                sta TUNE_PTR_LO
                lda #>SND_TONE_D4S
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune                 
            ;*************** sound to AY1_2 (SND_TONE_B2_CHC) ***************
                lda #<SND_TONE_B2_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_B2_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_B1_CHC) ***************
                lda #<SND_TONE_B1_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_B1_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   

            jsr SoundTickHalf

            ;4/12 break
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_F4S_OFF) ***************
                lda #<SND_TONE_F4S_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_F4S_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_D4S_OFF) ***************
                lda #<SND_TONE_D4S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_D4S_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune                 
            ;*************** sound to AY1_2 (SND_TONE_B2_CHC_OFF) ***************
                lda #<SND_TONE_B2_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_B2_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_B1_CHC_OFF) ***************
                lda #<SND_TONE_B1_CHC_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_B1_CHC_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   

            jsr SoundTickHalf

            ;5/12
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_B2_CHC) ***************
                lda #<SND_TONE_B2_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_B2_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_B1_CHC) ***************
                lda #<SND_TONE_B1_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_B1_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   

            jsr SoundTickHalf

            ;5/12 break
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_B2_CHC) ***************
                lda #<SND_TONE_B2_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_B2_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_B1_CHC) ***************
                lda #<SND_TONE_B1_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_B1_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   

            jsr SoundTickHalf

            ;6/12
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_B2_CHC) ***************
                lda #<SND_TONE_B2_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_B2_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_B1_CHC) ***************
                lda #<SND_TONE_B1_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_B1_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   

            jsr SoundTickHalf

            ;6/12 break
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_B2_CHC_OFF) ***************
                lda #<SND_TONE_B2_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_B2_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_B1_CHC_OFF) ***************
                lda #<SND_TONE_B1_CHC_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_B1_CHC_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   

            jsr SoundTickHalf

            ;7/12
            ;*************** sound to AY3_4 (SND_TONE_B4) ***************
                lda #<SND_TONE_B4
                sta TUNE_PTR_LO
                lda #>SND_TONE_B4   
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune 
            ;*************** sound to AY1_2 (SND_TONE_D4S_CHC) ***************
                lda #<SND_TONE_D4S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_D4S_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune                 
            ;*************** sound to AY3_4 (SND_TONE_B3_CHB) ***************
                lda #<SND_TONE_B3_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_B3_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   

            jsr SoundTickHalf

            ;7/12 break
            ;intentionally empty

            jsr SoundTickHalf

            ;8/12
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_B4) ***************
                lda #<SND_TONE_B4
                sta TUNE_PTR_LO
                lda #>SND_TONE_B4   
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune 
            ;*************** sound to AY1_2 (SND_TONE_D4S_CHC) ***************
                lda #<SND_TONE_D4S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_D4S_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune                 
            ;*************** sound to AY3_4 (SND_TONE_B3_CHB) ***************
                lda #<SND_TONE_B3_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_B3_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   

            jsr SoundTickHalf

            ;8/12 break
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_B4) ***************
                lda #<SND_TONE_B4
                sta TUNE_PTR_LO
                lda #>SND_TONE_B4   
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune 
            ;*************** sound to AY1_2 (SND_TONE_D4S_CHC) ***************
                lda #<SND_TONE_D4S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_D4S_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune                 
            ;*************** sound to AY3_4 (SND_TONE_B3_CHB) ***************
                lda #<SND_TONE_B3_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_B3_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   

            jsr SoundTickHalf

            ;9/12
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_F4S) ***************
                lda #<SND_TONE_F4S
                sta TUNE_PTR_LO
                lda #>SND_TONE_F4S
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune   
            ;*************** sound to AY1_2 (SND_TONE_D4S_CHC) ***************
                lda #<SND_TONE_D4S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_D4S_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune                 
            ;*************** sound to AY3_4 (SND_TONE_B4) ***************
                lda #<SND_TONE_B4
                sta TUNE_PTR_LO
                lda #>SND_TONE_B4   
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune 
            ;*************** sound to AY3_4 (SND_TONE_D4S_CHC) ***************
                lda #<SND_TONE_D4S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_D4S_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune                 
            ;*************** sound to AY3_4 (SND_TONE_B3_CHB) ***************
                lda #<SND_TONE_B3_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_B3_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   

            jsr SoundTickHalf

            ;9/12 break
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_F4S_OFF) ***************
                lda #<SND_TONE_F4S_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_F4S_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune   
            ;*************** sound to AY1_2 (SND_TONE_D4S_CHC_OFF) ***************
                lda #<SND_TONE_D4S_CHC_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_D4S_CHC_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune                 
            ;*************** sound to AY3_4 (SND_TONE_B4_OFF) ***************
                lda #<SND_TONE_B4_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_B4_OFF   
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune 
            ;*************** sound to AY3_4 (SND_TONE_D4S_CHC_OFF) ***************
                lda #<SND_TONE_D4S_CHC_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_D4S_CHC_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune                 
            ;*************** sound to AY3_4 (SND_TONE_B3_CHB_OFF) ***************
                lda #<SND_TONE_B3_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_B3_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   

            jsr SoundTickHalf

            ;10/12
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_B2_CHB) ***************
                lda #<SND_TONE_B2_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_B2_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_B1_CHC) ***************
                lda #<SND_TONE_B1_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_B1_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   

            jsr SoundTickHalf

            ;10/12 break
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_B2_CHB_OFF) ***************
                lda #<SND_TONE_B2_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_B2_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_B1_CHC_OFF) ***************
                lda #<SND_TONE_B1_CHC_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_B1_CHC_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   

            jsr SoundTickHalf

            ;11/12
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_F4S) ***************
                lda #<SND_TONE_F4S
                sta TUNE_PTR_LO
                lda #>SND_TONE_F4S
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune   
            ;*************** sound to AY1_2 (SND_TONE_D4S_CHC) ***************
                lda #<SND_TONE_D4S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_D4S_CHC
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune                 
            ;*************** sound to AY3_4 (SND_TONE_B2_CHB) ***************
                lda #<SND_TONE_B2_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_B2_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_B1_CHC) ***************
                lda #<SND_TONE_B1_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_B1_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   

            jsr SoundTickHalf

            ;11/12 break
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_F4S_OFF) ***************
                lda #<SND_TONE_F4S_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_F4S_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune   
            ;*************** sound to AY1_2 (SND_TONE_D4S_CHC_OFF) ***************
                lda #<SND_TONE_D4S_CHC_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_D4S_CHC_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune                 
            ;*************** sound to AY3_4 (SND_TONE_B2_CHB) ***************
                lda #<SND_TONE_B2_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_B2_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_B1_CHC) ***************
                lda #<SND_TONE_B1_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_B1_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   

            jsr SoundTickHalf

            ;12/12
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_B2_CHB) ***************
                lda #<SND_TONE_B2_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_B2_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_B1_CHC) ***************
                lda #<SND_TONE_B1_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_B1_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   

            jsr SoundTickHalf

            ;12/12 break
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_B2_CHB_OFF) ***************
                lda #<SND_TONE_B2_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_B2_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_B1_CHC_OFF) ***************
                lda #<SND_TONE_B1_CHC_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_B1_CHC_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   

            jsr SoundTickHalf

        ;skipping measures 25-28 (essentially a repeat of 21-24)
        ;could add a loop if wanting to include 24-28

        Measure29_top:
        Measure29:
            ;1/24
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G4) ***************
                lda #<SND_TONE_G4
                sta TUNE_PTR_LO
                lda #>SND_TONE_G4
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_G3) ***************
                lda #<SND_TONE_G3
                sta TUNE_PTR_LO
                lda #>SND_TONE_G3
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_D3_CHB) ***************
                lda #<SND_TONE_D3_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_D3_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_G2_CHC) ***************
                lda #<SND_TONE_G2_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_G2_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   

            jsr SoundTickQuarter

            ;1/24 break
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G4_OFF) ***************
                lda #<SND_TONE_G4_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_G4_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_G3) ***************
                lda #<SND_TONE_G3
                sta TUNE_PTR_LO
                lda #>SND_TONE_G3
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_D3_CHB) ***************
                lda #<SND_TONE_D3_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_D3_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_G2_CHC) ***************
                lda #<SND_TONE_G2_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_G2_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   

            jsr SoundTickQuarter

            ;2/24
            ;*************** sound to AY1_2 (SND_TONE_D4_CHB) ***************
                lda #<SND_TONE_D4_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_D4_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_G3) ***************
                lda #<SND_TONE_G3
                sta TUNE_PTR_LO
                lda #>SND_TONE_G3
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_D3_CHB) ***************
                lda #<SND_TONE_D3_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_D3_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_G2_CHC) ***************
                lda #<SND_TONE_G2_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_G2_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   

            jsr SoundTickQuarter

            ;2/24 break
            ;*************** sound to AY1_2 (SND_TONE_D4_CHB_OFF) ***************
                lda #<SND_TONE_D4_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_D4_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_G3) ***************
                lda #<SND_TONE_G3
                sta TUNE_PTR_LO
                lda #>SND_TONE_G3
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_D3_CHB) ***************
                lda #<SND_TONE_D3_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_D3_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_G2_CHC) ***************
                lda #<SND_TONE_G2_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_G2_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   

            jsr SoundTickQuarter

            ;3/24
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G4) ***************
                lda #<SND_TONE_G4
                sta TUNE_PTR_LO
                lda #>SND_TONE_G4
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_G3) ***************
                lda #<SND_TONE_G3
                sta TUNE_PTR_LO
                lda #>SND_TONE_G3
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_D3_CHB) ***************
                lda #<SND_TONE_D3_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_D3_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_G2_CHC) ***************
                lda #<SND_TONE_G2_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_G2_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   

            jsr SoundTickQuarter

            ;3/24 break
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G4_OFF) ***************
                lda #<SND_TONE_G4_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_G4_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_G3) ***************
                lda #<SND_TONE_G3
                sta TUNE_PTR_LO
                lda #>SND_TONE_G3
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_D3_CHB) ***************
                lda #<SND_TONE_D3_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_D3_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_G2_CHC) ***************
                lda #<SND_TONE_G2_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_G2_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   

            jsr SoundTickQuarter

            ;4/24
            ;*************** sound to AY1_2 (SND_TONE_D4_CHB) ***************
                lda #<SND_TONE_D4_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_D4_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_G3) ***************
                lda #<SND_TONE_G3
                sta TUNE_PTR_LO
                lda #>SND_TONE_G3
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_D3_CHB) ***************
                lda #<SND_TONE_D3_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_D3_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_G2_CHC) ***************
                lda #<SND_TONE_G2_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_G2_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   

            jsr SoundTickQuarter

            ;4/24 break
            ;*************** sound to AY1_2 (SND_TONE_D4_CHB_OFF) ***************
                lda #<SND_TONE_D4_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_D4_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_G3) ***************
                lda #<SND_TONE_G3
                sta TUNE_PTR_LO
                lda #>SND_TONE_G3
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_D3_CHB) ***************
                lda #<SND_TONE_D3_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_D3_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_G2_CHC) ***************
                lda #<SND_TONE_G2_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_G2_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   

            jsr SoundTickQuarter

            ;5/24
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G4) ***************
                lda #<SND_TONE_G4
                sta TUNE_PTR_LO
                lda #>SND_TONE_G4
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_G3) ***************
                lda #<SND_TONE_G3
                sta TUNE_PTR_LO
                lda #>SND_TONE_G3
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_D3_CHB) ***************
                lda #<SND_TONE_D3_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_D3_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_G2_CHC) ***************
                lda #<SND_TONE_G2_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_G2_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   

            jsr SoundTickQuarter

            ;5/24 break
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G4_OFF) ***************
                lda #<SND_TONE_G4_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_G4_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_G3) ***************
                lda #<SND_TONE_G3
                sta TUNE_PTR_LO
                lda #>SND_TONE_G3
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_D3_CHB) ***************
                lda #<SND_TONE_D3_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_D3_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_G2_CHC) ***************
                lda #<SND_TONE_G2_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_G2_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   

            jsr SoundTickQuarter

            ;6/24
            ;*************** sound to AY1_2 (SND_TONE_D4_CHB) ***************
                lda #<SND_TONE_D4_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_D4_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_G3) ***************
                lda #<SND_TONE_G3
                sta TUNE_PTR_LO
                lda #>SND_TONE_G3
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_D3_CHB) ***************
                lda #<SND_TONE_D3_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_D3_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_G2_CHC) ***************
                lda #<SND_TONE_G2_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_G2_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   

            jsr SoundTickQuarter

            ;6/24 break
            ;*************** sound to AY1_2 (SND_TONE_D4_CHB_OFF) ***************
                lda #<SND_TONE_D4_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_D4_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_G3_OFF) ***************
                lda #<SND_TONE_G3_CHC_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_G3_CHC_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_D3_CHB_OFF) ***************
                lda #<SND_TONE_D3_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_D3_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_G2_CHC_OFF) ***************
                lda #<SND_TONE_G2_CHC_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_G2_CHC_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   

            jsr SoundTickQuarter

            ;7/24
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G4) ***************
                lda #<SND_TONE_G4
                sta TUNE_PTR_LO
                lda #>SND_TONE_G4
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_G2_CHB) ***************
                lda #<SND_TONE_G2_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_G2_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_G1) ***************
                lda #<SND_TONE_G1
                sta TUNE_PTR_LO
                lda #>SND_TONE_G1
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   

            jsr SoundTickQuarter

            ;7/24 break
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G4_OFF) ***************
                lda #<SND_TONE_G4_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_G4_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_G2_CHB) ***************
                lda #<SND_TONE_G2_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_G2_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_G1) ***************
                lda #<SND_TONE_G1
                sta TUNE_PTR_LO
                lda #>SND_TONE_G1
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   

            jsr SoundTickQuarter

            ;8/24
            ;*************** sound to AY1_2 (SND_TONE_D4_CHB) ***************
                lda #<SND_TONE_D4_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_D4_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_G2_CHB) ***************
                lda #<SND_TONE_G2_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_G2_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_G1) ***************
                lda #<SND_TONE_G1
                sta TUNE_PTR_LO
                lda #>SND_TONE_G1
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   

            jsr SoundTickQuarter

            ;8/24 break
            ;*************** sound to AY1_2 (SND_TONE_D4_CHB_OFF) ***************
                lda #<SND_TONE_D4_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_D4_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_G2_CHB_OFF) ***************
                lda #<SND_TONE_G2_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_G2_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_G1_OFF) ***************
                lda #<SND_TONE_G1_CHC_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_G1_CHC_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   

            jsr SoundTickQuarter

            ;9/24
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G4) ***************
                lda #<SND_TONE_G4
                sta TUNE_PTR_LO
                lda #>SND_TONE_G4
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_G2_CHB) ***************
                lda #<SND_TONE_G2_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_G2_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_G1) ***************
                lda #<SND_TONE_G1
                sta TUNE_PTR_LO
                lda #>SND_TONE_G1
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   

            jsr SoundTickQuarter

            ;9/24 break
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G4_OFF) ***************
                lda #<SND_TONE_G4_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_G4_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_G2_CHB) ***************
                lda #<SND_TONE_G2_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_G2_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_G1) ***************
                lda #<SND_TONE_G1
                sta TUNE_PTR_LO
                lda #>SND_TONE_G1
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   

            jsr SoundTickQuarter

            ;10/24
            ;*************** sound to AY1_2 (SND_TONE_D4_CHB) ***************
                lda #<SND_TONE_D4_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_D4_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_G2_CHB) ***************
                lda #<SND_TONE_G2_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_G2_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_G1) ***************
                lda #<SND_TONE_G1
                sta TUNE_PTR_LO
                lda #>SND_TONE_G1
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   

            jsr SoundTickQuarter

            ;10/24 break
            ;*************** sound to AY1_2 (SND_TONE_D4_CHB_OFF) ***************
                lda #<SND_TONE_D4_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_D4_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_G2_CHB_OFF) ***************
                lda #<SND_TONE_G2_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_G2_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_G1_OFF) ***************
                lda #<SND_TONE_G1_CHC_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_G1_CHC_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   

            jsr SoundTickQuarter

            ;11/24
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G4) ***************
                lda #<SND_TONE_G4
                sta TUNE_PTR_LO
                lda #>SND_TONE_G4
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune   

            jsr SoundTickQuarter

            ;11/24 break
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G4_OFF) ***************
                lda #<SND_TONE_G4_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_G4_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune   

            jsr SoundTickQuarter

            ;12/24
            ;*************** sound to AY1_2 (SND_TONE_D4_CHB) ***************
                lda #<SND_TONE_D4_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_D4_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

            jsr SoundTickQuarter

            ;12/24 break
            ;*************** sound to AY1_2 (SND_TONE_D4_CHB_OFF) ***************
                lda #<SND_TONE_D4_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_D4_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

            jsr SoundTickQuarter

            ;13/24
            ;*************** sound to AY1_2 (SND_TONE_A4_CHB) ***************
                lda #<SND_TONE_A4_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G4) ***************
                lda #<SND_TONE_G4
                sta TUNE_PTR_LO
                lda #>SND_TONE_G4
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_C4S) ***************
                lda #<SND_TONE_C4S
                sta TUNE_PTR_LO
                lda #>SND_TONE_C4S
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_A3S_CHB) ***************
                lda #<SND_TONE_A3S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A3S_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_G3_CHC) ***************
                lda #<SND_TONE_G3_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_G3_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   

            jsr SoundTickQuarter

            ;13/24 break
            ;*************** sound to AY1_2 (SND_TONE_A4_CHB_OFF) ***************
                lda #<SND_TONE_A4_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G4_OFF) ***************
                lda #<SND_TONE_G4_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_G4_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_C4S) ***************
                lda #<SND_TONE_C4S
                sta TUNE_PTR_LO
                lda #>SND_TONE_C4S
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_A3S_CHB) ***************
                lda #<SND_TONE_A3S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A3S_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_G3_CHC) ***************
                lda #<SND_TONE_G3_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_G3_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   

            jsr SoundTickQuarter

            ;14/24
            ;*************** sound to AY1_2 (SND_TONE_D4_CHB) ***************
                lda #<SND_TONE_D4_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_D4_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_C4S) ***************
                lda #<SND_TONE_C4S
                sta TUNE_PTR_LO
                lda #>SND_TONE_C4S
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_A3S_CHB) ***************
                lda #<SND_TONE_A3S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A3S_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_G3_CHC) ***************
                lda #<SND_TONE_G3_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_G3_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   

            jsr SoundTickQuarter

            ;14/24 break
            ;*************** sound to AY1_2 (SND_TONE_D4_CHB_OFF) ***************
                lda #<SND_TONE_D4_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_D4_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_C4S) ***************
                lda #<SND_TONE_C4S
                sta TUNE_PTR_LO
                lda #>SND_TONE_C4S
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_A3S_CHB) ***************
                lda #<SND_TONE_A3S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A3S_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_G3_CHC) ***************
                lda #<SND_TONE_G3_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_G3_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   

            jsr SoundTickQuarter

            ;15/24
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G4) ***************
                lda #<SND_TONE_G4
                sta TUNE_PTR_LO
                lda #>SND_TONE_G4
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_C4S) ***************
                lda #<SND_TONE_C4S
                sta TUNE_PTR_LO
                lda #>SND_TONE_C4S
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_A3S_CHB) ***************
                lda #<SND_TONE_A3S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A3S_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_G3_CHC) ***************
                lda #<SND_TONE_G3_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_G3_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   

            jsr SoundTickQuarter

            ;15/24 break
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G4_OFF) ***************
                lda #<SND_TONE_G4_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_G4_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_C4S) ***************
                lda #<SND_TONE_C4S
                sta TUNE_PTR_LO
                lda #>SND_TONE_C4S
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_A3S_CHB) ***************
                lda #<SND_TONE_A3S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A3S_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_G3_CHC) ***************
                lda #<SND_TONE_G3_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_G3_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   

            jsr SoundTickQuarter

            ;16/24
            ;*************** sound to AY1_2 (SND_TONE_D4_CHB) ***************
                lda #<SND_TONE_D4_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_D4_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_C4S) ***************
                lda #<SND_TONE_C4S
                sta TUNE_PTR_LO
                lda #>SND_TONE_C4S
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_A3S_CHB) ***************
                lda #<SND_TONE_A3S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A3S_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_G3_CHC) ***************
                lda #<SND_TONE_G3_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_G3_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   

            jsr SoundTickQuarter

            ;16/24 break
            ;*************** sound to AY1_2 (SND_TONE_D4_CHB_OFF) ***************
                lda #<SND_TONE_D4_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_D4_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_C4S) ***************
                lda #<SND_TONE_C4S
                sta TUNE_PTR_LO
                lda #>SND_TONE_C4S
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_A3S_CHB) ***************
                lda #<SND_TONE_A3S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A3S_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_G3_CHC) ***************
                lda #<SND_TONE_G3_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_G3_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   

            jsr SoundTickQuarter

            ;17/24
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G4) ***************
                lda #<SND_TONE_G4
                sta TUNE_PTR_LO
                lda #>SND_TONE_G4
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_C4S) ***************
                lda #<SND_TONE_C4S
                sta TUNE_PTR_LO
                lda #>SND_TONE_C4S
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_A3S_CHB) ***************
                lda #<SND_TONE_A3S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A3S_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_G3_CHC) ***************
                lda #<SND_TONE_G3_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_G3_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   

            jsr SoundTickQuarter

            ;17/24 break
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G4_OFF) ***************
                lda #<SND_TONE_G4_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_G4_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_C4S) ***************
                lda #<SND_TONE_C4S
                sta TUNE_PTR_LO
                lda #>SND_TONE_C4S
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_A3S_CHB) ***************
                lda #<SND_TONE_A3S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A3S_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_G3_CHC) ***************
                lda #<SND_TONE_G3_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_G3_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   

            jsr SoundTickQuarter

            ;18/24
            ;*************** sound to AY1_2 (SND_TONE_D4_CHB) ***************
                lda #<SND_TONE_D4_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_D4_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_C4S) ***************
                lda #<SND_TONE_C4S
                sta TUNE_PTR_LO
                lda #>SND_TONE_C4S
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_A3S_CHB) ***************
                lda #<SND_TONE_A3S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A3S_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_G3_CHC) ***************
                lda #<SND_TONE_G3_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_G3_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   

            jsr SoundTickQuarter

            ;18/24 break
            ;*************** sound to AY1_2 (SND_TONE_D4_CHB_OFF) ***************
                lda #<SND_TONE_D4_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_D4_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_C4S_OFF) ***************
                lda #<SND_TONE_C4S_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_C4S_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_A3S_CHB_OFF) ***************
                lda #<SND_TONE_A3S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A3S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_G3_CHC_OFF) ***************
                lda #<SND_TONE_G3_CHC_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_G3_CHC_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   

            jsr SoundTickQuarter

            ;19/24
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G4) ***************
                lda #<SND_TONE_G4
                sta TUNE_PTR_LO
                lda #>SND_TONE_G4
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_G2_CHB) ***************
                lda #<SND_TONE_G2_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_G2_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_G1) ***************
                lda #<SND_TONE_G1
                sta TUNE_PTR_LO
                lda #>SND_TONE_G1
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   

            jsr SoundTickQuarter

            ;19/24 break
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G4_OFF) ***************
                lda #<SND_TONE_G4_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_G4_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_G2_CHB) ***************
                lda #<SND_TONE_G2_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_G2_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_G1) ***************
                lda #<SND_TONE_G1
                sta TUNE_PTR_LO
                lda #>SND_TONE_G1
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   

            jsr SoundTickQuarter

            ;20/24
            ;*************** sound to AY1_2 (SND_TONE_D4_CHB) ***************
                lda #<SND_TONE_D4_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_D4_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_G2_CHB) ***************
                lda #<SND_TONE_G2_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_G2_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_G1) ***************
                lda #<SND_TONE_G1
                sta TUNE_PTR_LO
                lda #>SND_TONE_G1
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   

            jsr SoundTickQuarter

            ;20/24 break
            ;*************** sound to AY1_2 (SND_TONE_D4_CHB_OFF) ***************
                lda #<SND_TONE_D4_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_D4_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_G2_CHB_OFF) ***************
                lda #<SND_TONE_G2_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_G2_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_G1_OFF) ***************
                lda #<SND_TONE_G1_CHC_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_G1_CHC_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   

            jsr SoundTickQuarter

            ;21/24
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G4) ***************
                lda #<SND_TONE_G4
                sta TUNE_PTR_LO
                lda #>SND_TONE_G4
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_G2_CHB) ***************
                lda #<SND_TONE_G2_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_G2_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_G1) ***************
                lda #<SND_TONE_G1
                sta TUNE_PTR_LO
                lda #>SND_TONE_G1
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   

            jsr SoundTickQuarter

            ;21/24 break
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G4_OFF) ***************
                lda #<SND_TONE_G4_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_G4_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_G2_CHB) ***************
                lda #<SND_TONE_G2_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_G2_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_G1) ***************
                lda #<SND_TONE_G1
                sta TUNE_PTR_LO
                lda #>SND_TONE_G1
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   

            jsr SoundTickQuarter

            ;22/24
            ;*************** sound to AY1_2 (SND_TONE_D4_CHB) ***************
                lda #<SND_TONE_D4_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_D4_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_G2_CHB) ***************
                lda #<SND_TONE_G2_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_G2_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_G1) ***************
                lda #<SND_TONE_G1
                sta TUNE_PTR_LO
                lda #>SND_TONE_G1
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   

            jsr SoundTickQuarter

            ;22/24 break
            ;*************** sound to AY1_2 (SND_TONE_D4_CHB_OFF) ***************
                lda #<SND_TONE_D4_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_D4_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_G2_CHB_OFF) ***************
                lda #<SND_TONE_G2_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_G2_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_G1_OFF) ***************
                lda #<SND_TONE_G1_CHC_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_G1_CHC_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   

            jsr SoundTickQuarter

            ;23/24
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G4) ***************
                lda #<SND_TONE_G4
                sta TUNE_PTR_LO
                lda #>SND_TONE_G4
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune   

            jsr SoundTickQuarter

            ;23/24 break
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G4_OFF) ***************
                lda #<SND_TONE_G4_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_G4_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune   

            jsr SoundTickQuarter

            ;24/24
            ;*************** sound to AY1_2 (SND_TONE_D4_CHB) ***************
                lda #<SND_TONE_D4_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_D4_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

            jsr SoundTickQuarter

            ;24/24 break
            ;*************** sound to AY1_2 (SND_TONE_D4_CHB_OFF) ***************
                lda #<SND_TONE_D4_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_D4_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

            jsr SoundTickQuarter


            jsr Delay00
            jsr Delay00
            jsr Delay00
            jsr Delay00



        Measure30_top:
        Measure30:
            ;1/24
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G4) ***************
                lda #<SND_TONE_G4
                sta TUNE_PTR_LO
                lda #>SND_TONE_G4
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_C4S) ***************
                lda #<SND_TONE_C4S
                sta TUNE_PTR_LO
                lda #>SND_TONE_C4S
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_A3S_CHB) ***************
                lda #<SND_TONE_A3S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A3S_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_F3S_CHC) ***************
                lda #<SND_TONE_F3S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_F3S_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   

            jsr SoundTickQuarter

            ;1/24 break
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G4_OFF) ***************
                lda #<SND_TONE_G4_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_G4_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_C4S) ***************
                lda #<SND_TONE_C4S
                sta TUNE_PTR_LO
                lda #>SND_TONE_C4S
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_A3S_CHB) ***************
                lda #<SND_TONE_A3S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A3S_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_F3S_CHC) ***************
                lda #<SND_TONE_F3S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_F3S_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   

            jsr SoundTickQuarter

            ;2/24
            ;*************** sound to AY1_2 (SND_TONE_C4S_CHB) ***************
                lda #<SND_TONE_C4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_C4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_C4S) ***************
                lda #<SND_TONE_C4S
                sta TUNE_PTR_LO
                lda #>SND_TONE_C4S
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_A3S_CHB) ***************
                lda #<SND_TONE_A3S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A3S_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_F3S_CHC) ***************
                lda #<SND_TONE_F3S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_F3S_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   

            jsr SoundTickQuarter

            ;2/24 break
            ;*************** sound to AY1_2 (SND_TONE_C4S_CHB_OFF) ***************
                lda #<SND_TONE_C4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_C4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_C4S) ***************
                lda #<SND_TONE_C4S
                sta TUNE_PTR_LO
                lda #>SND_TONE_C4S
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_A3S_CHB) ***************
                lda #<SND_TONE_A3S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A3S_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_F3S_CHC) ***************
                lda #<SND_TONE_F3S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_F3S_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   

            jsr SoundTickQuarter

            ;3/24
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G4) ***************
                lda #<SND_TONE_G4
                sta TUNE_PTR_LO
                lda #>SND_TONE_G4
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_C4S) ***************
                lda #<SND_TONE_C4S
                sta TUNE_PTR_LO
                lda #>SND_TONE_C4S
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_A3S_CHB) ***************
                lda #<SND_TONE_A3S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A3S_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_F3S_CHC) ***************
                lda #<SND_TONE_F3S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_F3S_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   

            jsr SoundTickQuarter

            ;3/24 break
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G4_OFF) ***************
                lda #<SND_TONE_G4_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_G4_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_C4S) ***************
                lda #<SND_TONE_C4S
                sta TUNE_PTR_LO
                lda #>SND_TONE_C4S
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_A3S_CHB) ***************
                lda #<SND_TONE_A3S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A3S_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_F3S_CHC) ***************
                lda #<SND_TONE_F3S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_F3S_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   

            jsr SoundTickQuarter

            ;4/24
            ;*************** sound to AY1_2 (SND_TONE_C4S_CHB) ***************
                lda #<SND_TONE_C4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_C4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_C4S) ***************
                lda #<SND_TONE_C4S
                sta TUNE_PTR_LO
                lda #>SND_TONE_C4S
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_A3S_CHB) ***************
                lda #<SND_TONE_A3S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A3S_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_F3S_CHC) ***************
                lda #<SND_TONE_F3S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_F3S_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   

            jsr SoundTickQuarter

            ;4/24 break
            ;*************** sound to AY1_2 (SND_TONE_C4S_CHB_OFF) ***************
                lda #<SND_TONE_C4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_C4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_C4S) ***************
                lda #<SND_TONE_C4S
                sta TUNE_PTR_LO
                lda #>SND_TONE_C4S
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_A3S_CHB) ***************
                lda #<SND_TONE_A3S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A3S_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_F3S_CHC) ***************
                lda #<SND_TONE_F3S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_F3S_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   

            jsr SoundTickQuarter

            ;5/24
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G4) ***************
                lda #<SND_TONE_G4
                sta TUNE_PTR_LO
                lda #>SND_TONE_G4
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_C4S) ***************
                lda #<SND_TONE_C4S
                sta TUNE_PTR_LO
                lda #>SND_TONE_C4S
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_A3S_CHB) ***************
                lda #<SND_TONE_A3S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A3S_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_F3S_CHC) ***************
                lda #<SND_TONE_F3S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_F3S_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   

            jsr SoundTickQuarter

            ;5/24 break
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G4_OFF) ***************
                lda #<SND_TONE_G4_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_G4_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_C4S) ***************
                lda #<SND_TONE_C4S
                sta TUNE_PTR_LO
                lda #>SND_TONE_C4S
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_A3S_CHB) ***************
                lda #<SND_TONE_A3S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A3S_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_F3S_CHC) ***************
                lda #<SND_TONE_F3S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_F3S_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   

            jsr SoundTickQuarter

            ;6/24
            ;*************** sound to AY1_2 (SND_TONE_C4S_CHB) ***************
                lda #<SND_TONE_C4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_C4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_C4S) ***************
                lda #<SND_TONE_C4S
                sta TUNE_PTR_LO
                lda #>SND_TONE_C4S
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_A3S_CHB) ***************
                lda #<SND_TONE_A3S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A3S_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_F3S_CHC) ***************
                lda #<SND_TONE_F3S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_F3S_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   

            jsr SoundTickQuarter

            ;6/24 break
            ;*************** sound to AY1_2 (SND_TONE_C4S_CHB_OFF) ***************
                lda #<SND_TONE_C4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_C4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_C4S_OFF) ***************
                lda #<SND_TONE_C4S_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_C4S_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_A2_CHB_OFF) ***************
                lda #<SND_TONE_A2S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A2S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_A1S_CHC_OFF) ***************
                lda #<SND_TONE_A1S_CHC_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A1S_CHC_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   

            jsr SoundTickQuarter

            ;7/24
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G4) ***************
                lda #<SND_TONE_G4
                sta TUNE_PTR_LO
                lda #>SND_TONE_G4
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_A2_CHB) ***************
                lda #<SND_TONE_A2S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A2S_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_A1S_CHC) ***************
                lda #<SND_TONE_A1S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_A1S_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   

            jsr SoundTickQuarter

            ;7/24 break
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G4_OFF) ***************
                lda #<SND_TONE_G4_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_G4_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_A2_CHB) ***************
                lda #<SND_TONE_A2S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A2S_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_A1S_CHC) ***************
                lda #<SND_TONE_A1S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_A1S_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   

            jsr SoundTickQuarter

            ;8/24
            ;*************** sound to AY1_2 (SND_TONE_C4S_CHB) ***************
                lda #<SND_TONE_C4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_C4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_A2_CHB) ***************
                lda #<SND_TONE_A2S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A2S_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_A1S_CHC) ***************
                lda #<SND_TONE_A1S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_A1S_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   

            jsr SoundTickQuarter

            ;8/24 break
            ;*************** sound to AY1_2 (SND_TONE_C4S_CHB_OFF) ***************
                lda #<SND_TONE_C4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_C4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_A2_CHB_OFF) ***************
                lda #<SND_TONE_A2S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A2S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_A1S_CHC_OFF) ***************
                lda #<SND_TONE_A1S_CHC_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A1S_CHC_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   

            jsr SoundTickQuarter

            ;9/24
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G4) ***************
                lda #<SND_TONE_G4
                sta TUNE_PTR_LO
                lda #>SND_TONE_G4
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_A2_CHB) ***************
                lda #<SND_TONE_A2S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A2S_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_A1S_CHC) ***************
                lda #<SND_TONE_A1S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_A1S_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   

            jsr SoundTickQuarter

            ;9/24 break
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G4_OFF) ***************
                lda #<SND_TONE_G4_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_G4_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_A2_CHB) ***************
                lda #<SND_TONE_A2S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A2S_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_A1S_CHC) ***************
                lda #<SND_TONE_A1S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_A1S_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   

            jsr SoundTickQuarter

            ;10/24
            ;*************** sound to AY1_2 (SND_TONE_C4S_CHB) ***************
                lda #<SND_TONE_C4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_C4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_A2_CHB) ***************
                lda #<SND_TONE_A2S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A2S_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_A1S_CHC) ***************
                lda #<SND_TONE_A1S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_A1S_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   

            jsr SoundTickQuarter

            ;10/24 break
            ;*************** sound to AY1_2 (SND_TONE_C4S_CHB_OFF) ***************
                lda #<SND_TONE_C4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_C4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_A2_CHB_OFF) ***************
                lda #<SND_TONE_A2S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A2S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_A1S_CHC_OFF) ***************
                lda #<SND_TONE_A1S_CHC_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A1S_CHC_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   

            jsr SoundTickQuarter

            ;11/24
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G4) ***************
                lda #<SND_TONE_G4
                sta TUNE_PTR_LO
                lda #>SND_TONE_G4
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune   

            jsr SoundTickQuarter

            ;11/24 break
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G4_OFF) ***************
                lda #<SND_TONE_G4_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_G4_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune   

            jsr SoundTickQuarter

            ;12/24
            ;*************** sound to AY1_2 (SND_TONE_C4S_CHB) ***************
                lda #<SND_TONE_C4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_C4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

            jsr SoundTickQuarter

            ;12/24 break
            ;*************** sound to AY1_2 (SND_TONE_C4S_CHB_OFF) ***************
                lda #<SND_TONE_C4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_C4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

            jsr SoundTickQuarter

            ;13/24
            ;*************** sound to AY1_2 (SND_TONE_A4_CHB) ***************
                lda #<SND_TONE_A4_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G4) ***************
                lda #<SND_TONE_G4
                sta TUNE_PTR_LO
                lda #>SND_TONE_G4
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_F4S_CHC) ***************
                lda #<SND_TONE_F4S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_F4S_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune 
            ;*************** sound to AY3_4 (SND_TONE_C4S) ***************
                lda #<SND_TONE_C4S
                sta TUNE_PTR_LO
                lda #>SND_TONE_C4S
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_A3S_CHB) ***************
                lda #<SND_TONE_A3S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A3S_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   

  

            jsr SoundTickQuarter

            ;13/24 break
            ;*************** sound to AY1_2 (SND_TONE_A4_CHB_OFF) ***************
                lda #<SND_TONE_A4_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G4_OFF) ***************
                lda #<SND_TONE_G4_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_G4_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_F4S_CHC) ***************
                lda #<SND_TONE_F4S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_F4S_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune 
            ;*************** sound to AY3_4 (SND_TONE_C4S) ***************
                lda #<SND_TONE_C4S
                sta TUNE_PTR_LO
                lda #>SND_TONE_C4S
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_A3S_CHB) ***************
                lda #<SND_TONE_A3S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A3S_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   

            jsr SoundTickQuarter

            ;14/24
            ;*************** sound to AY1_2 (SND_TONE_C4S_CHB) ***************
                lda #<SND_TONE_C4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_C4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_F4S_CHC) ***************
                lda #<SND_TONE_F4S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_F4S_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune 
            ;*************** sound to AY3_4 (SND_TONE_C4S) ***************
                lda #<SND_TONE_C4S
                sta TUNE_PTR_LO
                lda #>SND_TONE_C4S
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_A3S_CHB) ***************
                lda #<SND_TONE_A3S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A3S_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   

            jsr SoundTickQuarter

            ;14/24 break
            ;*************** sound to AY1_2 (SND_TONE_C4S_CHB_OFF) ***************
                lda #<SND_TONE_C4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_C4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_F4S_CHC) ***************
                lda #<SND_TONE_F4S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_F4S_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune 
            ;*************** sound to AY3_4 (SND_TONE_C4S) ***************
                lda #<SND_TONE_C4S
                sta TUNE_PTR_LO
                lda #>SND_TONE_C4S
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_A3S_CHB) ***************
                lda #<SND_TONE_A3S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A3S_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   

            jsr SoundTickQuarter

            ;15/24
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G4) ***************
                lda #<SND_TONE_G4
                sta TUNE_PTR_LO
                lda #>SND_TONE_G4
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_F4S_CHC) ***************
                lda #<SND_TONE_F4S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_F4S_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune 
            ;*************** sound to AY3_4 (SND_TONE_C4S) ***************
                lda #<SND_TONE_C4S
                sta TUNE_PTR_LO
                lda #>SND_TONE_C4S
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_A3S_CHB) ***************
                lda #<SND_TONE_A3S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A3S_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   

            jsr SoundTickQuarter

            ;15/24 break
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G4_OFF) ***************
                lda #<SND_TONE_G4_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_G4_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_F4S_CHC) ***************
                lda #<SND_TONE_F4S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_F4S_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune 
            ;*************** sound to AY3_4 (SND_TONE_C4S) ***************
                lda #<SND_TONE_C4S
                sta TUNE_PTR_LO
                lda #>SND_TONE_C4S
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_A3S_CHB) ***************
                lda #<SND_TONE_A3S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A3S_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   

            jsr SoundTickQuarter

            ;16/24
            ;*************** sound to AY1_2 (SND_TONE_C4S_CHB) ***************
                lda #<SND_TONE_C4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_C4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_F4S_CHC) ***************
                lda #<SND_TONE_F4S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_F4S_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune 
            ;*************** sound to AY3_4 (SND_TONE_C4S) ***************
                lda #<SND_TONE_C4S
                sta TUNE_PTR_LO
                lda #>SND_TONE_C4S
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_A3S_CHB) ***************
                lda #<SND_TONE_A3S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A3S_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   

            jsr SoundTickQuarter

            ;16/24 break
            ;*************** sound to AY1_2 (SND_TONE_C4S_CHB_OFF) ***************
                lda #<SND_TONE_C4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_C4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_F4S_CHC) ***************
                lda #<SND_TONE_F4S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_F4S_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune 
            ;*************** sound to AY3_4 (SND_TONE_C4S) ***************
                lda #<SND_TONE_C4S
                sta TUNE_PTR_LO
                lda #>SND_TONE_C4S
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_A3S_CHB) ***************
                lda #<SND_TONE_A3S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A3S_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   

            jsr SoundTickQuarter

            ;17/24
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G4) ***************
                lda #<SND_TONE_G4
                sta TUNE_PTR_LO
                lda #>SND_TONE_G4
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_F4S_CHC) ***************
                lda #<SND_TONE_F4S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_F4S_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune 
            ;*************** sound to AY3_4 (SND_TONE_C4S) ***************
                lda #<SND_TONE_C4S
                sta TUNE_PTR_LO
                lda #>SND_TONE_C4S
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_A3S_CHB) ***************
                lda #<SND_TONE_A3S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A3S_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   

            jsr SoundTickQuarter

            ;17/24 break
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G4_OFF) ***************
                lda #<SND_TONE_G4_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_G4_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_F4S_CHC) ***************
                lda #<SND_TONE_F4S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_F4S_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune 
            ;*************** sound to AY3_4 (SND_TONE_C4S) ***************
                lda #<SND_TONE_C4S
                sta TUNE_PTR_LO
                lda #>SND_TONE_C4S
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_A3S_CHB) ***************
                lda #<SND_TONE_A3S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A3S_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   

            jsr SoundTickQuarter

            ;18/24
            ;*************** sound to AY1_2 (SND_TONE_C4S_CHB) ***************
                lda #<SND_TONE_C4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_C4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_F4S_CHC) ***************
                lda #<SND_TONE_F4S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_F4S_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune 
            ;*************** sound to AY3_4 (SND_TONE_C4S) ***************
                lda #<SND_TONE_C4S
                sta TUNE_PTR_LO
                lda #>SND_TONE_C4S
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_A3S_CHB) ***************
                lda #<SND_TONE_A3S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A3S_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   

            jsr SoundTickQuarter

            ;18/24 break
            ;*************** sound to AY1_2 (SND_TONE_C4S_CHB_OFF) ***************
                lda #<SND_TONE_C4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_C4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_F4S_CHC_OFF) ***************
                lda #<SND_TONE_F4S_CHC_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_F4S_CHC_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune 
            ;*************** sound to AY3_4 (SND_TONE_C4S_OFF) ***************
                lda #<SND_TONE_C4S_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_C4S_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_A3S_CHB_OFF) ***************
                lda #<SND_TONE_A3S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A3S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   

            jsr SoundTickQuarter

            ;19/24
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G4) ***************
                lda #<SND_TONE_G4
                sta TUNE_PTR_LO
                lda #>SND_TONE_G4
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_A2_CHB) ***************
                lda #<SND_TONE_A2S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A2S_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_A1S_CHC) ***************
                lda #<SND_TONE_A1S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_A1S_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   

            jsr SoundTickQuarter

            ;19/24 break
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G4_OFF) ***************
                lda #<SND_TONE_G4_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_G4_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_A2_CHB) ***************
                lda #<SND_TONE_A2S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A2S_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_A1S_CHC) ***************
                lda #<SND_TONE_A1S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_A1S_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   

            jsr SoundTickQuarter

            ;20/24
            ;*************** sound to AY1_2 (SND_TONE_C4S_CHB) ***************
                lda #<SND_TONE_C4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_C4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_A2_CHB) ***************
                lda #<SND_TONE_A2S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A2S_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_A1S_CHC) ***************
                lda #<SND_TONE_A1S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_A1S_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   

            jsr SoundTickQuarter

            ;20/24 break
            ;*************** sound to AY1_2 (SND_TONE_C4S_CHB_OFF) ***************
                lda #<SND_TONE_C4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_C4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_A2_CHB_OFF) ***************
                lda #<SND_TONE_A2S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A2S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_A1S_CHC_OFF) ***************
                lda #<SND_TONE_A1S_CHC_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A1S_CHC_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   

            jsr SoundTickQuarter

            ;21/24
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G4) ***************
                lda #<SND_TONE_G4
                sta TUNE_PTR_LO
                lda #>SND_TONE_G4
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_A2_CHB) ***************
                lda #<SND_TONE_A2S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A2S_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_A1S_CHC) ***************
                lda #<SND_TONE_A1S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_A1S_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   

            jsr SoundTickQuarter

            ;21/24 break
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB_OFF) ***************
                lda #<SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G4_OFF) ***************
                lda #<SND_TONE_G4_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_G4_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_A2_CHB) ***************
                lda #<SND_TONE_A2S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A2S_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_A1S_CHC) ***************
                lda #<SND_TONE_A1S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_A1S_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   

            jsr SoundTickQuarter

            ;22/24
            ;*************** sound to AY1_2 (SND_TONE_C4S_CHB) ***************
                lda #<SND_TONE_C4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_C4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_A2_CHB) ***************
                lda #<SND_TONE_A2S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A2S_CHB
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_A1S_CHC) ***************
                lda #<SND_TONE_A1S_CHC
                sta TUNE_PTR_LO
                lda #>SND_TONE_A1S_CHC
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   

            jsr SoundTickQuarter

            ;22/24 break
            ;*************** sound to AY1_2 (SND_TONE_C4S_CHB_OFF) ***************
                lda #<SND_TONE_C4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_C4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY3_4 (SND_TONE_A2_CHB_OFF) ***************
                lda #<SND_TONE_A2S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A2S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_A1S_CHC_OFF) ***************
                lda #<SND_TONE_A1S_CHC_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A1S_CHC_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   

            jsr SoundTickQuarter

            ;23/24
            ;*************** sound to AY1_2 (SND_TONE_A4S_CHB) ***************
                lda #<SND_TONE_A4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_A4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune
            ;*************** sound to AY1_2 (SND_TONE_G4) ***************
                lda #<SND_TONE_G4
                sta TUNE_PTR_LO
                lda #>SND_TONE_G4
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune   

            jsr SoundTickQuarter

            ;23/24 break
            ;*************** sound to AY3_4 (SND_TONE_A2_CHB_OFF) ***************
                lda #<SND_TONE_A2S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A2S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   
            ;*************** sound to AY3_4 (SND_TONE_A1S_CHC_OFF) ***************
                lda #<SND_TONE_A1S_CHC_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_A1S_CHC_OFF
                sta TUNE_PTR_HI
                jsr AY3_PlayTune
                jsr AY4_PlayTune   

            jsr SoundTickQuarter

            ;24/24
            ;*************** sound to AY1_2 (SND_TONE_C4S_CHB) ***************
                lda #<SND_TONE_C4S_CHB
                sta TUNE_PTR_LO
                lda #>SND_TONE_C4S_CHB
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

            jsr SoundTickQuarter

            ;24/24 break
            ;*************** sound to AY1_2 (SND_TONE_C4S_CHB_OFF) ***************
                lda #<SND_TONE_C4S_CHB_OFF
                sta TUNE_PTR_LO
                lda #>SND_TONE_C4S_CHB_OFF
                sta TUNE_PTR_HI
                jsr AY1_PlayTune
                jsr AY2_PlayTune

            jsr SoundTickQuarter


            jsr Delay00
            jsr Delay00
            jsr Delay00
            jsr Delay00
            
            
        MusicOut:
        ;*************** sound to AY1_2_3_4 (OFF) ***************
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
    
    SoundTick:
        jsr Delay00
        jsr Delay00
        jsr Delay00
        jsr Delay00
        rts
    SoundTickHalf:
        jsr Delay00
        jsr Delay00
        rts
    SoundTickQuarter:
        jsr Delay00
        rts
    SND_TONE_D5_CHC:
        .BYTE $04, $D4                      ;ChanA tone period fine tune
        .BYTE $05, $00                      ;ChanA tone period coarse tune
        .BYTE $08, SOUND_LEVEL_DEFAULT      ;ChanA amplitude    0F = fixed, max
        .BYTE $FF, $FF                      ; EOF
    SND_TONE_D5_CHC_OFF:
        .BYTE $04, $D4                      ;ChanA tone period fine tune
        .BYTE $05, $00                      ;ChanA tone period coarse tune
        .BYTE $08, $00                      ;ChanA amplitude    0F = fixed, max
        .BYTE $FF, $FF                      ; EOF
    SND_TONE_G4:
        .BYTE $00, $3E                      ;ChanA tone period fine tune
        .BYTE $01, $01                      ;ChanA tone period coarse tune
        .BYTE $08, SOUND_LEVEL_DEFAULT      ;ChanA amplitude    0F = fixed, max
        .BYTE $FF, $FF                      ; EOF
    SND_TONE_G4_OFF:
        .BYTE $00, $3E                      ;ChanA tone period fine tune
        .BYTE $01, $01                      ;ChanA tone period coarse tune
        .BYTE $08, $00                      ;ChanA amplitude    0F = fixed, max
        .BYTE $FF, $FF                      ; EOF
    SND_TONE_F4S:
        .BYTE $00, $51           ;ChanA tone period fine tune
        .BYTE $01, $01           ;ChanA tone period coarse tune
        .BYTE $08, SOUND_LEVEL_DEFAULT           ;ChanA amplitude    0F = fixed, max
        .BYTE $FF, $FF           ; EOF
    SND_TONE_F4S_OFF:
        .BYTE $00, $51           ;ChanA tone period fine tune
        .BYTE $01, $01           ;ChanA tone period coarse tune
        .BYTE $08, $00           ;ChanA amplitude    0F = fixed, max
        .BYTE $FF, $FF           ; EOF
    SND_TONE_F4S_CHC:
        .BYTE $04, $51                      ;ChanA tone period fine tune
        .BYTE $05, $01                      ;ChanA tone period coarse tune
        .BYTE $08, SOUND_LEVEL_DEFAULT      ;ChanA amplitude    0F = fixed, max
        .BYTE $FF, $FF                      ; EOF
    SND_TONE_F4S_CHC_OFF:
        .BYTE $04, $51                      ;ChanA tone period fine tune
        .BYTE $05, $01                      ;ChanA tone period coarse tune
        .BYTE $08, $00                      ;ChanA amplitude    0F = fixed, max
        .BYTE $FF, $FF                      ; EOF
    SND_TONE_D4S:
        .BYTE $00, $91                      ;ChanA tone period fine tune
        .BYTE $01, $01                      ;ChanA tone period coarse tune
        .BYTE $08, SOUND_LEVEL_DEFAULT      ;ChanA amplitude    0F = fixed, max
        .BYTE $FF, $FF                      ; EOF
    SND_TONE_D4S_OFF:
        .BYTE $00, $91                      ;ChanA tone period fine tune
        .BYTE $01, $01                      ;ChanA tone period coarse tune
        .BYTE $08, $00                      ;ChanA amplitude    0F = fixed, max
        .BYTE $FF, $FF                      ; EOF
    SND_TONE_D4S_CHC:
        .BYTE $04, $91                      ;ChanA tone period fine tune
        .BYTE $05, $01                      ;ChanA tone period coarse tune
        .BYTE $08, SOUND_LEVEL_DEFAULT      ;ChanA amplitude    0F = fixed, max
        .BYTE $FF, $FF                      ; EOF
    SND_TONE_D4S_CHC_OFF:
        .BYTE $04, $91                      ;ChanA tone period fine tune
        .BYTE $05, $01                      ;ChanA tone period coarse tune
        .BYTE $08, $00                      ;ChanA amplitude    0F = fixed, max
        .BYTE $FF, $FF                      ; EOF
    SND_TONE_D4:
        .BYTE $00, $A9                      ;ChanA tone period fine tune
        .BYTE $01, $01                      ;ChanA tone period coarse tune
        .BYTE $08, SOUND_LEVEL_DEFAULT      ;ChanA amplitude    0F = fixed, max
        .BYTE $FF, $FF                      ; EOF
    SND_TONE_D4_OFF:
        .BYTE $00, $A9                      ;ChanA tone period fine tune
        .BYTE $01, $01                      ;ChanA tone period coarse tune
        .BYTE $08, $00                      ;ChanA amplitude    0F = fixed, max
        .BYTE $FF, $FF                      ; EOF
    SND_TONE_D4_CHB:
        .BYTE $02, $A9                      ;ChanA tone period fine tune
        .BYTE $03, $01                      ;ChanA tone period coarse tune
        .BYTE $08, SOUND_LEVEL_DEFAULT      ;ChanA amplitude    0F = fixed, max
        .BYTE $FF, $FF                      ; EOF
    SND_TONE_D4_CHB_OFF:
        .BYTE $02, $A9                      ;ChanA tone period fine tune
        .BYTE $03, $01                      ;ChanA tone period coarse tune
        .BYTE $08, $00                      ;ChanA amplitude    0F = fixed, max
        .BYTE $FF, $FF                      ; EOF
    SND_TONE_C4S:
        .BYTE $00, $C2           ;ChanA tone period fine tune
        .BYTE $01, $01           ;ChanA tone period coarse tune
        .BYTE $08, SOUND_LEVEL_DEFAULT           ;ChanA amplitude    0F = fixed, max
        .BYTE $FF, $FF           ; EOF
    SND_TONE_C4S_OFF:
        .BYTE $00, $C2           ;ChanA tone period fine tune
        .BYTE $01, $01           ;ChanA tone period coarse tune
        .BYTE $08, $00           ;ChanA amplitude    0F = fixed, max
        .BYTE $FF, $FF           ; EOF
    SND_TONE_C4S_CHB:
        .BYTE $02, $C2           ;ChanA tone period fine tune
        .BYTE $03, $01           ;ChanA tone period coarse tune
        .BYTE $08, SOUND_LEVEL_DEFAULT           ;ChanA amplitude    0F = fixed, max
        .BYTE $FF, $FF           ; EOF
    SND_TONE_C4S_CHB_OFF:
        .BYTE $02, $C2           ;ChanA tone period fine tune
        .BYTE $03, $01           ;ChanA tone period coarse tune
        .BYTE $08, $00           ;ChanA amplitude    0F = fixed, max
        .BYTE $FF, $FF           ; EOF
    SND_TONE_B4:
        .BYTE $00, $FD                      ;ChanA tone period fine tune
        .BYTE $01, $00                      ;ChanA tone period coarse tune
        .BYTE $08, SOUND_LEVEL_DEFAULT      ;ChanA amplitude    0F = fixed, max
        .BYTE $FF, $FF                      ; EOF
    SND_TONE_B4_OFF:
        .BYTE $00, $FD                      ;ChanA tone period fine tune
        .BYTE $01, $00                      ;ChanA tone period coarse tune
        .BYTE $08, $00                      ;ChanA amplitude    0F = fixed, max
        .BYTE $FF, $FF                      ; EOF
    SND_TONE_A4S_CHB
        .BYTE $02, $0C                      ;ChanB tone period fine tune
        .BYTE $03, $01                      ;ChanB tone period coarse tune
        .BYTE $08, SOUND_LEVEL_DEFAULT      ;ChanB amplitude    0F = fixed, max
        .BYTE $FF, $FF                      ; EOF  
    SND_TONE_A4S_CHB_OFF
        .BYTE $02, $0C                      ;ChanB tone period fine tune
        .BYTE $03, $01                      ;ChanB tone period coarse tune
        .BYTE $08, $00                      ;ChanB amplitude    0F = fixed, max
        .BYTE $FF, $FF                      ; EOF  
    SND_TONE_A4_CHB:
        .BYTE $02, $1C           ;ChanA tone period fine tune
        .BYTE $03, $01           ;ChanA tone period coarse tune
        .BYTE $08, SOUND_LEVEL_DEFAULT           ;ChanA amplitude    0F = fixed, max
        .BYTE $FF, $FF           ; EOF
    SND_TONE_A4_CHB_OFF:
        .BYTE $02, $1C           ;ChanA tone period fine tune
        .BYTE $03, $01           ;ChanA tone period coarse tune
        .BYTE $08, $00           ;ChanA amplitude    0F = fixed, max
        .BYTE $FF, $FF           ; EOF        
    SND_TONE_A4:
        .BYTE $00, $1C           ;ChanA tone period fine tune
        .BYTE $01, $01           ;ChanA tone period coarse tune
        .BYTE $08, SOUND_LEVEL_DEFAULT           ;ChanA amplitude    0F = fixed, max
        .BYTE $FF, $FF           ; EOF
    SND_TONE_A4_OFF:
        .BYTE $00, $1C           ;ChanA tone period fine tune
        .BYTE $01, $01           ;ChanA tone period coarse tune
        .BYTE $08, $00           ;ChanA amplitude    0F = fixed, max
        .BYTE $FF, $FF           ; EOF        
    SND_TONE_B3:
        .BYTE $00, $FA           ;ChanA tone period fine tune
        .BYTE $01, $01           ;ChanA tone period coarse tune
        .BYTE $08, SOUND_LEVEL_DEFAULT           ;ChanA amplitude    0F = fixed, max
        .BYTE $FF, $FF           ; EOF
    SND_TONE_B3_CHB:
        .BYTE $02, $FA                      ;ChanA tone period fine tune
        .BYTE $03, $01                      ;ChanA tone period coarse tune
        .BYTE $08, SOUND_LEVEL_DEFAULT      ;ChanA amplitude    0F = fixed, max
        .BYTE $FF, $FF                      ; EOF
    SND_TONE_B3_CHB_OFF:
        .BYTE $02, $FA                      ;ChanA tone period fine tune
        .BYTE $03, $01                      ;ChanA tone period coarse tune
        .BYTE $08, $00                      ;ChanA amplitude    0F = fixed, max
        .BYTE $FF, $FF                      ; EOF
    SND_TONE_A3S:
        .BYTE $00, $18           ;ChanA tone period fine tune
        .BYTE $01, $02           ;ChanA tone period coarse tune
        .BYTE $08, SOUND_LEVEL_DEFAULT           ;ChanA amplitude    0F = fixed, max
        .BYTE $FF, $FF           ; EOF
    SND_TONE_A3S_CHB:
        .BYTE $02, $18                      ;ChanA tone period fine tune
        .BYTE $03, $02                      ;ChanA tone period coarse tune
        .BYTE $08, SOUND_LEVEL_DEFAULT      ;ChanA amplitude    0F = fixed, max
        .BYTE $FF, $FF                      ; EOF
    SND_TONE_A3S_CHB_OFF:
        .BYTE $02, $18                      ;ChanA tone period fine tune
        .BYTE $03, $02                      ;ChanA tone period coarse tune
        .BYTE $08, $00                      ;ChanA amplitude    0F = fixed, max
        .BYTE $FF, $FF                      ; EOF
    SND_TONE_G3:
        .BYTE $00, $7D                      ;ChanB tone period fine tune
        .BYTE $01, $02                      ;ChanB tone period coarse tune
        .BYTE $09, SOUND_LEVEL_DEFAULT      ;ChanB amplitude    0F = fixed, max
        .BYTE $FF, $FF                      ; EOF
    SND_TONE_G3_OFF:
        .BYTE $00, $7D                      ;ChanB tone period fine tune
        .BYTE $01, $02                      ;ChanB tone period coarse tune
        .BYTE $09, $00                      ;ChanB amplitude    0F = fixed, max
        .BYTE $FF, $FF                      ; EOF
    SND_TONE_G3_CHB:
        .BYTE $02, $7D                      ;ChanB tone period fine tune
        .BYTE $03, $02                      ;ChanB tone period coarse tune
        .BYTE $09, SOUND_LEVEL_DEFAULT      ;ChanB amplitude    0F = fixed, max
        .BYTE $FF, $FF                      ; EOF
    SND_TONE_G3_CHB_OFF:
        .BYTE $02, $7D                      ;ChanB tone period fine tune
        .BYTE $03, $02                      ;ChanB tone period coarse tune
        .BYTE $09, $00                      ;ChanB amplitude    0F = fixed, max
        .BYTE $FF, $FF                      ; EOF
    SND_TONE_G3_CHC:
        .BYTE $04, $7D                      ;ChanB tone period fine tune
        .BYTE $05, $02                      ;ChanB tone period coarse tune
        .BYTE $09, SOUND_LEVEL_DEFAULT      ;ChanB amplitude    0F = fixed, max
        .BYTE $FF, $FF                      ; EOF
    SND_TONE_G3_CHC_OFF:
        .BYTE $04, $7D                      ;ChanB tone period fine tune
        .BYTE $05, $02                      ;ChanB tone period coarse tune
        .BYTE $09, $00                      ;ChanB amplitude    0F = fixed, max
        .BYTE $FF, $FF                      ; EOF
    SND_TONE_F3S_CHC:
        .BYTE $04, $A3                      ;ChanB tone period fine tune
        .BYTE $05, $02                      ;ChanB tone period coarse tune
        .BYTE $09, SOUND_LEVEL_DEFAULT      ;ChanB amplitude    0F = fixed, max
        .BYTE $FF, $FF                      ; EOF
    SND_TONE_F3S_CHC_OFF:
        .BYTE $04, $A3                      ;ChanB tone period fine tune
        .BYTE $05, $02                      ;ChanB tone period coarse tune
        .BYTE $09, $00                      ;ChanB amplitude    0F = fixed, max
        .BYTE $FF, $FF                      ; EOF
    SND_TONE_D3S_CHB:
        .BYTE $02, $23           ;ChanB tone period fine tune
        .BYTE $03, $03           ;ChanB tone period coarse tune
        .BYTE $09, SOUND_LEVEL_DEFAULT           ;ChanB amplitude    0F = fixed, max
        .BYTE $FF, $FF           ; EOF
    SND_TONE_D3S_CHB_OFF:
        .BYTE $02, $23           ;ChanB tone period fine tune
        .BYTE $03, $03           ;ChanB tone period coarse tune
        .BYTE $09, $00           ;ChanB amplitude    0F = fixed, max
        .BYTE $FF, $FF           ; EOF
    SND_TONE_D3S_CHC:
        .BYTE $04, $23                      ;ChanB tone period fine tune
        .BYTE $05, $03                      ;ChanB tone period coarse tune
        .BYTE $09, SOUND_LEVEL_DEFAULT      ;ChanB amplitude    0F = fixed, max
        .BYTE $FF, $FF                          ; EOF
    SND_TONE_D3S_CHC_OFF:
        .BYTE $04, $23                      ;ChanB tone period fine tune
        .BYTE $05, $03                      ;ChanB tone period coarse tune
        .BYTE $09, $00                      ;ChanB amplitude    0F = fixed, max
        .BYTE $FF, $FF                      ; EOF
    SND_TONE_D3_CHB:
        .BYTE $02, $53                      ;ChanB tone period fine tune
        .BYTE $03, $03                      ;ChanB tone period coarse tune
        .BYTE $09, SOUND_LEVEL_DEFAULT      ;ChanB amplitude    0F = fixed, max
        .BYTE $FF, $FF                      ; EOF
    SND_TONE_D3_CHB_OFF:
        .BYTE $02, $53                      ;ChanB tone period fine tune
        .BYTE $03, $03                      ;ChanB tone period coarse tune
        .BYTE $09, $00                      ;ChanB amplitude    0F = fixed, max
        .BYTE $FF, $FF                      ; EOF
                     ; EOF
    SND_TONE_D3_CHC:
        .BYTE $04, $53                      ;ChanB tone period fine tune
        .BYTE $05, $03                      ;ChanB tone period coarse tune
        .BYTE $09, SOUND_LEVEL_DEFAULT      ;ChanB amplitude    0F = fixed, max
        .BYTE $FF, $FF                      ; EOF
    SND_TONE_D3_CHC_OFF:
        .BYTE $04, $53                      ;ChanB tone period fine tune
        .BYTE $05, $03                      ;ChanB tone period coarse tune
        .BYTE $09, $00                      ;ChanB amplitude    0F = fixed, max
        .BYTE $FF, $FF                      ; EOF
    SND_TONE_G2:
        .BYTE $00, $FB                      ;ChanB tone period fine tune
        .BYTE $01, $04                      ;ChanB tone period coarse tune
        .BYTE $09, SOUND_LEVEL_DEFAULT      ;ChanB amplitude    0F = fixed, max
        .BYTE $FF, $FF                      ; EOF
    SND_TONE_G2_OFF:
        .BYTE $00, $FB                      ;ChanB tone period fine tune
        .BYTE $01, $04                      ;ChanB tone period coarse tune
        .BYTE $09, $00                      ;ChanB amplitude    0F = fixed, max
        .BYTE $FF, $FF                      ; EOF
    SND_TONE_G2_CHB:
        .BYTE $02, $FB                      ;ChanB tone period fine tune
        .BYTE $03, $04                      ;ChanB tone period coarse tune
        .BYTE $09, SOUND_LEVEL_DEFAULT      ;ChanB amplitude    0F = fixed, max
        .BYTE $FF, $FF 
    SND_TONE_G2_CHB_OFF:
        .BYTE $02, $FB                      ;ChanB tone period fine tune
        .BYTE $03, $04                      ;ChanB tone period coarse tune
        .BYTE $09, $00                      ;ChanB amplitude    0F = fixed, max
        .BYTE $FF, $FF                      ; EOF
        .BYTE $FF, $FF                      ; EOF
    SND_TONE_G2_CHC:
        .BYTE $04, $FB                      ;ChanB tone period fine tune
        .BYTE $05, $04                      ;ChanB tone period coarse tune
        .BYTE $09, SOUND_LEVEL_DEFAULT      ;ChanB amplitude    0F = fixed, max
        .BYTE $FF, $FF 
    SND_TONE_G2_CHC_OFF:
        .BYTE $04, $FB                      ;ChanB tone period fine tune
        .BYTE $05, $04                      ;ChanB tone period coarse tune
        .BYTE $09, $00                      ;ChanB amplitude    0F = fixed, max
        .BYTE $FF, $FF                      ; EOF
    SND_TONE_D2S_CHC:
        .BYTE $04, $47                      ;ChanC tone period fine tune
        .BYTE $05, $06                      ;ChanC tone period coarse tune
        .BYTE $09, SOUND_LEVEL_DEFAULT      ;ChanC amplitude    0F = fixed, max
        .BYTE $FF, $FF                      ; EOF
    SND_TONE_D2S_CHC_OFF:
        .BYTE $04, $47                      ;ChanC tone period fine tune
        .BYTE $05, $06                      ;ChanC tone period coarse tune
        .BYTE $09, $00                      ;ChanC amplitude    0F = fixed, max
        .BYTE $FF, $FF                      ; EOF
    SND_TONE_B2_CHB:
        .BYTE $02, $F4           ;ChanA tone period fine tune
        .BYTE $03, $03           ;ChanA tone period coarse tune
        .BYTE $08, SOUND_LEVEL_DEFAULT           ;ChanA amplitude    0F = fixed, max
        .BYTE $FF, $FF           ; EOF
    SND_TONE_B2_CHB_OFF:
        .BYTE $02, $F4           ;ChanA tone period fine tune
        .BYTE $03, $03           ;ChanA tone period coarse tune
        .BYTE $08, $00           ;ChanA amplitude    0F = fixed, max
        .BYTE $FF, $FF           ; EOF
    SND_TONE_A2S_CHB:
        .BYTE $02, $30                      ;ChanB tone period fine tune
        .BYTE $03, $04                      ;ChanB tone period coarse tune
        .BYTE $08, SOUND_LEVEL_DEFAULT      ;ChanB amplitude    0F = fixed, max
        .BYTE $FF, $FF                      ; EOF
    SND_TONE_A2S_CHB_OFF:
        .BYTE $02, $30                      ;ChanB tone period fine tune
        .BYTE $03, $04                      ;ChanB tone period coarse tune
        .BYTE $08, $00                      ;ChanB amplitude    0F = fixed, max
        .BYTE $FF, $FF                      ; EOF
    SND_TONE_A2S_CHC:
        .BYTE $04, $30                      ;ChanB tone period fine tune
        .BYTE $05, $04                      ;ChanB tone period coarse tune
        .BYTE $08, SOUND_LEVEL_DEFAULT      ;ChanB amplitude    0F = fixed, max
        .BYTE $FF, $FF                      ; EOF
    SND_TONE_A2S_CHC_OFF:
        .BYTE $04, $30                      ;ChanB tone period fine tune
        .BYTE $05, $04                      ;ChanB tone period coarse tune
        .BYTE $08, $00                      ;ChanB amplitude    0F = fixed, max
        .BYTE $FF, $FF                      ; EOF
    SND_TONE_B1_CHC:
        .BYTE $04, $E8                      ;ChanC tone period fine tune
        .BYTE $05, $07                      ;ChanC tone period coarse tune
        .BYTE $0A, SOUND_LEVEL_DEFAULT      ;ChanC amplitude    0F = fixed, max
        .BYTE $FF, $FF                          ; EOF
    SND_TONE_B1_CHC_OFF:
        .BYTE $04, $E8                      ;ChanC tone period fine tune
        .BYTE $05, $07                      ;ChanC tone period coarse tune
        .BYTE $0A, $00                      ;ChanC amplitude    0F = fixed, max
        .BYTE $FF, $FF                      ; EOF
    SND_TONE_A1S_CHC:
        .BYTE $04, $61                      ;ChanC tone period fine tune
        .BYTE $05, $08                      ;ChanC tone period coarse tune
        .BYTE $0A, SOUND_LEVEL_DEFAULT      ;ChanC amplitude    0F = fixed, max
        .BYTE $FF, $FF                      ; EOF        
    SND_TONE_A1S_CHC_OFF:
        .BYTE $04, $61                      ;ChanC tone period fine tune
        .BYTE $05, $08                      ;ChanC tone period coarse tune
        .BYTE $0A, $00                      ;ChanC amplitude    0F = fixed, max
        .BYTE $FF, $FF                      ; EOF
    SND_TONE_G1_CHC:
        .BYTE $04, $F7                      ;ChanC tone period fine tune
        .BYTE $05, $09                      ;ChanC tone period coarse tune
        .BYTE $0A, SOUND_LEVEL_DEFAULT      ;ChanC amplitude    0F = fixed, max
        .BYTE $FF, $FF                      ; EOF        
    SND_TONE_G1_CHC_OFF:
        .BYTE $04, $F7                      ;ChanC tone period fine tune
        .BYTE $05, $09                      ;ChanC tone period coarse tune
        .BYTE $0A, $00                      ;ChanC amplitude    0F = fixed, max
        .BYTE $FF, $FF                      ; EOF
    SND_TONE_G1:
        .BYTE $00, $F7                      ;ChanC tone period fine tune
        .BYTE $01, $09                      ;ChanC tone period coarse tune
        .BYTE $0A, SOUND_LEVEL_DEFAULT      ;ChanC amplitude    0F = fixed, max
        .BYTE $FF, $FF                      ; EOF        
    SND_TONE_G1_OFF:
        .BYTE $00, $F7                      ;ChanC tone period fine tune
        .BYTE $01, $09                      ;ChanC tone period coarse tune
        .BYTE $0A, $00                      ;ChanC amplitude    0F = fixed, max
        .BYTE $FF, $FF                      ; EOF
