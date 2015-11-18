tests-expressions
testUnaryPlus1
	self assert: (grammar expression end parse: '+e') equals: 'e'