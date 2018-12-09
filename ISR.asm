; ISR.asm
; Name:
; UTEid: 
; Keyboard ISR runs when a key is struck
; Checks for a valid RNA symbol and places it at x4600
               .ORIG x2600
	ST R3, 	SAVE3
	ST R4,	SAVE4
	ST R5,	SAVE5

	LDI R3, KBDR
	AND R4, R4, #0
	LD R5, A
	ADD R4, R3, R5
	BRz store
	AND R4, R4, #0
	LD R5, C
	ADD R4, R3, R5
	BRz store	
	AND R4, R4, #0
	LD R5, U
	ADD R4, R3, R5
	BRz store		
	AND R4, R4, #0
	LD R5, G
	ADD R4, R3, R5
	BRz store
	BRnzp END	

store	STI R3, GLOBAL

END	LD R3, SAVE3
	LD R4,	SAVE4
	LD R5,	SAVE5

	RTI

SAVE3	.BLKW 1
SAVE4	.BLKW 1
SAVE5	.BLKW 1
GLOBAL	.FILL	X4600
KBDR	.FILL	XFE02
KBSR	.FILL	XFE00
A	.FILL	#-65
C	.FILL	#-67
U	.FILL	#-85
G	.FILL	#-71
		.END
