tests-bound variables-patterns and binds
testBoundVariablesObjectPatternInto
	| node binds |
	node := ViennaVDMParser new objectPattern end parse: 'obj_T(f1 |-> v1, f2 |-> v2)'.
	self deny: node isPetitFailure.
	self assert: node label = 'ObjectPattern'.
	binds := Set new.
	ViennaVDM2Smalltalk new boundVariables: node into: binds.
	self
		assert: binds
		equals:
			{'v1'.
			'v2'} asSet