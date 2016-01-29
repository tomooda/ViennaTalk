tests-bound variables-types
testBoundVariablesSetTypeInto
	| node binds |
	node := ViennaVDMParser new setType end parse: 'set of t'.
	self deny: node isPetitFailure.
	self assert: node label = 'SetType'.
	binds := Set new.
	ViennaVDM2Smalltalk new boundVariables: node into: binds.
	self assert: binds equals: {'t'} asSet