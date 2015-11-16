tests-expressions
testReqExpression1
	self assert: (grammar expression end parse: '#req(o)') equals: #('o')