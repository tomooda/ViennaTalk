tests-expressions
testFinExpression2
	self assert: (grammar expression end parse: '#fin(o1, o2)') equals: #('o1' 'o2')