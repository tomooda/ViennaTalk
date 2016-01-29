tests-bound variables-patterns and binds
testBoundVariablesSetEnumPatternInto
	| node binds |
	node := ViennaVDMParser new setEnumPattern end parse: '{v1, v2}'.
	self deny: node isPetitFailure.
	self assert: node label = 'SetEnumPattern'.
	binds := Set new.
	ViennaVDM2Smalltalk new boundVariables: node into: binds.
	self
		assert: binds
		equals:
			{'v1'.
			'v2'} asSet