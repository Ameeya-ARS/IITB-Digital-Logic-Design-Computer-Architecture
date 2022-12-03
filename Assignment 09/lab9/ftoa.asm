	AREA my_code, CODE, READONLY
start
	LDR R1, =0x40000000 ; POINTER TO THE FLOAT WE WANT
	LDR R2, =0x60000000 ; POINTER TO THE STRING ANSWER 
	B main
	; example : C3 01 10 00 
;-----------------------------------------------------	
mul_by_two
; assume that R3 stores pointer to an ascii decimal number of the form x.xxxxxxEp, where x is stored in DECIMAL and p as an int (stored at +8)
; So R3 points to an array of 12 bytes
; we will temporarily write the multiplication result as xx.xxxxxx at R4, then transfer it at R3
; LOAD IN R5
; CARRY IN R6
; SUM IN R7
	MOV R6, #0
	LDR R3, =0x30000006 
	LDR R4, =0x30000057 
loop0
	CMP R3, #0x30000000
	BLT endloop0
	LDRB R5, [R3]
	ADD R7, R5, R5
	ADD R7, R7, R6
	CMP R7, #20
	BGE ge_twenty
	CMP R7, #10
	BGE ge_ten
	MOV R6, #0
	B end_if
ge_twenty
	MOV R6, #2
	SUB R7, R7, #20
	B end_if
ge_ten
	MOV R6, #1
	SUB R7, R7, #10
	B end_if
end_if
	STRB R7, [R4]
	SUB R3, R3, #1
	SUB R4, R4, #1
	B loop0
endloop0
	STRB R6, [R4]	
	LDR R3, =0x30000000
	CMP R6, #0
	; R5 IS COUNTER, R7 IS LOAD/STORE
	MOV R5, #0
	BGT carry
	B no_carry
