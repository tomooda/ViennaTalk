tests-bound variables-patterns and binds
testBoundVariablesPatternIdentifierInto
	| node binds |
	node := ViennaVDMParser new patternIdentifier end parse: 'v'.
	self deny: node isPetitFailure.
	self assert: node label = 'PatternIdentifier'.
	binds := Set new.
	ViennaVDM2Smalltalk new boundVariables: node into: binds.
	self assert: binds equals: {'v'} asSet