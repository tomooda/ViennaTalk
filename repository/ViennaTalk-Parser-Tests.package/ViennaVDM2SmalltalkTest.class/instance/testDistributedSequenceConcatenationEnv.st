tests-code generation-expressions
testDistributedSequenceConcatenationEnv
	| node |
	node := ViennaVDMParser new expression end parse: 'conc [[1,2,3],[4,5,6]]'.
	self deny: node isPetitFailure.
	self assert: node label = 'DistributedSequenceConcatenation'.
	self
		assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new))
		equals:
			{1.
			2.
			3.
			4.
			5.
			6} asOrderedCollection