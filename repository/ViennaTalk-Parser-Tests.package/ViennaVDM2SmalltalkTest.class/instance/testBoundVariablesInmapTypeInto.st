tests-bound variables-types
testBoundVariablesInmapTypeInto
	| node binds |
	node := ViennaVDMParser new inmapType end parse: 'inmap t1 to t2'.
	self deny: node isPetitFailure.
	self assert: node label = 'InmapType'.
	binds := Set new.
	ViennaVDM2Smalltalk new boundVariables: node into: binds.
	self
		assert: binds
		equals:
			{} asSet