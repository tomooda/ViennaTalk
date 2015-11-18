tests-expressions
testIsExpression6
	self assert: (grammar expression end parse: 'is_ bool(e)') isPetitFailure