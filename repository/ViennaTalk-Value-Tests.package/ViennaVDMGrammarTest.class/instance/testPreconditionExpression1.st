tests-expressions
testPreconditionExpression1
	self assert: (grammar expression end parse: 'pre_(e)') equals: #('e')