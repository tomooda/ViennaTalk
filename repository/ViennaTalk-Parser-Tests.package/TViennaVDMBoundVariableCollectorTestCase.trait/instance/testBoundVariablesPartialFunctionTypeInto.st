tests-bound variables-types
testBoundVariablesPartialFunctionTypeInto
	| node binds |
	node := ViennaVDMParser new partialFunctionType end parse: 't1 -> t2'.
	self deny: node isPetitFailure.
	self assert: node label = 'PartialFunctionType'.
	binds := Set new.
	ViennaVDM2Smalltalk new boundVariables: node into: binds.
	self
		assert: binds
		equals:
			{'t1'.
			't2'} asSet