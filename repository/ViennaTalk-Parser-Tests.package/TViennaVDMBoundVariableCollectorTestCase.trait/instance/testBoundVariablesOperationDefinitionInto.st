tests-bound variables-definitions
testBoundVariablesOperationDefinitionInto
	| node binds |
	node := ViennaVDMParser new operationDefinition end parse: 'op: t1 ==> t2 op(x) == return e'.
	self deny: node isPetitFailure.
	self assert: node label = 'OperationDefinition'.
	binds := Set new.
	ViennaVDM2Smalltalk new boundVariables: node into: binds.
	self assert: binds equals: {'op'} asSet