tests-code generation-expressions
testSequenceElementsEnv
	| node |
	node := ViennaVDMParser new expression end parse: 'elems [4,5,6]'.
	self deny: node isPetitFailure.
	self assert: node label = 'SequenceElements'.
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkScript new generate: node env: Dictionary new))
		equals:
			{4.
			5.
			6} asSet