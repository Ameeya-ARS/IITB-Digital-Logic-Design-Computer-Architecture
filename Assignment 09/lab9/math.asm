	AREA my_code, CODE, READONLY
start
	LDR R0, =0x40000000 ; STACK POINTER
	LDR R1, =0x50000000 ; EXPRESSION POINTER
	LDR R2, =0x60000000 ; POSTFIX POINTER
	MOV R5, #0; R5 IS FLAG: VALUE 0X00000001 FOR INT, 0X00000010 FOR END PARANTHESIS
	; $ IS INTEGER DELIMITER. ! IS SYMBOL FOR NEGATIVE INTEGER
	; R3 IS READ. R4 IS TEMP
	
; SUBROUTINE TO CONVERT TO POSTFIX NOTATION
loop0
	LDRB R3, [R1]
	ADD R1, R1, #1
	
	CMP R3, #0x00000030 ; int
	BGE case_int
	
	CMP R5, #0
	BEQ int_flag_not_set
	CMP R5, #2
	BEQ int_flag_not_set
	LDR R4, =0x00000024 ; $
	STRB R4, [R2]
	ADD R2, R2, #1
	
	
int_flag_not_set
	
	CMP R3, #0x00000023 ; #
	BEQ endloop0
	
	CMP R3, #0x00000028 ; (
	BEQ case_open_para
	
	CMP R3, #0x00000029 ; )
	BEQ case_closed_para
	
	CMP R3, #0x0000002A ; *
	BEQ case_mul_div	
	
	CMP R3, #0x0000002B ; +
	BEQ case_add
	
	CMP R3, #0x0000002D ; -
	BEQ case_sub
	
	CMP R3, #0x0000002F ; /
	BEQ case_mul_div
	
case_int
	STRB R3, [R2]
	ADD R2, R2, #1
	MOV R5, #1
	B continue0
	
case_open_para
	STRB R3, [R0]
	ADD R0, R0, #1
	MOV R5, #0
	B continue0
	
