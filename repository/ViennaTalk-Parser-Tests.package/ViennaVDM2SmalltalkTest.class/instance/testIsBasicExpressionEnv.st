tests-code generation-expressions
testIsBasicExpressionEnv
	| node |
	node := ViennaVDMParser new expression end parse: 'is_nat(1)'.
	self deny: node isPetitFailure.
	self assert: node label = 'IsBasicExpression'.
	self assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new)) equals: true.
	node := ViennaVDMParser new expression end parse: 'is_nat(-1)'.
	self deny: node isPetitFailure.
	self assert: node label = 'IsBasicExpression'.
	self assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new)) equals: false