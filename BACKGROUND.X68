;------------------------------------------------------------------------------
; BACKGROUND
;------------------------------------------------------------------------------

; -----------------------------------------------------------------------------
BACKGPLOT
; PLOTS BACKGROUND
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            UTLSPEN #$00000000
            UTLSFIL #$00EFCE87
            MOVEM.W D1-D4,-(A7)
            CLR.W   D1
            CLR.W   D2
            MOVE.W  #SCRHEIGH,D4
            MOVE.W  #SCRWIDTH,D3
            MOVE.B  #87,D0
            TRAP    #15
            
            MOVEM.W (A7)+,D1-D4
            RTS
*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
