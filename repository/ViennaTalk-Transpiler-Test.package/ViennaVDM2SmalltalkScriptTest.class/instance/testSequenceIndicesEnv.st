tests-code generation-expressions
testSequenceIndicesEnv
	| node |
	node := ViennaVDMParser new expression end parse: 'inds [4,5,6]'.
	self deny: node isPetitFailure.
	self assert: node label = 'SequenceIndices'.
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkScript new generate: node env: Dictionary new))
		equals:
			{1.
			2.
			3} asSet