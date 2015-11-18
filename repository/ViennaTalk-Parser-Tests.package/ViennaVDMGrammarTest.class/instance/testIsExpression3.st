tests-expressions
testIsExpression3
	self assert: (grammar expression end parse: 'is_ t(e1)') isPetitFailure