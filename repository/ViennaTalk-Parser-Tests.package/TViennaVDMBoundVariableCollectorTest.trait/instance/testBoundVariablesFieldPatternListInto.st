tests-bound variables-patterns and binds
testBoundVariablesFieldPatternListInto
	| node binds |
	node := ViennaVDMParser new fieldPatternList end parse: 'f1 |-> v1, f2 |-> v2'.
	self deny: node isPetitFailure.
	self assert: node label = 'FieldPatternList'.
	binds := Set new.
	ViennaVDM2Smalltalk new boundVariables: node into: binds.
	self
		assert: binds
		equals:
			{'v1'.
			'v2'} asSet