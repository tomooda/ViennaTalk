tests-code generation-expressions
testLetBeExpressionEnv
	| node |
	node := ViennaVDMParser new expression end parse: 'let x in set {1,2} be st x mod 2 = 0 in x + 1'.
	self deny: node isPetitFailure.
	self assert: node label = 'LetBeExpression'.
	self assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new)) equals: 3