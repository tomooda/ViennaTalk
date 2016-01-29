tests-bound variables-definitions
testBoundVariablesTypeVariableIdentifierInto
	| node binds |
	node := ViennaVDMParser new typeVariableIdentifier end parse: '@t'.
	self deny: node isPetitFailure.
	self assert: node label = 'TypeVariableIdentifier'.
	binds := Set new.
	ViennaVDM2Smalltalk new boundVariables: node into: binds.
	self assert: binds equals: {'@t'} asSet