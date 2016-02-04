tests-code generation-expressions
testSetComprehensionEnv
	| node |
	node := ViennaVDMParser new expression end parse: '{i*j| i, j in set {1,...,5} & i mod 2 = 0 and j mod 2 = 0}'.
	self deny: node isPetitFailure.
	self assert: node label = 'SetComprehension'.
	self
		assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new))
		equals:
			{4.
			8.
			16} asSet.
	node := ViennaVDMParser new expression end parse: '{i*j| mk_(i,j) in set { mk_(1, 2), mk_(2, 3), mk_(3, 4) } & i <= 2}'.
	self deny: node isPetitFailure.
	self assert: node label = 'SetComprehension'.
	self
		assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new))
		equals:
			{2.
			6} asSet