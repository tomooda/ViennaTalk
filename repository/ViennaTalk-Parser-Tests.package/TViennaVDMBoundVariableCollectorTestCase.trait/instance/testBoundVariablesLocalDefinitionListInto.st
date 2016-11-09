tests-bound variables-definitions
testBoundVariablesLocalDefinitionListInto
	| node binds |
	node := ViennaVDMParser new localDefinitionList end parse: 'v1 : t1 = e1, fn[@t] : t2 -> t3 fn(x) == e2'.
	self deny: node isPetitFailure.
	self assert: node label = 'LocalDefinitionList'.
	binds := Set new.
	ViennaVDM2SmalltalkScript new boundVariables: node into: binds.
	self
		assert: binds
		equals:
			{'v1'.
			'fn'} asSet