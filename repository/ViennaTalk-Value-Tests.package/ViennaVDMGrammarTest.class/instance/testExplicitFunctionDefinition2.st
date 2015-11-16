tests-definitions
testExplicitFunctionDefinition2
	self
		assert: (grammar functionDefinition end parse: 'f[@t] : t1 -> t2 -> t3 f(x)(y) == z pre b1 post b2 measure f2')
		equals: #('f' #('@t') #('t1' #('t2' 't3')) 'f' #(#('x') #('y')) 'z' 'b1' 'b2' 'f2')