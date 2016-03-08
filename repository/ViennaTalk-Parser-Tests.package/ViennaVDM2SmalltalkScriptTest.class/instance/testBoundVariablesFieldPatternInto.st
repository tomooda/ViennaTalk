tests-bound variables-patterns and binds
testBoundVariablesFieldPatternInto
	| node binds |
	node := ViennaVDMParser new fieldPattern end parse: 'f1 |-> v'.
	self deny: node isPetitFailure.
	self assert: node label = 'FieldPattern'.
	binds := Set new.
	ViennaVDM2SmalltalkScript new boundVariables: node into: binds.
	self assert: binds equals: {'v'} asSet