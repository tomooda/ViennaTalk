tests-bound variables-definitions
testBoundVariablesLocalDefinitionInto
	| node binds |
	node := ViennaVDMParser new localDefinition end parse: 'v1 : t1 = e1'.
	self deny: node isPetitFailure.
	self assert: node label = 'LocalDefinition'.
	binds := Set new.
	ViennaVDM2Smalltalk new boundVariables: node into: binds.
	self assert: binds equals: {'v1'} asSet