case_closed_para
loop3
	CMP R0, #0x40000000
	BEQ endloop3
	LDRB R4, [R0, #-1]
	CMP R4, #0x00000028 ; (
	BEQ sub_case_open_para
	
	SUB R0, R0, #1
	STRB R4, [R2]
	ADD R2, R2, #1
	B continue3
	
sub_case_open_para
	SUB R0, R0, #1
	B endloop3
	
continue3 B loop3
endloop3
	MOV R5, #2
	B continue0
	
case_add
loop1
	CMP R0, #0x40000000
	BLE endloop1
	LDRB R4, [R0, #-1]
	CMP R4, #0x0000002B ; +
	BEQ endloop1
	CMP R4, #0x0000002D ; -
	BEQ endloop1
	CMP R4, #0x00000028 ; (
	BEQ endloop1
	STRB R4, [R2]
	ADD R2, R2, #1
	SUB R0, R0, #1
	B loop1
endloop1
	STRB R3, [R0]
	ADD R0, R0, #1
	MOV R5, #0
	B continue0
	
case_sub
	CMP R5, #1
	BEQ loop4
	CMP R5, #2
	BEQ loop4
	LDR R4, =0x00000021
	STRB R4, [R2]
	ADD R2, R2, #1
	MOV R5, #1
	B continue0
loop4
	CMP R0, #0x40000000
	BLE endloop4
	LDRB R4, [R0, #-1]
	CMP R4, #0x0000002B ; +
	BEQ endloop4
	CMP R4, #0x0000002D ; -
	BEQ endloop4
	CMP R4, #0x00000028 ; (
	BEQ endloop4
	STRB R4, [R2]
	ADD R2, R2, #1
	SUB R0, R0, #1
	B loop4
endloop4
	STRB R3, [R0]
	ADD R0, R0, #1
	MOV R5, #0
	B continue0
	
case_mul_div
	STRB R3, [R0]
	ADD R0, R0, #1
	MOV R5, #0
	B continue0
	
continue0	B loop0
endloop0

loop2
	CMP R0, #0x40000000
	BEQ endloop2
	LDRB R4, [R0, #-1]
	SUB R0, R0, #1
	STRB R4, [R2]
	ADD R2, R2, #1
	B loop2
endloop2

	LDR R4, =0x00000023 ; #
	STRB R4, [R2]
	ADD R2, R2, #1

; EVALUATE POSTFIX NOTATION
	LDR R0, =0x40000000 ; STACK POINTER
	LDR R2, =0x60000000 ; POSTFIX POINTER
	LDR R11, =0x70000000 ; SYMBOL TABLE
	MOV R5, #0 ; FLAGS : 0x00000001 DENOTES NEGATIVE NUMBER
	MOV R6, #0 ;ACCUMULATOR FOR DECIMAL NUMBERS
	
	MOV R8, #10 ; THE CONSTANT 10
	LDR R9, =0xffffffff ; THE CONSTANT ffffffff
	B loop5
	
; DIVISION FUNCTION
divide
; input R4, R7, output R10
	MOV R10, #0
divideloop
	CMP R7, R4
	BLT enddivideloop
	ADD R10, R10, #1
	SUB R7, R7, R4
	B divideloop
enddivideloop
	BX LR
	
; VARIABLE LOOKUP
lookup
lookuploop
	LDR R7, [R11]
	ADD R11, R11, #4
	CMP R7, #0x00000023 ; #
	BEQ endlookuploop
	CMP R7, R3
	BEQ var_found
	ADD R11, R11, #4
	B lookuploop
var_found
	LDR R6, [R11]
	ADD R11, R11, #4
	CMP R6, #0
	BGE pos_var
	MOV R5, #1
	EOR R6, R6, R9
	ADD R6, #1
pos_var
	B lookuploop
endlookuploop
	LDR R11, =0x70000000
	BX LR
	
loop5
	LDRB R3, [R2]
	ADD R2, R2, #1
	
	CMP R3, #0x00000021 ; !
	BEQ exclamation_mark	
	
	CMP R3, #0x00000030 ; INT
	BGE int2
	
	CMP R3, #0x00000024 ; $
	BEQ dollar
	
	CMP R3, #0x00000023 ; #
	BEQ endloop5
	
	CMP R3, #0x0000002A ; *
	BEQ mul2
	
	CMP R3, #0x0000002B ; +
	BEQ add2
	
	CMP R3, #0x0000002D ; -
	BEQ sub2
	
	CMP R3, #0x0000002F ; /
	BEQ div2
	
	B continue5

dollar
	CMP R5, #1
	BEQ neg_int
	B pos_int
	
neg_int
	EOR R6, R6, R9 ; EOR = XOR
	ADD R6, R6, #1
	STR R6, [R0]
	ADD R0, R0, #4
	MOV R5, #0
	MOV R6, #0	
	B continue5
	
pos_int
	STR R6, [R0]
	ADD R0, R0, #4
	MOV R5, #0
	MOV R6, #0
	B continue5
	
exclamation_mark
	MOV R5, #1
	B continue5
	
int2
	CMP R3, #0x00000041 ; VARIABLE
	BGE variable
	SUB R3, R3, #0x00000030 ; CHAR TO INT
	MUL R7, R6, R8
	MOV R6, R7
	ADD R6, R3
	B continue5	
	
variable
	BL lookup
	B continue5	
	
mul2
	LDR R4, [R0, #-4]
	LDR R7, [R0, #-8]
	SUB R0, R0, #8
	MUL R10, R7, R4
	STR R10, [R0]
	ADD R0, R0, #4
	B continue5
	
add2
	LDR R4, [R0, #-4]
	LDR R7, [R0, #-8]
	SUB R0, R0, #8
	ADD R10, R7, R4
	STR R10, [R0]
	ADD R0, R0, #4
	B continue5
	
sub2
	LDR R4, [R0, #-4]
	LDR R7, [R0, #-8]
	SUB R0, R0, #8
	SUB R10, R7, R4
	STR R10, [R0]
	ADD R0, R0, #4
	B continue5
	
div2
	LDR R4, [R0, #-4] ; divisor
	LDR R7, [R0, #-8] ; dividend
	SUB R0, R0, #8
	CMP R4, #0
	BGT divisor_pos
	B divisor_neg
divisor_pos
	CMP R7, #0
	BGE divisor_pos_dividend_pos
	B divisor_pos_dividend_neg
divisor_pos_dividend_pos
	BL divide
	B enddiv2
divisor_pos_dividend_neg
	EOR R7, R7, R9 ; EOR = XOR
	ADD R7, R7, #1
	BL divide
	EOR R10, R10, R9 ; EOR = XOR
	ADD R10, R10, #1
	B enddiv2
divisor_neg
	CMP R7, #0
	BGE divisor_neg_dividend_pos
	B divisor_neg_dividend_neg
divisor_neg_dividend_pos
	EOR R4, R4, R9 ; EOR = XOR
	ADD R4, R4, #1
	BL divide
	EOR R10, R10, R9 ; EOR = XOR
	ADD R10, R10, #1
	B enddiv2
divisor_neg_dividend_neg
	EOR R4, R4, R9 ; EOR = XOR
	ADD R4, R4, #1
	EOR R7, R7, R9 ; EOR = XOR
	ADD R7, R7, #1
	BL divide
	B enddiv2
enddiv2	
	STR R10, [R0]
	ADD R0, R0, #4
	B continue5

continue5 B loop5
endloop5	

	END