tests-bound variables-types
testBoundVariablesTotalFunctionTypeInto
	| node binds |
	node := ViennaVDMParser new totalFunctionType end parse: 't1 +> t2'.
	self deny: node isPetitFailure.
	self assert: node label = 'TotalFunctionType'.
	binds := Set new.
	ViennaVDM2SmalltalkScript new boundVariables: node into: binds.
	self
		assert: binds
		equals:
			{} asSet