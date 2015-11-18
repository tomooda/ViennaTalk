tests-literals
testBooleanLiteral1
	self assert: (grammar symbolicLiteral end parse: 'true') equals: 'true'