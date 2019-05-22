; =============================================================================
; AGENT MANAGEMENT
; EACH AGENT HAS A DATA BLOCK FROM DMM AS FOLLOWS:
; +0 - LONG : UPDATE SUBROUTINE POINTER
; +4 - LONG : PLOT SUBROUTINE POINTER
; +8:END    : DATA (AGENT SPECIFIC)
; =============================================================================

; -----------------------------------------------------------------------------
AGLADD
; CREATES A NEW AGENT
; INPUT    - A1 - POINTER TO AGENT INIT FUNCTION
;            A2 - POINTER TO AGENT UPDATE FUNCTION
;            A3 - POINTER TO AGENT PLOT FUNCTION
;            D0 - AGENT TYPE (USED AS OWNED BY DMM)
;            D1 - AGENT INITIALIZATION PARAMETER 1
;            D2 - AGENT INITIALIZATION PARAMETER 2
;            D3 - AGENT INITIALIZATION PARAMETER 3
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            MOVE.L  A0,-(A7)
            JSR     DMMALLOC
            CMP.L   #0,A0
            BEQ     .END
            MOVE.L  A2,(A0)+
            MOVE.L  A3,(A0)+
            JSR     (A1)
.END        MOVE.L  (A7)+,A0
            RTS

; -----------------------------------------------------------------------------
AGLUPD
; UPDATES THE AGENT LIST. PRIOR TO CALLING THE UPDATE FUNCTIONS, A0 IS SET
; TO THE DATA BLOCK OF THE CORRESPONDING SLOT.
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            MOVEM.L A0-A1,-(A7)
            JSR     DMMFIRST
.LOOP       CMP.L   #0,A0
            BEQ     .END
            MOVE.L  (A0),A1
            ADD.L   #8,A0
            JSR     (A1)
            JSR     DMMNEXT
            BRA     .LOOP
.END        MOVEM.L (A7)+,A0-A1
            RTS

; -----------------------------------------------------------------------------
AGLPLOT
; PLOTS THE AGENT LIST. PRIOR TO CALLING THE UPDATE FUNCTIONS, A0 IS SET
; TO THE DATA BLOCK OF THE CORRESPONDING SLOT.
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            MOVEM.L A0-A1,-(A7)
            JSR     DMMFIRST
.LOOP       CMP.L   #0,A0
            BEQ     .END
            MOVE.L  4(A0),A1
            ADD.L   #8,A0
            JSR     (A1)
            JSR     DMMNEXT
            BRA     .LOOP
.END        MOVEM.L (A7)+,A0-A1
            RTS

; -----------------------------------------------------------------------------
AGLKILL     EQU     DMMFREE
; KILLS THE AGENT BY RELEASING ITS MEMORY
; INPUT    - A0 POINTER WITHIN THE AGENT MEMORY
; OUTPUT   - NONE
; MODIFIES - NONE
; NOTE     - IT IS JUST A WRAPPER FOR DMMFREE
; -----------------------------------------------------------------------------


*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
