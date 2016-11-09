tests-bound variables-patterns and binds
testBoundVariablesSeqEnumPatternInto
	| node binds |
	node := ViennaVDMParser new seqEnumPattern end parse: '[v1, v2]'.
	self deny: node isPetitFailure.
	self assert: node label = 'SeqEnumPattern'.
	binds := Set new.
	ViennaVDM2SmalltalkScript new boundVariables: node into: binds.
	self
		assert: binds
		equals:
			{'v1'.
			'v2'} asSet