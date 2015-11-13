tests-literals
testNilLiteral
	self assert: (grammar symbolicLiteral end parse: 'nil') equals: 'nil'