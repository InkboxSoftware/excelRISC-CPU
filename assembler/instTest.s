;PROGRAM FOR TESTING THE EXCEL-ASM8 ASSEMBLER
;PASSED SUCESSFULLY

VAR = #200
VAR2 = $80
VAR3 = $08

START:
	LDI VAR
	CMP VAR
	BGE NEXT

	SEC
TRAP1:
	BGE TRAP1

NEXT:
	LDI #12
	CMP VAR
	BGE TRAP2
	SEC
	BGE NEXT2
	
TRAP2:
	BGE TRAP2
	
NEXT2:
	LDI VAR2
	PUSH
	LDI VAR3
	SEC
	CLC
	ADD	;RESULT SHOULD BE #136
	PUSH
	LDI $00
	POP
	;TESTING STORE AND LOAD FROM ADDRESS:
	LDI #199
	PUSH
	LDI #02
	STR
	LDI #02
	PUSH
	LDR		;SHOULD READ #199 FROM ADDRESS $002

END:	
	;LOOP BACK TO BEGINING:
	SEC
	BGE START
	
	
	
	BGE #20
	CMP $FA
	LDI $04

	
	