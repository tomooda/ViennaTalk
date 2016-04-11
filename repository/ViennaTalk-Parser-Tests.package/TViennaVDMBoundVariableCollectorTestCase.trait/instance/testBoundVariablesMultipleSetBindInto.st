tests-bound variables-patterns and binds
testBoundVariablesMultipleSetBindInto
	| node binds |
	node := ViennaVDMParser new multipleSetBind end parse: 'v1, v2 in set s'.
	self deny: node isPetitFailure.
	self assert: node label = 'MultipleSetBind'.
	binds := Set new.
	ViennaVDM2Smalltalk new boundVariables: node into: binds.
	self
		assert: binds
		equals:
			{'v1'.
			'v2'} asSet