tests-bound variables-definitions
testBoundVariablesAccessTypeDefinitionInto
	| node binds |
	node := ViennaVDMParser new accessTypeDefinition end parse: 'public t1 = t2 inv v == e'.
	self deny: node isPetitFailure.
	self assert: node label = 'AccessTypeDefinition'.
	binds := Set new.
	ViennaVDM2Smalltalk new boundVariables: node into: binds.
	self assert: binds equals: {'t1'} asSet