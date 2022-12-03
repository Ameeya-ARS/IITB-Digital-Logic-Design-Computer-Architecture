		AREA	my_code,CODE,READWRITE
		
gcd		CMP		R1, R2		;R1 - R2 and set the cpsr
		BGT		cond1		;if R1 > R2
		BLT		cond2		;if R1 < R2
		BEQ		end_res		;if R1 = R2
	
cond1	SUB		R1, R1, R2
		B		gcd
		
cond2	SUB		R2, R2, R1
		B		gcd
		
end_res	MOV		R3, R2		;R1 = R2 = gcd
	
final 	B		final
		END