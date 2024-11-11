
		LDR $00
	COUNTLOOP:
		ADD $01
		CMP $FF
		BGE COUNTLOOP
		
		JMP END
		
		LDR $00
		ADD $01
		ADD $01
		ADD $01
		ADD $01
		ADD $01
		ADD $01
		
	
	LABEL:
		SEC
		BGE LABEL
		
		;=		
		CMP COND
		BGE TESTEQ
		SEC
		BGE FAIL
		TESTEQ:
		CMP COND+1
		BGE FAIL
		SEC
		BGE PASS
		
		;>			
		CMP COND
		BGE TESTEQ
		SEC
		BGE FAIL
		TESTEQ:
		CMP COND+1
		BGE PASS
		SEC
		BGE FAIL
		
		;<		
		CMP COND
		BGE FAIL
		SEC
		BGE PASS
		
		;>=		
		CMP COND
		BGE PASS
		SEC 
		BGE FAIL
		
		;<=	
		CMP COND
		BGE TESTEQ
		SEC
		BGE PASS
		TESTEQ:
		CMP COND+1
		BGE FAIL
		SEC
		BGE PASS
		

