		AREA	my_code,CODE,READWRITE
main
		LDR		R0, =0x40000000		;point to start of array
		LDRB	R1, [R0]			;load the length of array
		ADD		R0, R0, #01			;point to first value of array
		SUB		R1, R1, #01			;use n-1
		MOV		R2, #00				;start at index 0
for1
		CMP		R2, R1				;if i>=n-1, end sort
		BGE		final
		MOV		R3, R2				;min_index = i
		ADD		R4, R2, #01			;start at j=i+1
for2
		CMP		R4, R1				;if j>n-1, end for2
		BGT		endfor2
		
		LDRB	R5, [R0, R4]		;load array[j]
		LDRB	R6, [R0, R3]		;load array[min_index]
		CMP		R5, R6
		BGE		next
		MOV		R3, R4				;min_index=j
next
		ADD		R4, R4, #01			;j++
		B		for2				;repeat for2
endfor2
		LDRB	R5, [R0, R2]		;load array[i]
		LDRB	R6, [R0, R3]		;load array[min_index]
		STRB	R6, [R0, R2]		;save swapped in array[i]
		STRB	R5, [R0, R3]		;save swapped in array[min_index]
		
		ADD		R2, R2, #01			;i++
		B		for1				;repeat for1
final
		B		final
		
		END