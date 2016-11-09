tests-bound variables-types
testBoundVariablesUnionTypeInto
	| node binds |
	node := ViennaVDMParser new unionType end parse: 't1 | t2'.
	self deny: node isPetitFailure.
	self assert: node label = 'UnionType'.
	binds := Set new.
	ViennaVDM2SmalltalkScript new boundVariables: node into: binds.
	self
		assert: binds
		equals:
			{} asSet