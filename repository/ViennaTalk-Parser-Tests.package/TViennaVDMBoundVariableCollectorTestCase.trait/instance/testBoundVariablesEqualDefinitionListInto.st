tests-bound variables-definitions
testBoundVariablesEqualDefinitionListInto
	| node binds |
	node := ViennaVDMParser new equalDefinitionList end parse: 'v1 : t1 = e1; v2 : t2 = e2'.
	self deny: node isPetitFailure.
	self assert: node label = 'EqualDefinitionList'.
	binds := Set new.
	ViennaVDM2Smalltalk new boundVariables: node into: binds.
	self
		assert: binds
		equals:
			{'v1'.
			'v2'} asSet