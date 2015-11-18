tests-expressions
testCompositionExpression1
	self assert: (grammar expression end parse: 'e1 comp e2') equals: #('e1' 'e2')