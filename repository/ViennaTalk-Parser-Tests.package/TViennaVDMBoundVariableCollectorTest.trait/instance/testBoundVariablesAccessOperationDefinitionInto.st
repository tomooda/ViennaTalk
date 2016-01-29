tests-bound variables-definitions
testBoundVariablesAccessOperationDefinitionInto
	| node binds |
	node := ViennaVDMParser new accessOperationDefinition end parse: 'public op : t1 ==> t2 op(x) == return x'.
	self deny: node isPetitFailure.
	self assert: node label = 'AccessOperationDefinition'.
	binds := Set new.
	ViennaVDM2Smalltalk new boundVariables: node into: binds.
	self assert: binds equals: {'op'} asSet