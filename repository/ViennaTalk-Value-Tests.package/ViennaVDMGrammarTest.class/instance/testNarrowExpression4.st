tests-expressions
testNarrowExpression4
	self assert: (grammar expression end parse: 'narrow_(e1,e2,e3)') isPetitFailure