tests-expressions
testIsExpression2
	self assert: (grammar expression end parse: 'is_t(e1, e2)') isPetitFailure