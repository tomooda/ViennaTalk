tests-code generation-expressions
testDefExpressionEnv
	| node |
	node := ViennaVDMParser new expression end parse: 'def  y : nat = x + 1; x : nat = 1 in x + y'.
	self deny: node isPetitFailure.
	self assert: node label = 'DefExpression'.
	self assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new)) equals: 3.
	node := ViennaVDMParser new expression end parse: 'def  mk_(x, y) = mk_(1, 2) in x + y'.
	self deny: node isPetitFailure.
	self assert: node label = 'DefExpression'.
	self assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new)) equals: 3