; =============================================================================
; COIN MANAGEMENT. IT IS AN AGENT.
; LOCAL MEMORY IS:
; +0 WORD X COORDINATE
; +2 WORD Y COORDINATE
; +4 WORD X SPEED
; +6 WORD Y SPEED
; =============================================================================

; -----------------------------------------------------------------------------
COININIT
; INITALIZES A COIN
; INPUT    - A0 POINTER TO THE LOCAL MEMORY
; OUTPUT   - NONE
; MODIFIES - NONE
; NOTE     - ASSUMES SCRHEIGH IS GREATER THAN 255
; -----------------------------------------------------------------------------
            MOVE.W  D0,-(A7)
            JSR     UTLRAND
            MOVE.W  #SCRWIDTH,(A0)          ; X POSITION
            MOVE.W  D0,2(A0)                ; Y POSITION (PSEUDO-RANDOM)
            MOVE.W  #COINXSPD,4(A0)         ; X SPEED: PIPXSPD (SAME AS PIPES)
            CLR.W   6(A0)                   ; Y SPEED (0)
            MOVE.W  (A7)+,D0
            RTS

; -----------------------------------------------------------------------------
COINUPD
; UPDATES A COIN
; INPUT    - A0 POINTER TO THE LOCAL MEMORY
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            MOVE.W  D0,-(A7)
            MOVE.W  4(A0),D0                ; UPDATE COORDINATES
            SUB.W   D0,(A0)
            CMP.W   #-COINSIZE,(A0)
            BPL     .XPLUS                  ;KILL PIPES WHEN DISAPPEAR
            BRA     .KILL
.XPLUS      MOVE.W  (A0),D0
            MOVE.W  2(A0),D1
            MOVE.W  #COINSIZE,D4
            MOVE.W  D4,D6
            MOVE.W  (PLRPOSX),D2
            MOVE.W  (PLRPOSY),D3
            MOVE.W  #PLRWIDTH,D5
            MOVE.W  #PLRHEIGH,D7
            JSR     UTLCHCOL
            TST.B   D0
            BEQ     .END
            ADD.W   #10,(PLRSCORE)
            UTLSND  .COINSOU                ;PLAY COIN SOUND
            BRA     .KILL                   ;KILL AGENT
.END        MOVE.W  (A7)+,D0
            RTS
.KILL       JSR     AGLKILL
            BRA     .END
.COINSOU    DC.L    'Coin.wav',0            ; COIN SOUND

; -----------------------------------------------------------------------------
COINPLOT
; PLOTS A COIN
; INPUT    - A0 POINTER TO THE LOCAL MEMORY
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            UTLSPEN #CNPENCL
            UTLSFIL #CNFILCL
            MOVEM.W D1-D4,-(A7)
            MOVE.W  (A0),D1
            MOVE.W  2(A0),D2
            MOVE.W  D1,D3
            MOVE.W  D2,D4
            ADD.W   #COINSIZE,D3
            ADD.W   #COINSIZE,D4
            MOVE.B  #88,D0
            TRAP    #15
            MOVEM.W (A7)+,D1-D4
            RTS





*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
