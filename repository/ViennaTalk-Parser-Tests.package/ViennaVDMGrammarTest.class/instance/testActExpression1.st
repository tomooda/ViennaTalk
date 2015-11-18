tests-expressions
testActExpression1
	self assert: (grammar expression end parse: '#act(o)') equals: #('o')