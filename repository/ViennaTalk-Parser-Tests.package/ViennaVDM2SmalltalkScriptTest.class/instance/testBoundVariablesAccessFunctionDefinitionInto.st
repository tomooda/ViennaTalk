tests-bound variables-definitions
testBoundVariablesAccessFunctionDefinitionInto
	| node binds |
	node := ViennaVDMParser new accessFunctionDefinition end parse: 'public fn : t1 -> t2 fn(x) == x'.
	self deny: node isPetitFailure.
	self assert: node label = 'AccessFunctionDefinition'.
	binds := Set new.
	ViennaVDM2SmalltalkScript new boundVariables: node into: binds.
	self assert: binds equals: {'fn'} asSet