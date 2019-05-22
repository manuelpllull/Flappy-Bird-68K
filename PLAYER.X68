; =============================================================================
; PLAYER MANAGEMENT
; =============================================================================

; -----------------------------------------------------------------------------
PLRINIT
; INITIALIZES THE PLAYER
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            MOVE.W  #SCRWIDTH/2,(PLRPOSX)
            MOVE.W  #SCRHEIGH-200,(PLRPOSY)
            CLR.W   (PLRSPDY)
            CLR.W   (PIPCOUNT)
            CLR.W   (PLRSCORE)
            CLR.W   (PLRDEAD)

; -----------------------------------------------------------------------------
PLRUPD
; UPDATES THE PLAYER MOTION
; INPUT    - NONE (ACCESSES KBDVAL AND KBDEDGE)
; OUTPUT   - NONE (MODIFIES PLAYER DATA)
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            MOVE.L  D0,-(A7)
            MOVE.W  (PLRSPDY),D0
            ADD.W   (PLRPOSY),D0
            CMP.W   #SCRHEIGH-PLRHEIGH,D0
            BLO     .BOUNDUP
            BRA     .DEATH                  ; GAME OVER IF BENEATH THE BOTTOM LIMIT
.BOUNDUP    CMP.W   #0,D0
            BGT     .BOUNDWN
            BRA     .DEATH                  ; GAME OVER IF OVER THE TOP LIMIT
.BOUNDWN    MOVE.W  D0,(PLRPOSY)
            ADD.W   #PLRACCY,(PLRSPDY)
            CMP.B   #0,(PLRDEAD)
            BEQ     .NOTOUCH
            CLR.B   (PLRDEAD)
.DEATH      MOVE.W  #STAGOVR,(STANEXT)       ; GAME OVER STATE
            UTLSND  .EXPSOUN                 ;PLAY EXPLOSION SOUND
.NOTOUCH    MOVE.L  (A7)+,D0
            MOVE.W  D1,-(A7)
            MOVE.B  (KBDVAL),D1             ; PERFORM MOTION
            ROR.B   #1,D1                   ; CHECK LEFT ARROW
            BCC     .CHKUP
            SUB.W   #PLRSPDX,(PLRPOSX)
            TST.W   (PLRPOSX)
            BGE     .CHKUP
            CLR.W   (PLRPOSX)
.CHKUP      ROR.B   #1,D1                   ; CHECK UP ARROW
            BCC     .CHKRT
            BTST.B  #KBDBITUP,(KBDEDGE)
            BEQ     .CHKRT
            MOVE.W   #-10,(PLRSPDY)
.CHKRT      ROR.B   #1,D1                   ; CHECK RIGHT ARROW
            BCC     .MDONE
            ADD.W   #PLRSPDX,(PLRPOSX)
            CMP.W   #SCRWIDTH-PLRWIDTH,(PLRPOSX)
            BLE     .MDONE
            MOVE.W  #SCRWIDTH-PLRWIDTH,(PLRPOSX)
.MDONE     MOVE.W  (A7)+,D1
            RTS
.EXPSOUN    DC.L    'Explosion.wav',0            ; EXPLOSION SOUND

; -----------------------------------------------------------------------------
PLRPLOT
; PLOTS THE PLAYER ITS LIFE AND THE SCORE
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            MOVEM.L D0-D4,-(A7)
            MOVE.L  #PLRCOLOR,D1            ;SET COLOR OF PLAYER
            MOVE.B  #80,D0
            TRAP    #15
            ADDQ.B  #1,D0
            TRAP    #15
            MOVE.W  (PLRPOSX),D1            ; PLOT THE PLAYER
            MOVE.W  (PLRPOSY),D2
            MOVE.W  D1,D3
            MOVE.W  D2,D4
            ADD.W   #PLRWIDTH,D3
            ADD.W   #PLRHEIGH,D4
            MOVE.B  #88,D0
            TRAP    #15
            SUB.W   #PLRWIDTH/2,D3
            MOVE.B  #87,D0
            TRAP    #15
            
            ;PLOT EYE OF CHARACTER
            MOVE.L  #$00000000,D1            ; SET COLOR
            MOVE.B  #80,D0
            TRAP    #15
            ADDQ.B  #1,D0
            TRAP    #15

            MOVE.W  (PLRPOSX),D1            ; SET BOUNDS
            ADD.W   #PLRWIDTH-10,D1
            MOVE.W  (PLRPOSX),D3
            ADD.W   #PLRWIDTH-6,D3
            MOVE.W  (PLRPOSY),D2
            ADD.W   #PLRHEIGH/2-10,D2
            MOVE.W  (PLRPOSY),D4
            ADD.W   #PLRHEIGH/2-6,D4
            MOVE.B  #88,D0
            TRAP    #15
            
            ; PLOT THE SCORE TEXT
            UTLSPEN #PLRTXTCL
            UTLSFIL #$00000000
            UTLLOCT PLRTXTX,PLRTXTY
            LEA     .SCORESTR,A1
            CLR.L   D1
            MOVE.W  (PLRSCORE),D1
            MOVE.B  #17,D0
            TRAP    #15
            MOVEM.L (A7)+,D0-D4
            RTS
.SCORESTR   DC.B    'SCORE: ',0









































*~Font name~Courier New~
*~Font size~10~
*~Tab type~0~
*~Tab size~4~
