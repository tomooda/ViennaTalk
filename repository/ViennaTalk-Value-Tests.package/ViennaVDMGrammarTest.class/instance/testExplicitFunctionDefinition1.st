tests-definitions
testExplicitFunctionDefinition1
	self
		assert: (grammar functionDefinition end parse: 'f[@t] : t1 -> t2 f(x) == y pre b1 post b2 measure f2')
		equals: #('f' #('@t') #('t1' 't2') 'f' #(#('x')) 'y' 'b1' 'b2' 'f2')