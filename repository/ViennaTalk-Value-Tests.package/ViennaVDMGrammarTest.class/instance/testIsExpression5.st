tests-expressions
testIsExpression5
	self assert: (grammar expression end parse: 'is_bool(e1, e2)') isPetitFailure