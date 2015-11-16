tests-expressions
testActExpression2
	self assert: (grammar expression end parse: '#act(o1, o2)') equals: #('o1' 'o2')