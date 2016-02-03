tests-code generation-expressions
testExistsExpressionEnv
	| node |
	node := ViennaVDMParser new expression end parse: 'exists x in set {1,2}, y in set { 2, 3 } & x = y'.
	self deny: node isPetitFailure.
	self assert: node label = 'ExistsExpression'.
	self assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new)) equals: true.
	node := ViennaVDMParser new expression end parse: 'exists x in set {1,2,3}, y in set {2,3,4} & x = y'.
	self deny: node isPetitFailure.
	self assert: node label = 'ExistsExpression'.
	self assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new)) equals: true.
	node := ViennaVDMParser new expression end parse: 'exists x in set {1,2}, y in set {3,4} & x = y'.
	self deny: node isPetitFailure.
	self assert: node label = 'ExistsExpression'.
	self assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new)) equals: false