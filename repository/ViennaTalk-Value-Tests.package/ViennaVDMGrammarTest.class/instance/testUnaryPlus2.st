tests-expressions
testUnaryPlus2
	self assert: (grammar expression end parse: '+ e') equals: 'e'