tests-bound variables-patterns and binds
testBoundVariablesBindListInto
	| node binds |
	node := ViennaVDMParser new bindList end parse: 'v1 : t1, v2 in set s1'.
	self deny: node isPetitFailure.
	self assert: node label = 'BindList'.
	binds := Set new.
	ViennaVDM2Smalltalk new boundVariables: node into: binds.
	self
		assert: binds
		equals:
			{'v1'.
			'v2'} asSet