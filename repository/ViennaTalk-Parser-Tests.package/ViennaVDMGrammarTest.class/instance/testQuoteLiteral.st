tests-literals
testQuoteLiteral
	self assert: (grammar symbolicLiteral end parse: '<quote>') equals: '<quote>'