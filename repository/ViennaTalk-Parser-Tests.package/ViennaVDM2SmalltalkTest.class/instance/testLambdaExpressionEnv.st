tests-code generation-expressions
testLambdaExpressionEnv
	| node |
	node := ViennaVDMParser new expression end parse: 'lambda x:nat & x + 1'.
	self deny: node isPetitFailure.
	self assert: node label = 'LambdaExpression'.
	self assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node) , ' value: 2') equals: 3