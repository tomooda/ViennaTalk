tests-bound variables-definitions
testBoundVariablesAccessValueDefinitionInto
	| node binds |
	node := ViennaVDMParser new accessValueDefinition end parse: 'public v1 = e1'.
	self deny: node isPetitFailure.
	self assert: node label = 'AccessValueDefinition'.
	binds := Set new.
	ViennaVDM2SmalltalkScript new boundVariables: node into: binds.
	self assert: binds equals: {'v1'} asSet