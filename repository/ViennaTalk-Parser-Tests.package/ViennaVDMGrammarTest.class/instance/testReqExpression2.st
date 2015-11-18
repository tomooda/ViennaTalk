tests-expressions
testReqExpression2
	self assert: (grammar expression end parse: '#req(o1, o2)') equals: #('o1' 'o2')