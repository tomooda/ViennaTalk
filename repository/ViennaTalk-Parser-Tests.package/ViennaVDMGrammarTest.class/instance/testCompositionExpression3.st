tests-expressions
testCompositionExpression3
	self assert: (grammar expression end parse: 'e1 ** e2 comp e3') equals: #(#('e1' 'e2') 'e3')