tests-bound variables-patterns and binds
testBoundVariablesMultipleTypeBindInto
	| node binds |
	node := ViennaVDMParser new multipleTypeBind end parse: 'v1, v2 : t'.
	self deny: node isPetitFailure.
	self assert: node label = 'MultipleTypeBind'.
	binds := Set new.
	ViennaVDM2SmalltalkScript new boundVariables: node into: binds.
	self
		assert: binds
		equals:
			{'v1'.
			'v2'} asSet