; =============================================================================
; TITLE    : EXAMPLE GAME
; AUTHOR   : ANTONI BURGUERA
; CREATION : 22-OCT-2017
; =============================================================================

            ORG     $1000

; --- CODE INCLUDES -----------------------------------------------------------

            INCLUDE "SYSCONST.X68"          ; SYSTEM CONSTANTS
            INCLUDE "SYSTEM.X68"            ; SYSTEM CODE
            INCLUDE "CONST.X68"             ; USER CONSTANTS
            INCLUDE "UTIL.X68"              ; UTILITY MACRO AND SUBROUTINES
            INCLUDE "PLAYER.X68"            ; PLAYER MANAGEMENT
            INCLUDE "AGENTLST.X68"          ; AGENT LIST MANAGEMENT
            INCLUDE "PIPE.X68"              ; ASTEROID AGENT MANAGEMENT
            INCLUDE "COIN.X68"              ; SCORE-EARNING COINS MANAGEMENT
            INCLUDE "SPAWNER.X68"           ; SPAWNER (CREATES ASTEROIDS)
            INCLUDE "STATES.X68"            ; GAME STATES MANAGEMENT
            INCLUDE "BACKGROUND.X68"        ; GAME BACKGROUND MANAGEMENT

; --- INITIALIZE --------------------------------------------------------------

START       JSR     SYSINIT                 ; INITIALIZE SYSTEM CODE
            JSR     STAINIT                 ; INITIALIZE GAME STATE

; --- UPDATE ------------------------------------------------------------------

.LOOP       TRAP    #KBDTRAP                ; READ KEYBOARD
            JSR     STAUPD                  ; UPDATE DEPENDING ON THE STATE

; --- WAIT SYNCH --------------------------------------------------------------

.WINT       TST.B   (SCRINTCT)              ; WAIT FOR INTERRUPT
            BEQ     .WINT
            CLR.B   (SCRINTCT)

; --- PLOT --------------------------------------------------------------------

            JSR     STAPLOT                 ; PLOT DEPENDING ON THE STATE
            TRAP    #SCRTRAP                ; SHOW GRAPHICS
            BRA     .LOOP
            SIMHALT

; --- VARIABLES ---------------------------------------------------------------

            INCLUDE "SYSVAR.X68"
            INCLUDE "VAR.X68"
            END    START

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
