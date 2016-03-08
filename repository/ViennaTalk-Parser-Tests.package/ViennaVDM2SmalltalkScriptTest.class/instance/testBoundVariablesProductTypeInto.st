tests-bound variables-types
testBoundVariablesProductTypeInto
	| node binds |
	node := ViennaVDMParser new productType end parse: 't1 * t2'.
	self deny: node isPetitFailure.
	self assert: node label = 'ProductType'.
	binds := Set new.
	ViennaVDM2SmalltalkScript new boundVariables: node into: binds.
	self
		assert: binds
		equals:
			{} asSet