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
            INCLUDE "WINUTIL.X68"           ;HARDWARE WINDOWS MANAGEMENT

; --- INITIALIZE --------------------------------------------------------------

START       MOVEM.L D0-D2/A0-A1,-(A7)
            MOVE.L  #30,D0
            TRAP    #15
            JSR     SYSINIT                 ; INITIALIZE SYSTEM CODE
            JSR     STAINIT                 ; INITIALIZE GAME STATE
            JSR     SHOWHWIN                ; INITIALIZE HARDWARE WINDOW

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
            
; --- FPSADAPT ----------------------------------------------------------------

            MOVE.L  #31,D0
            TRAP    #15    
            MOVE.L  (CYCLEUPD),D2
            ADD.L   (CYCLEPLT),D2
            SUB.L   D2,D1
            BPL     .WAIT
            BRA     .7SEGD   
.WAIT        
            DBRA    D1,.WAIT   
            
; --- 7SEG DISPLAYS TASKS -----------------------------------------------------

.7SEGD      LEA     .HWADDR,A0
            JSR     GTHWADDR
            MOVE.L  (.HWADDR), A0
            MOVE.L  #32,D0
            MOVE.B  #3,D1
            TRAP    #15
            MOVE.L  D1,A1
            BTST.B  #7,(A1)
            BEQ     .HWUPD
.HWDRAW     
            LEA     CYCLEPLT,A1
            JSR     MWRTSEGM
            BRA     .LOOP
.HWUPD      
            LEA     CYCLEUPD,A1
            JSR     MWRTSEGM
            MOVEM.L (A7)+,D0-D1 
            BRA     .LOOP         
            
            SIMHALT
            
.HWADDR     DS.L    4            

; --- VARIABLES ---------------------------------------------------------------

            INCLUDE "SYSVAR.X68"
            INCLUDE "VAR.X68"
            END    START






















*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
