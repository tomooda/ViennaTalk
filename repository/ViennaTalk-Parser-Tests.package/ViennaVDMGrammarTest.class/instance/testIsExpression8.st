tests-expressions
testIsExpression8
	self assert: (grammar expression end parse: 'is_(e1, e2, e3)') isPetitFailure