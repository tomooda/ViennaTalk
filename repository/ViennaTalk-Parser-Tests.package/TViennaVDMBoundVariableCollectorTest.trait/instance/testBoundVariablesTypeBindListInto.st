tests-bound variables-patterns and binds
testBoundVariablesTypeBindListInto
	| node binds |
	node := ViennaVDMParser new typeBindList end parse: 'v1 : t1, v2 : t2'.
	self deny: node isPetitFailure.
	self assert: node label = 'TypeBindList'.
	binds := Set new.
	ViennaVDM2Smalltalk new boundVariables: node into: binds.
	self
		assert: binds
		equals:
			{'v1'.
			'v2'} asSet