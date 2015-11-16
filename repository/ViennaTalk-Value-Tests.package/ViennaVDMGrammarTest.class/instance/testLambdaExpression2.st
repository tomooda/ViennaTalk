tests-expressions
testLambdaExpression2
	self assert: (grammar expression end parse: 'lambda v1,v2:t&e') isPetitFailure