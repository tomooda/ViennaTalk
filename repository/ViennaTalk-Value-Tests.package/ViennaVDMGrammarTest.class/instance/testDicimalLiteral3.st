tests-literals
testDicimalLiteral3
	self assert: (grammar expression end parse: '-1.0') equals: '1.0'