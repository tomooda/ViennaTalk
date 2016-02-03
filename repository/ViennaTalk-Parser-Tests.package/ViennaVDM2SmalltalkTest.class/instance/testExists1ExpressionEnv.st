tests-code generation-expressions
testExists1ExpressionEnv
	| node |
	node := ViennaVDMParser new expression end parse: 'exists1 x in set {1,2} & x mod 2 = 1'.
	self deny: node isPetitFailure.
	self assert: node label = 'Exists1Expression'.
	self assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new)) equals: true.
	node := ViennaVDMParser new expression end parse: 'exists1 x in set {1,2,3} & x mod 2 = 1'.
	self deny: node isPetitFailure.
	self assert: node label = 'Exists1Expression'.
	self assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new)) equals: false.
	node := ViennaVDMParser new expression end parse: 'exists1 x in set {1,2} & x = 3'.
	self deny: node isPetitFailure.
	self assert: node label = 'Exists1Expression'.
	self assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new)) equals: false