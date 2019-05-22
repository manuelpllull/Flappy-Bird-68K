; =============================================================================
; GAME VARS
; =============================================================================

; --- GAME STATE RELATED VARIABLES --------------------------------------------

STACUR      DS.W    1                       ; CURRENT GAME STATE
STANEXT     DS.W    1                       ; NEXT GAME STATE

; --- PLAYER RELATED VARIABLES ------------------------------------------------

PLRPOSX     DS.W    1                       ; PLAYER X POSITION (PIXELS)
PLRPOSY     DS.W    1                       ; PLAYER Y POSITION (PIXELS)
PLRSPDY     DS.W    1                       ; PLAYER Y SPEED (PIXELS/FRAME)
PLRSCORE    DS.W    1                       ; PLAYER SCORE
PLRDEAD     DS.B    1                       ; BIT0: UPD DAMAGE, BIT1 PLOT DMG
            DS.W    0
            
; --- CYCLE COUNTERS ---------------------------------------------------------

CYCLEUPD    DS.L    1                       ;NUMBER OF CYCLES OF INTERRUPTIONS
CYCLEPLT    DS.L    1                       ;NUMBER OF CYCLES OF DRAWING

; --- UTILITY VARIABLES ------------------------------------------------------

UTLRNDIX    DS.B    1                       ; NEXT INDEX TO RANDOM NUMBER
            DS.W    0
            
; --- GAME COUNTERS ----------------------------------------------------------

PIPCOUNT    DS.W    1








*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
