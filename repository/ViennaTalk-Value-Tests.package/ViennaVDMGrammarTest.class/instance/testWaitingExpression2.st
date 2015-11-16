tests-expressions
testWaitingExpression2
	self assert: (grammar expression end parse: '#waiting(o1, o2)') equals: #('o1' 'o2')