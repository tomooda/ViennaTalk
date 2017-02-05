tests-definitions
testExtendedExplicitFunctionDefinition
	self
		assert: (grammar functionDefinition end parse: 'f[@t](x:t1) res:t2 == y pre b1 post b2')
		equals: #('f' #('@t') #(('x') 't1') #('res' 't2') 'y' 'b1' 'b2' ).
	self
		assert: (grammar functionDefinition end parse: 'f(x:t1) res:t2 == y post b2')
		equals: #('f' #() #(('x') 't1') #('res' 't2') 'y' nil 'b2' ).
	self
		assert: (grammar functionDefinition end parse: 'f(x:t1) res:t2 == y') isPetitFailure