tests-literals
testBooleanLiteral2
	self assert: (grammar symbolicLiteral end parse: 'false') equals: 'false'