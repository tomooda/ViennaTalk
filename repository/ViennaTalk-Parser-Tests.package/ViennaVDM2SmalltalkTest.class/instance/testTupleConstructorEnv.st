tests-code generation-expressions
testTupleConstructorEnv
	| node |
	node := ViennaVDMParser new expression end parse: 'mk_(1,2,3)'.
	self deny: node isPetitFailure.
	self assert: node label = 'TupleConstructor'.
	self
		assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new))
		equals:
			{1.
			2.
			3}