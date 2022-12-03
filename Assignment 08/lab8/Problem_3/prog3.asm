		AREA		my_code,CODE,READWRITE
			
start
		LDR			R0, =0x30000000				;stores location of length of array
		LDRB		R1, [R0]					;stores size of graph i.e no of vertices V	
		LDR			R0, =0x40000000
		LDRB		R12, [R0]
		LDR			R0, =0x60000000				;stores address of adjacency matrix	G[][]
		LDR			R2, =0x70000000				;to store the distances distance[]
		LDR			R3, =0x50000000				;boolean array to mark as visited visited[]
		LDR			R4, =0x40000001				;matrix to store the cost of i to j cost[][]
		
		MOV			R5, #0						;start at index 0  (acts as i)
		MOV			R6, #0						;acts as j
		MOV			R7, #0						;acts as count
		MOV			R8, #0						;acts as mindistance
		MOV			R9, #0						;acts as nextnode
		
for1	CMP			R5, R1
		BGE			endfor1
		BLT			for2
		
for2	CMP			R6, R1
		BGE			endfor2
		MUL			R10, R5, R1					;temp register to find location of ith row and jth column = i*V + j
		ADD			R10, R10, R6
		LDRB		R11, [R0, R10]				;temp register to store G[i][j]
		CMP			R11, #0
		BEQ			G_case1
		B			G_case2
		
G_case1	MOV			R14, #0xff					;temp register to store some kinf of INFINITY
		STRB		R14, [R4, R10]				;store cost[i][j] = INFINITY
		ADD			R6, R6, #01
		B			for2
		
G_case2	STRB		R11, [R4, R10]				;store cost[i][j] = G[i][j]
		ADD			R6, R6, #01
		B			for2
		
endfor2	ADD			R5, R5, #01
		SUB			R6, R6, R1
		B			for1
		
endfor1	MOV			R5, #00				;now onwards R0 contains source id

for3	CMP			R5, R1
		BGE			endfor3
		MOV			R14, #00					;temp register
		STRB		R14, [R3, R5]				;visited[i] = 0
		MUL			R10, R12, R1
		ADD			R10, R10, R5
		LDRB		R14, [R4, R10]				;cost[startnode][i]
		STRB		R14, [R2, R5]				;distance[i] = cost[startnode][i]
		ADD			R5, R5, #01					;i++
		B			for3
		
endfor3	MOV			R14, #00
		STRB		R14, [R2, R12]					;distance[startnode] = 0
		MOV			R14, #01
		STRB		R14, [R3, R12]					;visited[startnode] = 1
		MOV			R7, #01						;count = 1
		
while1	CMP			R7, R1
		BGE			endwhile1
		MOV			R8, #0xff					;mindistance=INFINITY
		
		MOV			R5, #00
		B			for4
		
for4	CMP			R5, R1
		BGE			endfor4
		LDRB		R10, [R3, R5]
		CMP			R10, #00					;visited[i]==0
		BEQ			cont1
		B			nextiter
		
cont1	LDRB		R10, [R2, R5]
		CMP			R10, R8
		BLT			cont2
		B			nextiter
		
cont2	LDRB		R10, [R2, R5]				;distance[i]
		MOV			R8, R10						;mindistance = distance[i]
		MOV			R9, R5
		B			nextiter
		
nextiter
		ADD			R5, R5, #01
		B			for4
		
endfor4	MOV			R10, #01
		STRB		R10, [R3, R9]				;visited[nextnode]=1
		MOV			R5, #00
		
for5	CMP			R5, R1
		BGE			endfor5
		LDRB		R14, [R3, R5]
		CMP			R14, #00					;visited[i]==0
		BEQ			cont3
		B			next_iter
		
cont3	MUL			R10, R9, R1					;R10 = nextnode*V + i
		ADD			R10, R10, R5
		LDRB		R11, [R4, R10]				;cost[nextnode][i]
		ADD			R11, R11, R8				;R11 = cost[nextnode][i] + mindistance
		LDRB		R12, [R2, R5]				;R12 = distance[i]
		CMP			R11, R12
		BLT			cont4
		B			next_iter
		
cont4	STRB		R11, [R2, R5]				;distance[i] = cost[nextnode][i] + mindistance
		B			next_iter
		
next_iter
		ADD			R5, R5, #01					;i++
		B			for5
		
endfor5	ADD			R7, R7, #01					;count++
		B			while1
		
endwhile1
		B			final

final	B			final	

		END