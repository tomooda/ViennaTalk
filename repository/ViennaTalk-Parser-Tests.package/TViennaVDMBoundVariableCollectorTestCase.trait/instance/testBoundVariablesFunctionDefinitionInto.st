tests-bound variables-definitions
testBoundVariablesFunctionDefinitionInto
	| node binds |
	node := ViennaVDMParser new functionDefinition end parse: 'fn[@t] : t1 -> t2 fn(x) == e'.
	self deny: node isPetitFailure.
	self assert: node label = 'FunctionDefinition'.
	binds := Set new.
	ViennaVDM2SmalltalkScript new boundVariables: node into: binds.
	self assert: binds equals: {'fn'} asSet