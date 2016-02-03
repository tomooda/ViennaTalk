tests-code generation-expressions
testMapComprehensionEnv
	| node |
	node := ViennaVDMParser new expression end parse: '{i |-> i mod 5 + 1 | i in set {1,...,10} & i <= 5}'.
	self deny: node isPetitFailure.
	self assert: node label = 'MapComprehension'.
	self
		assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new))
		equals:
			{(1 -> 2).
			(2 -> 3).
			(3 -> 4).
			(4 -> 5).
			(5 -> 1)} asDictionary