tests-bound variables-patterns and binds
testBoundVariablesTuplePatternInto
	| node binds |
	node := ViennaVDMParser new tuplePattern end parse: 'mk_(v1, v2)'.
	self deny: node isPetitFailure.
	self assert: node label = 'TuplePattern'.
	binds := Set new.
	ViennaVDM2Smalltalk new boundVariables: node into: binds.
	self
		assert: binds
		equals:
			{'v1'.
			'v2'} asSet