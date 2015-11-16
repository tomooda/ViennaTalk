tests-literals
testHexadecimalLiteral1
	self assert: (grammar expression end parse: '0x0') equals: '0'