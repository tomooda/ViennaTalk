tests-code generation-expressions
testLambdaExpressionEnv
	| node |
	node := ViennaVDMParser new expression end parse: 'lambda x:nat, mk_(y, z):nat*nat & x + y + z'.
	self deny: node isPetitFailure.
	self assert: node label = 'LambdaExpression'.
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkScript new generate: node) , ' value: 1 value: {2 . 3}') equals: 6