; =============================================================================
; SYSTEM CONSTANTS
; =============================================================================

; --- GAME STATES -------------------------------------------------------------

STANONE     EQU     -1                      ; PLACEHOLDER TO FORCE CHANGE
STAINTR     EQU     0                       ; INTRO/PRESS SPACE BAR STATE
STAPLAY     EQU     1                       ; NORMAL GAME STATE
STAGOVR     EQU     2                       ; GAME OVER STATE

; --- AGENT TYPES -------------------------------------------------------------

SHTTYPE     EQU     1
ASTTYPE     EQU     2
XPLTYPE     EQU     3
COINTYPE    EQU     4

; --- PLAYER RELATED CONSTANTS ------------------------------------------------

PLRWIDTH    EQU     30                      ; PLAYER WIDTH (PIXELS)
PLRHEIGH    EQU     30                      ; PLAYER HEIGHT (PIXELS)
PLRSPDX     EQU     5                       ; PLAYER SPEED UPON X AXIS
PLRACCY     EQU     1                       ; PLAYER ACCELERATION UPON Y AXIS (USED FOR GRAVITATIONAL PURPOSES)
PLRCOLOR    EQU     $000000FF               ; PLAYER COLOR
PLRTXTCL    EQU     $00FFFFFF               ; FONT COLOR
PLRTXTX     EQU     2                       ; SCORE X COORDINATE
PLRTXTY     EQU     1                       ; SCORE Y COORDINATE

; --- PIPE RELATED CONSTANTS ----------------------------------------------

HOLHEIGH    EQU     120                     ; HOLE HEIGH
PIPWIDTH    EQU     60
PIPPENCL    EQU     $00FFFFFF               ; PIPE PEN COLOR
PIPFILCL    EQU     $00008000               ; PIPE FIL COLOR
PIPEDGE     EQU     5                       ; PIPE EDGE WIDTH
PIPXSPD     EQU     5                       ; PIPE X SPEED 
PIPYSPD     EQU     3                       ; PIPE Y SPEED 
PIPSCORE    EQU     5                       ; SCORE FOR PIPE

; --- COIN RELATED CONSTANTS ---------------------------------------------

COINSIZE    EQU     25                      ; COIN DIAMETER (PIXELS)
CNPENCL     EQU     $00000000               ; COIN PEN COLOR
CNFILCL     EQU     $0000FFFF               ; COIN FIL COLOR
COINXSPD    EQU     5                       ; COIN SPEED UPON X AXIS

; --- INTRO STATE RELATED CONSTANTS -------------------------------------------

INTTITX     EQU     25                      ; TITLE X COORDINATE
INTTITY     EQU     5                       ; TITLE Y COORDINATE
INTTITC     EQU     $000000FF               ; TITLE COLOR
INTPRSX     EQU     31                      ; SPACE BAR X COORDINATE
INTPRSY     EQU     23                      ; SPACE BAR Y COORDINATE
INTPRSC     EQU     $00FFFFFF               ; PRESS SPACE BAR COLOR

; --- GAME OVER STATE RELATED CONSTANTS ---------------------------------------

GOVSTRX     EQU     35                      ; TITLE X COORDINATE
GOVSTRY     EQU     15                      ; TITLE Y COORDINATE
GOVSTRC     EQU     $00FFFFFF               ; TITLE COLOR



*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
