tests-code generation-expressions
testDistributedSetUnionEnv
	| node |
	node := ViennaVDMParser new expression end parse: 'dunion {{1,2,3},{2,3,4}}'.
	self deny: node isPetitFailure.
	self assert: node label = 'DistributedSetUnion'.
	self
		assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new))
		equals:
			{1.
			2.
			3.
			4} asSet