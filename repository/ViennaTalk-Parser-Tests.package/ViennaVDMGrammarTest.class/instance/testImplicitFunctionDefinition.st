tests-definitions
testImplicitFunctionDefinition
	self
		assert: (grammar functionDefinition end parse: 'f[@t](p1:t1, p2:t2) i1:t3 pre b1 post b2')
		equals: #('f' #('@t') #(#('p1') 't1' #('p2') 't2') #('i1' 't3') 'b1' 'b2').
	self
		assert: (grammar functionDefinition end parse: 'f[@t](p1:t1, p2:t2) i1:t3 post b2')
		equals: #('f' #('@t') #(#('p1') 't1' #('p2') 't2') #('i1' 't3') nil 'b2').
	self
		assert:
			(grammar functionDefinition end parse: 'f[@t](p1:t1, p2:t2) i1:t3 pre b1') isPetitFailure