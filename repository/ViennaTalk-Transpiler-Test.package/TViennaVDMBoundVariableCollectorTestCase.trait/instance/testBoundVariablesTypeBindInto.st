tests-bound variables-patterns and binds
testBoundVariablesTypeBindInto
	| node binds |
	node := ViennaVDMParser new typeBind end parse: 'v : t'.
	self deny: node isPetitFailure.
	self assert: node label = 'TypeBind'.
	binds := Set new.
	ViennaVDM2SmalltalkScript new boundVariables: node into: binds.
	self assert: binds equals: {'v'} asSet