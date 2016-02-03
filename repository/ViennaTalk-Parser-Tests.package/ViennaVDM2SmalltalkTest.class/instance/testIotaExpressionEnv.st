tests-code generation-expressions
testIotaExpressionEnv
	| node |
	node := ViennaVDMParser new expression end parse: 'iota x in set {3, 4} & x mod 2 = 1'.
	self deny: node isPetitFailure.
	self assert: node label = 'IotaExpression'.
	self assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new)) equals: 3.
	node := ViennaVDMParser new expression end parse: 'iota x in set {2, 4} & x mod 2 = 1'.
	self deny: node isPetitFailure.
	self assert: node label = 'IotaExpression'.
	self should: [ Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new) ] raise: ViennaNoMatch