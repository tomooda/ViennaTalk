tests-expressions
testFinExpression1
	self assert: (grammar expression end parse: '#fin(o)') equals: #('o')