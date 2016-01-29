tests-bound variables-patterns and binds
testBoundVariablesSetBindInto
	| node binds |
	node := ViennaVDMParser new setBind end parse: 'v in set s'.
	self deny: node isPetitFailure.
	self assert: node label = 'SetBind'.
	binds := Set new.
	ViennaVDM2Smalltalk new boundVariables: node into: binds.
	self assert: binds equals: {'v'} asSet