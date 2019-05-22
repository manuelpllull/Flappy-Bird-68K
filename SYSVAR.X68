; =============================================================================
; SYSTEM VARS
; NOTE THAT ALL THESE VARS ARE USED TO SHARE DATA FROM SYSTEM TO USER. THUS
; THEY MUST NOT BE IN PROTECTED MEMORY.
; NOTE THAT USING DMMDATA IN SUCH WAY IS A BAD IDEA, AS USER APPLICATIONS CAN
; ALSO FREE OR CHANGE OWNERSHIP. NONETHELESS, FOR THE SAKE OF THIS EXAMPLE
; THIS IS GOOD ENOUGH.
; =============================================================================

; --- KEYBOARD RELATED VARIABLES ----------------------------------------------

KBDVAL      DS.B    1                       ; KEY PRESSED=1
KBDEDGE     DS.B    1                       ; KEY CHANGED=1

            DS.W    0

; --- SCREEN RELATED VARIABLES ------------------------------------------------

SCRINTCT    DS.B    1                       ; INTERRUPT COUNTER/FLAG
SCRCYCCT    DS.B    50                      ; CYCLE COUNTER
            DS.W    0

; --- DYNAMIC MEMORY VARIABLES ------------------------------------------------

            ORG     (*+DMMBSIZE-1)&-DMMBSIZE ; ALIGN TO DMMBSIZE
DMMDATA     DS.B    DMMBSIZE*DMMBNUM        ; DYNAMIC MEMORY ALLOCATION SPACE
            DS.W    0                       ; JUST IN CASE (SIZE IS POW OF TWO)




*~Font name~Courier New~
*~Font size~10~
*~Tab type~0~
*~Tab size~4~
