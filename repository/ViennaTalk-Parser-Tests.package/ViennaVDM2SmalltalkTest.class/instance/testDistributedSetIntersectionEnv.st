tests-code generation-expressions
testDistributedSetIntersectionEnv
	| node |
	node := ViennaVDMParser new expression end parse: 'dinter {{1,2,3},{2,3,4}}'.
	self deny: node isPetitFailure.
	self assert: node label = 'DistributedSetIntersection'.
	self
		assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new))
		equals:
			{2.
			3} asSet