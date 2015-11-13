tests-expressions
testUnaryMinus1
	self assert: (grammar expression end parse: '-e') equals: 'e'