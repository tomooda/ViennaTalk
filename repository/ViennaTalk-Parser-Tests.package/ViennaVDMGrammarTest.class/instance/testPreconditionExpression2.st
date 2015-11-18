tests-expressions
testPreconditionExpression2
	self assert: (grammar expression end parse: 'pre_(e1, e2)') equals: #('e1' 'e2')