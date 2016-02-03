tests-code generation-expressions
testSetComprehensionEnv
	| node |
	node := ViennaVDMParser new expression end parse: '{i| i in set {1,...,5} & i mod 2 = 0}'.
	self deny: node isPetitFailure.
	self assert: node label = 'SetComprehension'.
	self
		assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new))
		equals:
			{2.
			4} asSet