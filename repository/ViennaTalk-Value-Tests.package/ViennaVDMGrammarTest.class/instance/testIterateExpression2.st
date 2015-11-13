tests-expressions
testIterateExpression2
	self assert: (grammar expression end parse: 'e1 ** e2 ** e3') equals: #('e1' #('e2' 'e3'))