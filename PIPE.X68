; =============================================================================
; ASTEROID MANAGEMENT. IT IS AN AGENT.
; LOCAL MEMORY IS:
; +0 WORD X COORDINATE
; +2 WORD Y COORDINATE
; +4 WORD X SPEED
; +6 WORD Y SPEED
; +8 WORD PIPE SCORE
; =============================================================================

; -----------------------------------------------------------------------------
PIPINIT
; INITALIZES A PIPE
; INPUT    - A0 POINTER TO THE LOCAL MEMORY
; OUTPUT   - NONE
; MODIFIES - NONE
; NOTE     - ASSUMES SCRHEIGH IS GREATER THAN 255
; -----------------------------------------------------------------------------
            MOVE.W  D0,-(A7)
            CLR.W   8(A0)                   ; PIPE SCORED
            ADDQ.W  #1,(PIPCOUNT)           ; NUMBER OF PIPES +1
            MOVE.W  #SCRWIDTH,(A0)          ; X POSITION
            JSR     UTLRAND
            MOVE.W  D0,2(A0)                ; Y POSITION (PSEUDO-RANDOM)            
            MOVE.W  #PIPXSPD,4(A0)          ; X SPEED (PSEUDO-RANDOM)
            MOVE.W  (PIPCOUNT),D0
            EXT.L   D0
            AND.L   #$0000FFFF,D0
            CMP.W   #250,(PLRSCORE)
            BGE     .YMOVE                  ; IF PIPES>=20: ALL MOVING PIPES
            CMP.W   #100,(PLRSCORE)
            BLO     .EASY
            BTST    #0,D0                   ; WHILE 300>SCORE>=150: 1/2 MOVING PIPE
            BEQ     .YMOVE
            BRA     .YNOTMOV                  
.EASY       BTST    #1,D0                   ; WHILE SCORE<15: 1/4 MOVING PIPE
            BNE     .YNOTMOV
            BTST    #0,D0
            BEQ     .YMOVE
.YNOTMOV    MOVE.W  #0,6(A0)                ; Y SPEED (0)
            BRA     .END
.YMOVE      JSR     UTLRAND                 ; Y SPEED (PIPYSPD OR -PIPYSPD)
            CMP.W   #120,D0
            BGE     .YPLUS              
            MOVE.W  #-PIPYSPD,6(A0)
            BRA     .END
.YPLUS      MOVE.W  #PIPYSPD,6(A0)
.END        MOVE.W  (A7)+,D0
            RTS

; -----------------------------------------------------------------------------
PIPUPD
; UPDATES AN ASTEROID
; INPUT    - A0 POINTER TO THE LOCAL MEMORY
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            MOVE.W  D0,-(A7)
            MOVE.W  4(A0),D0                ; UPDATE COORDINATES
            SUB.W   D0,(A0)
            CMP.W   #-PIPWIDTH,(A0)
            BPL     .XPLUS                  ;KILL PIPES WHEN DISAPPEAR
            BRA     .KILL
.XPLUS      MOVE.W  6(A0),D0
            ADD.W   D0,2(A0)
            TST.W   2(A0)
            BLE     .BOUNCE
            CMP.W   #SCRHEIGH-HOLHEIGH,2(A0) 
            BLT     .CHKINPI
.BOUNCE     NEG.W   6(A0)                   ; PIPE REACHES FLOOR/ROOF AND BOUNCES
.CHKINPI    MOVE.W  (A0),D0
            CMP.W   #0,8(A0)
            BNE     .COLPLAY
            CMP.W   (PLRPOSX),D0
            BGT     .COLPLAY
            ADD.W   #PIPWIDTH,D0
            CMP.W   (PLRPOSX),D0
            BLO     .COLPLAY
            ADDQ.W  #5,(PLRSCORE)           ; ADD SCORE FOR PIPE
            ADDQ.W  #1,8(A0)                ; SET SCORED
.COLPLAY    MOVE.W  (A0),D0                 ; CHECK COLISIONS
            CLR.W   D1
            MOVE.W  #PIPWIDTH,D4
            MOVE.W  2(A0),D6
            MOVE.W  (PLRPOSX),D2
            MOVE.W  (PLRPOSY),D3
            MOVE.W  #PLRWIDTH,D5
            MOVE.W  #PLRHEIGH,D7
            JSR     UTLCHCOL                ;CHECK COLISION UPPER PIPE
            TST.B   D0
            BNE     .DEATH
            
            MOVE.W  (A0),D0
            MOVE.W  2(A0),D1
            ADD.W   #HOLHEIGH,D1
            MOVE.W  #PIPWIDTH,D4
            MOVE.W  #SCRHEIGH,D6
            SUB.W   2(A0),D6
            MOVE.W  (PLRPOSX),D2
            MOVE.W  (PLRPOSY),D3
            MOVE.W  #PLRWIDTH,D5
            MOVE.W  #PLRHEIGH,D7
            JSR     UTLCHCOL                ;CHECK COLISION WITH LOWER PIPE

            TST.B   D0
            BEQ     .END
.DEATH      MOVE.B  #1,(PLRDEAD)
.END        MOVE.W  (A7)+,D0
            RTS
.KILL       JSR     AGLKILL
            BRA     .COLPLAY


; -----------------------------------------------------------------------------
PIPPLOT
; PLOTS AN ASTEROID
; INPUT    - A0 POINTER TO THE LOCAL MEMORY
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            UTLSPEN #PIPPENCL
            UTLSFIL #PIPFILCL
            MOVEM.W D1-D4,-(A7)
            ;UPPER PIPE
            MOVE.W  (A0),D1
            CLR.W   D2
            MOVE.W  2(A0),D4
            MOVE.W  D1,D3
            ADD.W   #PIPWIDTH,D3
            MOVE.B  #87,D0
            TRAP    #15
            ;LOWER PIPE
            MOVE.W  D4,D2
            ADD.W   #HOLHEIGH,D2
            MOVE.W  #SCRHEIGH,D4
            TRAP    #15
            ;UPPER PIPE LOWER EDGE
            MOVE.W  (A0),D1
            SUB.W   #PIPEDGE,D1 
            MOVE.W  2(A0),D2
            SUB.W   #PIPEDGE,D2
            MOVE.W  2(A0),D4
            MOVE.W  (A0),D3
            ADD.W   #PIPEDGE,D3
            ADD.W   #PIPWIDTH,D3
            TRAP    #15
            ;LOWER PIPE UPPER EDGE
            ADD.W    #HOLHEIGH,D2
            ADD.W    #HOLHEIGH,D4
            TRAP    #15
            
            MOVEM.W (A7)+,D1-D4
            RTS








*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
