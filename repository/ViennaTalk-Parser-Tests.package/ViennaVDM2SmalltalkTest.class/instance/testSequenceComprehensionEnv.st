tests-code generation-expressions
testSequenceComprehensionEnv
	| node |
	node := ViennaVDMParser new expression end parse: '[i*2| i in set {1,...,5}]'.
	self deny: node isPetitFailure.
	self assert: node label = 'SequenceComprehension'.
	self
		assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new))
		equals:
			{2.
			4.
			6.
			8.
			10} asOrderedCollection.
	node := ViennaVDMParser new expression end parse: '[i*2| i in set {1,...,5} & i mod 2 = 0]'.
	self deny: node isPetitFailure.
	self assert: node label = 'SequenceComprehension'.
	self
		assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new))
		equals:
			{4.
			8} asOrderedCollection.
	node := ViennaVDMParser new expression end parse: '[i*2| i in set {1,2,3,4,5}]'.
	self deny: node isPetitFailure.
	self assert: node label = 'SequenceComprehension'.
	self
		assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new))
		equals:
			{2.
			4.
			6.
			8.
			10} asOrderedCollection.
	node := ViennaVDMParser new expression end parse: '[i*2| i in set {1,2,3,4,5} & i mod 2 = 0]'.
	self deny: node isPetitFailure.
	self assert: node label = 'SequenceComprehension'.
	self
		assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new))
		equals:
			{4.
			8} asOrderedCollection