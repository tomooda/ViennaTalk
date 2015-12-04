tests-expressions
testCasesExpression
	self
		assert: (grammar expression end parse: 'cases e:p11,p12->e1,p2->e2,others->default end')
		equals: #('e' #(#(#('p11' 'p12') 'e1') #(#('p2') 'e2')) 'default')