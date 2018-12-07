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
	BRz CHECKU
	BRn CHECKA
	BRp CHECKG
	
;Process R0
CHECKA	AND R4, R4, #0
	LD R2, A
	ADD R3, R0, R2
	BRnp LOOP
	ADD R4, R4, #1
	BRnzp LOOP
CHECKU	LD R2, U
	ADD R3, R0, R2
	BRnp CHECKA
	ADD R4, R4, #2
	BRnzp LOOP
CHECKG	LD R2, G
	ADD R3, R0, R2
	BRnp LOOP
	LD R0, PIPE
	TRAP X21
	BRnzp next
	
;Check for stop codon
next	AND R4, R4, #0
loop	LDI R0, BUFFER
	BRz loop
	TRAP X21
	AND R1, R1, #0
	STI R1, BUFFER
	ADD R4, R4, #-1
	BRz checka
	BRn checku
	BRp checkA


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
