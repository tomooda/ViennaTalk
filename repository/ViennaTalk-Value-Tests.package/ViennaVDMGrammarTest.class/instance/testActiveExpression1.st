tests-expressions
testActiveExpression1
	self assert: (grammar expression end parse: '#active(o)') equals: #('o')