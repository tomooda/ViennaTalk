tests-bound variables-types
testBoundVariablesOperationTypeInto
	| node binds |
	node := ViennaVDMParser new operationType end parse: 't1 ==> t2'.
	self deny: node isPetitFailure.
	self assert: node label = 'OperationType'.
	binds := Set new.
	ViennaVDM2Smalltalk new boundVariables: node into: binds.
	self
		assert: binds
		equals:
			{'t1'.
			't2'} asSet