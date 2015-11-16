tests-literals
testDicimalLiteral5
	self assert: (grammar expression end parse: '-1.0e+1') equals: '1.0e+1'