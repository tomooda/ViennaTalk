tests-code generation-expressions
testLetExpressionEnv
	| node |
	node := ViennaVDMParser new expression end parse: 'let x:nat = y+1, y:nat = 2, f:nat->nat f(n)==n+1 in f(x * y)'.
	self deny: node isPetitFailure.
	self assert: node label = 'LetExpression'.
	self assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new)) equals: 7