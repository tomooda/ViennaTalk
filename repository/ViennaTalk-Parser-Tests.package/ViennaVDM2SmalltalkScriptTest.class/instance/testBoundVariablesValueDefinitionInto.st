tests-bound variables-definitions
testBoundVariablesValueDefinitionInto
	| node binds |
	node := ViennaVDMParser new valueDefinition end parse: 'v : t = e'.
	self deny: node isPetitFailure.
	self assert: node label = 'ValueDefinition'.
	binds := Set new.
	ViennaVDM2SmalltalkScript new boundVariables: node into: binds.
	self assert: binds equals: {'v'} asSet