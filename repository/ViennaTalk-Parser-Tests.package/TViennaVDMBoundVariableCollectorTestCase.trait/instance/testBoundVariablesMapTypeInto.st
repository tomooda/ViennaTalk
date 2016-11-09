tests-bound variables-types
testBoundVariablesMapTypeInto
	| node binds |
	node := ViennaVDMParser new mapType end parse: 'map t1 to t2'.
	self deny: node isPetitFailure.
	self assert: node label = 'MapType'.
	binds := Set new.
	ViennaVDM2SmalltalkScript new boundVariables: node into: binds.
	self
		assert: binds
		equals:
			{} asSet