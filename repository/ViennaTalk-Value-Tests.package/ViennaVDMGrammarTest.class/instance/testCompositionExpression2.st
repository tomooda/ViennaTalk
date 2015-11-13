tests-expressions
testCompositionExpression2
	self assert: (grammar expression end parse: 'e1 comp e2 comp e3') equals: #('e1' #('e2' 'e3'))