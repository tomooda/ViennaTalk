tests-literals
testHexadecimalLiteral2
	self assert: (grammar expression end parse: '0X0') equals: '0'