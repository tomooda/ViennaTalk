tests-bound variables-definitions
testBoundVariablesExplicitOperationDefinitionInto
	| node binds |
	node := ViennaVDMParser new explicitOperationDefinition end parse: 'op: t1 ==> t2 op(x) == return e'.
	self deny: node isPetitFailure.
	self assert: node label = 'ExplicitOperationDefinition'.
	binds := Set new.
	ViennaVDM2SmalltalkScript new boundVariables: node into: binds.
	self assert: binds equals: {'op'} asSet