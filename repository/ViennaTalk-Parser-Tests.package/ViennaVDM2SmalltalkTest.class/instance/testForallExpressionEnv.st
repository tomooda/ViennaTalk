tests-code generation-expressions
testForallExpressionEnv
	| node |
	node := ViennaVDMParser new expression end
		parse: 'forall x in set {1, 3, 5}, y in set {2, 4, 6} & x mod 2 = y mod 2 + 1'.
	self deny: node isPetitFailure.
	self assert: node label = 'ForallExpression'.
	self assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new)) equals: true.
	node := ViennaVDMParser new expression end parse: 'forall x in set {1, 2, 3} & x mod 2 = 1'.
	self deny: node isPetitFailure.
	self assert: node label = 'ForallExpression'.
	self assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new)) equals: false