carry
	LDR R7, [R3, #8]
	ADD R7, R7, #1
	STR R7, [R3, #8]
	B loop1
no_carry
	ADD R4, R4, #1	
	B loop1
loop1
	CMP R5, #7
	BEQ endloop1
	LDRB R7, [R4]
	STRB R7, [R3]
	ADD R4, R4, #1
	ADD R3, R3, #1
	ADD R5, R5, #1
	B loop1
endloop1
	BX LR
;------------------------------------
div_by_two
; assume that R3 stores pointer to an ascii decimal number of the form x.xxxxxxEp, where x is stored in DECIMAL and p as an int (stored at +8)
; So R3 points to an array of 12 bytes
; we will temporarily write the division result as x.xxxxxxx at R4, then transfer it at R3
; LOAD IN R5
; REM IN R6
; QUOTIENT IN R7
	MOV R6, #0
	LDR R3, =0x30000000 
	LDR R4, =0x30000050
	MOV R8, #10
loop2
	CMP R3, #0x30000006
	BGT endloop2
	LDRB R5, [R3]
	MUL R7, R6, R8
	MOV R6, R7 ; R7 IS JUST BEING USED AS A TEMPORARY REG HERE
	ADD R6, R6, R5
	MOV R7, #0
loop3 ; division
	CMP R6, #2
	BLT endloop3
	SUB R6, R6, #2
	ADD R7, R7, #1
	B loop3
endloop3
	STRB R7, [R4]
	ADD R4, R4, #1
	ADD R3, R3, #1
	B loop2
endloop2
	MUL R7, R6, R8
	MOV R6, R7
	MOV R7, #0
loop4 ; division
	CMP R6, #2
	BLT endloop4
	SUB R6, R6, #2
	ADD R7, R7, #1
	B loop4
endloop4
	STRB R7, [R4]
	ADD R4, R4, #1

	LDR R3, =0x30000000 
	LDR R4, =0x30000050 
	MOV R5, #0 ; COUNTER
	LDRB R6, [R4]
	CMP R6, #0
	BGT same_power
	LDR R7, [R3, #8]
	SUB R7, R7, #1
	STR R7, [R3, #8]
	ADD R4, R4, #1
same_power
loop5
	CMP R5, #6
	BGT endloop5
	LDRB R7, [R4]
	STRB R7, [R3]
	ADD R4, R4, #1
	ADD R3, R3, #1
	ADD R5, R5, #1
	B loop5
endloop5
	BX LR
	

;------------------------------------
div_by_two_without_shift
; assume that R3 stores pointer to an ascii decimal number of the form x.xxxxxxEp, where x is stored in DECIMAL and p as an int (stored at +8)
; So R3 points to an array of 12 bytes
; we will temporarily write the division result as x.xxxxxxx at R4, then transfer it at R3
; LOAD IN R5
; REM IN R6
; QUOTIENT IN R7
	MOV R6, #0
	LDR R3, =0x30000000 
	LDR R4, =0x30000050
	MOV R8, #10
loop6
	CMP R3, #0x30000006
	BGT endloop6
	LDRB R5, [R3]
	MUL R7, R6, R8
	MOV R6, R7 ; R7 IS JUST BEING USED AS A TEMPORARY REG HERE
	ADD R6, R6, R5
	MOV R7, #0
loop7 ; division
	CMP R6, #2
	BLT endloop7
	SUB R6, R6, #2
	ADD R7, R7, #1
	B loop7
endloop7
	STRB R7, [R4]
	ADD R4, R4, #1
	ADD R3, R3, #1
	B loop6
endloop6
	MUL R7, R6, R8
	MOV R6, R7
	MOV R7, #0
loop8 ; division
	CMP R6, #2
	BLT endloop8
	SUB R6, R6, #2
	ADD R7, R7, #1
	B loop8
endloop8
	STRB R7, [R4]
	ADD R4, R4, #1

	LDR R3, =0x30000000 
	LDR R4, =0x30000050 
	MOV R5, #0 ; COUNTER
loop9
	CMP R5, #6
	BGT endloop9
	LDRB R7, [R4]
	STRB R7, [R3]
	ADD R4, R4, #1
	ADD R3, R3, #1
	ADD R5, R5, #1
	B loop9
endloop9
	BX LR
	
;-----------------------------------------------------	
add_without_shift
; assume that R3 stores pointer to an ascii decimal number of the form xx.xxxxxxEp, where x is stored in DECIMAL and p as an int (stored at +8)
; assume that R8 stores pointer to an ascii decimal number of the form xx.xxxxxxEp, where x is stored in DECIMAL and p as an int (stored at +8)
; So R3, R8 point to arrays of 12 bytes
; we will temporarily write the sum as xx.xxxxxx at R4, then transfer it at R3
; LOAD IN R5
; CARRY IN R6
; SUM IN R7
	MOV R6, #0
	LDR R3, =0x50000007
	LDR R8, =0x50000027
	LDR R4, =0x50000057 
loop10
	CMP R3, #0x50000000
	BLT endloop10
	LDRB R5, [R3]
	LDRB R7, [R8]
	ADD R7, R5, R7
	ADD R7, R7, R6
	CMP R7, #20
	BGE ge_twenty_2
	CMP R7, #10
	BGE ge_ten_2
	MOV R6, #0
	B end_if_2
ge_twenty_2
	MOV R6, #2
	SUB R7, R7, #20
	B end_if_2
ge_ten_2
	MOV R6, #1
	SUB R7, R7, #10
	B end_if_2
end_if_2
	STRB R7, [R4]
	SUB R3, R3, #1
	SUB R8, R8, #1
	SUB R4, R4, #1
	B loop10
endloop10	
	LDR R3, =0x50000000
	LDR R4, =0x50000050
	; R5 IS COUNTER, R7 IS LOAD/STORE
	MOV R5, #0
	
loop11
	CMP R5, #8
	BEQ endloop11
	LDRB R7, [R4]
	STRB R7, [R3]
	ADD R4, R4, #1
	ADD R3, R3, #1
	ADD R5, R5, #1
	B loop11
endloop11
	BX LR
	
;---------------------------------------------
main
	LDR R3, =0x30000000
	MOV R9, #0
	STR R9, [R3, #4]
	STR R9, [R3, #8]
	MOV R9, #1
	STR R9, [R3]
	; LITTLE ENDIAN FLOAT IEEE 754
	; LOAD THE EXPONENT. 
	LDR R9, [R1]
	MOV R9, R9, LSR #1
	AND R9, R9, #0x000000ff
	MOV R5, #0
	MOV R10, #0
power_loop
	CMP R5, #8
	BEQ end_power_loop
	ADD R10, R10, R10
	AND R11, R9, #0x00000001
	CMP R11, #0
	BEQ continue_power_loop
	ADD R10, R10, #1
continue_power_loop
	MOV R9, R9, LSR #1	
	ADD R5, R5, #1
	B power_loop
end_power_loop
	MOV R9, R10
	;AND R9, R9, #127
	SUB R9, R9, #127
	CMP R9, #0
	BGE pos_exp
	B neg_exp
pos_exp
loop12
	CMP R9, #0
	BEQ endloop12
	BL mul_by_two
	SUB R9, R9, #1
	B loop12
endloop12
	B end_exp
neg_exp
	LDR R10, =0xffffffff
	EOR R9, R9, R10
	ADD R9, R9, #1
loop13
	CMP R9, #0
	BEQ endloop13
	BL div_by_two
	SUB R9, R9, #1
	B loop13
endloop13
	B end_exp
end_exp

	LDR R3, =0x30000000
	LDR R4, =0x50000001
	MOV R5, #0
transfer_loop0
	CMP R5, #7
	BEQ end_transfer_loop0
	LDRB R9, [R3]
	STRB R9, [R4]
	ADD R3, R3, #1
	ADD R4, R4, #1
	ADD R5, R5, #1
	B transfer_loop0
end_transfer_loop0
	LDR R3, =0x30000000
	LDR R4, =0x50000000
	LDR R9, [R3, #8]
	STR R9, [R4, #8]

	LDR R9, [R1]
	MOV R9, R9, LSR #9
loop14
	CMP R9, #0
	BEQ endloop14
	AND R10, R9, #0x00000001
	BL div_by_two_without_shift
	CMP R10, #0
	BEQ continueloop14
	
	LDR R3, =0x30000000
	LDR R4, =0x50000021
	MOV R5, #0
transfer_loop1
	CMP R5, #7
	BEQ end_transfer_loop1
	LDRB R11, [R3]
	STRB R11, [R4]
	ADD R3, R3, #1
	ADD R4, R4, #1
	ADD R5, R5, #1
	B transfer_loop1
end_transfer_loop1
	LDR R3, =0x30000000
	LDR R4, =0x50000020
	LDRB R11, [R3, #8]
	STRB R11, [R4, #8]
	
	BL add_without_shift
	
continueloop14 MOV R9, R9, LSR #1
	B loop14
endloop14

	LDR R4, =0x50000000
	LDRB R9, [R4]
	CMP R9, #0
	BGT two_dec
	B one_dec
	
two_dec
	LDR R9, [R4, #8]
	ADD R9, R9, #1
	STR R9, [R4, #8]
	B end_dec
one_dec
	ADD R4, R4, #1
	B end_dec
end_dec

	LDR R1, =0x40000000
	LDR R9, [R1]
	AND R9, R9, #0x00000001
	CMP R9, #0
	BEQ pos_float
	B neg_float
neg_float
	MOV R9, #0X2D
	STRB R9, [R2]
	ADD R2, R2, #1
	B end_float
pos_float
	MOV R9, #0X2B
	STRB R9, [R2]
	ADD R2, R2, #1
	B end_float
end_float
	MOV R5, #0
tranfer_loop2
	CMP R5, #7
	BEQ end_transfer_loop2
	LDRB R9, [R4]
	ADD R9, R9, #0x00000030
	STRB R9, [R2]
	ADD R4, R4, #1
	ADD R2, R2, #1
	ADD R5, R5, #1
	CMP R5, #1
	BEQ put_decimal_point
	B continue
put_decimal_point
	MOV R9, #0x2E
	STRB R9, [R2]
	ADD R2, R2, #1
continue B tranfer_loop2
end_transfer_loop2

	LDR R4, =0x50000000
	LDR R2, =0x60000000
	
	LDR R9, [R4, #8]
	STR R9, [R2, #12]
	
	END