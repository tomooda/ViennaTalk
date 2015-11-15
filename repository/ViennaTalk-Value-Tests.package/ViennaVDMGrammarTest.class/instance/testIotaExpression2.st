tests-expressions
testIotaExpression2
	self assert: (grammar expression end parse: 'iota v1, v2 in set s & e') isPetitFailure