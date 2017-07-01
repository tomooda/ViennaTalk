tests-code generation-expressions
testSequenceConcatenateEnv
	| node |
	node := ViennaVDMParser new expression end parse: '[1,2,3]^[4,5,6]'.
	self deny: node isPetitFailure.
	self assert: node label = 'SequenceConcatenate'.
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkScript new generate: node env: Dictionary new))
		equals:
			{1.
			2.
			3.
			4.
			5.
			6} asOrderedCollection