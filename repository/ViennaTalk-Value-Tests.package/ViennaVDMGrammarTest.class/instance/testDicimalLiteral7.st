tests-literals
testDicimalLiteral7
	self assert: (grammar expression end parse: '-1e-1') equals: '1e-1'