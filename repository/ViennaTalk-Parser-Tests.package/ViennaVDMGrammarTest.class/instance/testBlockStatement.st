tests-statements
testBlockStatement
	self
		assert: (grammar statement end parse: '(dcl v1:t1 := e1,v2:t2:=e2; dcl v3:t3 := e3,v4:t4:=e4; skip; skip)')
		equals: #(#(#(#('v1' 't1' 'e1') #('v2' 't2' 'e2')) #(#('v3' 't3' 'e3') #('v4' 't4' 'e4'))) #(nil nil)).
	self assert: (grammar statement end parse: '(skip; skip;)') equals: #(#() #(nil nil)).
	self assert: (grammar statement end parse: '(dcl v1:t1 := e1,v2:t2:=e2; dcl v3:t3 := e3,v4:t4:=e4)') isPetitFailure