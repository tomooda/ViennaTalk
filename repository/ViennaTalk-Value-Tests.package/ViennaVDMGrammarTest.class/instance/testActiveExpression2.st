tests-expressions
testActiveExpression2
	self assert: (grammar expression end parse: '#active(o1, o2)') equals: #('o1' 'o2')