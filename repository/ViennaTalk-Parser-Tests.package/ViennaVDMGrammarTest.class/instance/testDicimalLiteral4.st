tests-literals
testDicimalLiteral4
	self assert: (grammar expression end parse: '-1.0e1') equals: '1.0e1'