tests-definitions
testExplicitFunctionDefinition3
	self
		assert: (grammar functionDefinition end parse: 'f: t1->t2 f(x) == y')
		equals: #('f' #() #('t1' 't2') 'f' #(#('x')) 'y' nil nil nil)