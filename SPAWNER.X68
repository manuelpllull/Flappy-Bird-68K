; =============================================================================
; SPAWNER MANAGEMENT.
; =============================================================================

; -----------------------------------------------------------------------------
SPWUPD
; UPDATES THE SPAWNER
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            MOVEM.L D0/A1-A3,-(A7)
            ;SPAWN COINS
            MOVE.B  (SCRCYCCT),D0
            AND     #$1F,D0                 ; EVERY 32 CYCLES
            BNE     .PIPES
            LEA     COININIT,A1
            LEA     COINUPD,A2
            LEA     COINPLOT,A3
            MOVE.W  #COINTYPE,D0
            JSR     AGLADD
            ;SPAWN PIPES
.PIPES      MOVE.B  (SCRCYCCT),D0
            AND     #$3F,D0                 ; EVERY 64 CYCLES
            BNE     .END
            LEA     PIPINIT,A1
            LEA     PIPUPD,A2
            LEA     PIPPLOT,A3
            MOVE.W  #ASTTYPE,D0
            JSR     AGLADD
.END        MOVEM.L (A7)+,D0/A1-A3
            RTS





*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
