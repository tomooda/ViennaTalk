tests-definitions
testExplicitFunctionDefinition
	self
		assert: (grammar functionDefinition end parse: 'f[@t] : t1 -> t2 f(x) == y pre b1 post b2 measure f2')
		equals: #('f' #('@t') #('t1' 't2') 'f' #(#('x')) 'y' 'b1' 'b2' 'f2').
	self
		assert: (grammar functionDefinition end parse: 'f[@t] : t1 -> t2 -> t3 f(x)(y) == z pre b1 post b2 measure f2')
		equals: #('f' #('@t') #('t1' #('t2' 't3')) 'f' #(#('x') #('y')) 'z' 'b1' 'b2' 'f2').
	self
		assert: (grammar functionDefinition end parse: 'f[@t] : t1 -> t2 -> t3 f(x)(y) == z pre b1 post b2 measure f2(x, y)')
		equals: #('f' #('@t') #('t1' #('t2' 't3')) 'f' #(#('x') #('y')) 'z' 'b1' 'b2' ('f2' ('x' 'y'))).
	self
		assert: (grammar functionDefinition end parse: 'f: t1->t2 f(x) == y')
		equals: #('f' #() #('t1' 't2') 'f' #(#('x')) 'y' nil nil nil)