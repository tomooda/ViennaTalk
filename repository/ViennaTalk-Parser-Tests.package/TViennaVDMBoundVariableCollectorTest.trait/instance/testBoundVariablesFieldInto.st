test-bound variables-types
testBoundVariablesFieldInto
	| node binds |
	node := ViennaVDMParser new field end parse: 'f : t'.
	self deny: node isPetitFailure.
	self assert: node label = 'Field'.
	binds := Set new.
	ViennaVDM2Smalltalk new boundVariables: node into: binds.
	self assert: binds equals: {'f'} asSet.
	node := ViennaVDMParser new field end parse: 'f :- t'.
	self deny: node isPetitFailure.
	self assert: node label = 'Field'.
	binds := Set new.
	ViennaVDM2Smalltalk new boundVariables: node into: binds.
	self assert: binds equals: {'f'} asSet.
	node := ViennaVDMParser new field end parse: 't'.
	self deny: node isPetitFailure.
	self assert: node label = 'Field'.
	binds := Set new.
	ViennaVDM2Smalltalk new boundVariables: node into: binds.
	self assert: binds equals: {} asSet