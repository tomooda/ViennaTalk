tests-bound variables-definitions
testBoundVariablesDefinitionBlockInto
	| node binds |
	node := ViennaVDMParser new definitionBlock end parse: 'values v1 = e1; v2 = e2'.
	self deny: node isPetitFailure.
	self assert: node label = 'DefinitionBlock'.
	binds := Set new.
	ViennaVDM2SmalltalkScript new boundVariables: node into: binds.
	self
		assert: binds
		equals:
			{'v1'.
			'v2'} asSet