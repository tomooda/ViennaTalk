tests-expressions
testWatitingExpression1
	self assert: (grammar expression end parse: '#waiting(o)') equals: #('o')