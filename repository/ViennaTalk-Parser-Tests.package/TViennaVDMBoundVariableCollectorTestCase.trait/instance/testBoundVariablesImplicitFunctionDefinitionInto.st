tests-bound variables-definitions
testBoundVariablesImplicitFunctionDefinitionInto
	| node binds |
	node := ViennaVDMParser new implicitFunctionDefinition end parse: 'fn[@t](p1:t1,p2:t2)i:t post b'.
	self deny: node isPetitFailure.
	self assert: node label = 'ImplicitFunctionDefinition'.
	binds := Set new.
	ViennaVDM2SmalltalkScript new boundVariables: node into: binds.
	self assert: binds equals: {'fn'. 'post_fn'} asSet