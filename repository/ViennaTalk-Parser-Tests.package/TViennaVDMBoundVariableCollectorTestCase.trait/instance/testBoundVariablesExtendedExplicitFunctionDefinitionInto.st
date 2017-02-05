tests-bound variables-definitions
testBoundVariablesExtendedExplicitFunctionDefinitionInto
	| node binds |
	node := ViennaVDMParser new extendedExplicitFunctionDefinition end
		parse: 'fn[@t](x:t1) res:t2 == e post b'.
	self deny: node isPetitFailure.
	self assert: node label = 'ExtendedExplicitFunctionDefinition'.
	binds := Set new.
	ViennaVDM2SmalltalkScript new boundVariables: node into: binds.
	self assert: binds equals: {'fn' . 'post_fn'} asSet