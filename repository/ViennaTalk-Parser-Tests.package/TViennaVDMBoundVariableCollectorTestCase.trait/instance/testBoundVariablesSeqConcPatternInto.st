tests-bound variables-patterns and binds
testBoundVariablesSeqConcPatternInto
	| node binds |
	node := ViennaVDMParser new seqConcPattern  end parse: '[v1, v2] ^ [v3]'.
	self deny: node isPetitFailure.
	self assert: node label = 'SeqConcPattern'.
	binds := Set new.
	ViennaVDM2SmalltalkScript new boundVariables: node into: binds.
	self
		assert: binds
		equals:
			{'v1'.
			'v2'.
			'v3'} asSet