tests-expressions
testIsExpression4
	self assert: (grammar expression end parse: 'is_bool(e)') equals: #('bool' 'e')