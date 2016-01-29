tests-bound variables-definitions
testBoundVariablesEqualDefinitionInto
	| node binds |
	node := ViennaVDMParser new equalDefinition end parse: 'v1 : t1 = e1'.
	self deny: node isPetitFailure.
	self assert: node label = 'EqualDefinition'.
	binds := Set new.
	ViennaVDM2Smalltalk new boundVariables: node into: binds.
	self assert: binds equals: {'v1'} asSet