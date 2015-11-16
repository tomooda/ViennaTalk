tests-expressions
testLetExpression4
	self
		assert: (grammar expression end parse: 'let f:t1->t2 f(x)==y in <ok>')
		equals: #(#(#('f' #() #('t1' 't2') 'f' #(#('x')) 'y' nil nil nil)) '<ok>')