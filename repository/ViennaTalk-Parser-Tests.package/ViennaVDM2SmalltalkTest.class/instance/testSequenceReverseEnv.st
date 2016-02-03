tests-code generation-expressions
testSequenceReverseEnv
	| node |
	node := ViennaVDMParser new expression end parse: 'reverse [4,5,6]'.
	self deny: node isPetitFailure.
	self assert: node label = 'SequenceReverse'.
	self
		assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new))
		equals:
			{6.
			5.
			4} asOrderedCollection