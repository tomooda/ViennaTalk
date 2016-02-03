tests-code generation-expressions
testSequenceTailEnv
	| node |
	node := ViennaVDMParser new expression end parse: 'tl [4,5,6]'.
	self deny: node isPetitFailure.
	self assert: node label = 'SequenceTail'.
	self
		assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new))
		equals:
			{5.
			6} asOrderedCollection