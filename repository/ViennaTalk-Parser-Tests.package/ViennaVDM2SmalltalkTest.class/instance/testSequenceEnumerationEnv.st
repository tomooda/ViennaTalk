tests-code generation-expressions
testSequenceEnumerationEnv
	| node |
	node := ViennaVDMParser new expression end parse: '[4,5,6]'.
	self deny: node isPetitFailure.
	self assert: node label = 'SequenceEnumeration'.
	self
		assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new))
		equals:
			{4.
			5.
			6} asOrderedCollection