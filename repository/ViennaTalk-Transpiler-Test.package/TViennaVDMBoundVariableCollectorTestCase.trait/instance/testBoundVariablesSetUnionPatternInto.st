tests-bound variables-patterns and binds
testBoundVariablesSetUnionPatternInto
	| node binds |
	node := ViennaVDMParser new setUnionPattern end parse: '{v1, v2} union {v3}'.
	self deny: node isPetitFailure.
	self assert: node label = 'SetUnionPattern'.
	binds := Set new.
	ViennaVDM2Smalltalk new boundVariables: node into: binds.
	self
		assert: binds
		equals:
			{'v1'.
			'v2'.
			'v3'} asSet