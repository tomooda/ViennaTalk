tests-bound variables-definitions
testBoundVariablesTypeDefinitionInto
	| node binds |
	node := ViennaVDMParser new typeDefinition end parse: 't1 = t2 inv v == e'.
	self deny: node isPetitFailure.
	self assert: node label = 'TypeDefinition'.
	binds := Set new.
	ViennaVDM2SmalltalkScript new boundVariables: node into: binds.
	self assert: binds equals: {'t1'} asSet