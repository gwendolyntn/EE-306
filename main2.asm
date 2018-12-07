; Main.asm
; Name:
; UTEid: 
; Continuously reads from x4600 making sure its not reading duplicate
; symbols. Processes the symbol based on the program description
; of mRNA processing.
               .ORIG x4000
; initialize the stack pointer
	LD R6, STACK

; set up the keyboard interrupt vector table entry
	LD R0, INT
	STI R0, KBIVE

; enable keyboard interrupts
	LD R0, KBIEN
	STI R0, KBSR

	LD R0, ZERO
	STI R0, BUFFER
; start of actual program
LOOP	LDI R0, BUFFER
	BRz LOOP
	TRAP X21
	AND R1, R1, #0
	STI R1, BUFFER
	ADD R4, R4, #-1

ZERO	.FILL	0
BUFFER	.FILL	X4600
INT	.FILL	X2600
STACK	.FILL	X4000
KBIEN	.FILL	X4000
KBSR	.FILL	XFE00
KBDR	.FILL	XFE02
KBIVE	.FILL	X0180
A	.FILL	#-65
C	.FILL	#-67
U	.FILL	#-85
G	.FILL	#-71
PIPE	.FILL	#124
		.END
