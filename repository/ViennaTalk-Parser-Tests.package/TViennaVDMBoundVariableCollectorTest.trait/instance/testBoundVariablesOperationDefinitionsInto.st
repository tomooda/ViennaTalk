tests-bound variables-definitions
testBoundVariablesOperationDefinitionsInto
	| node binds |
	node := ViennaVDMParser new operationDefinitions end
		parse: 'operations op1: t1 ==> t2 op1(x) == return e1; op2: t3 ==> t4 op2(y) == return e2'.
	self deny: node isPetitFailure.
	self assert: node label = 'OperationDefinitions'.
	binds := Set new.
	ViennaVDM2Smalltalk new boundVariables: node into: binds.
	self
		assert: binds
		equals:
			{'op1'.
			'op2'} asSet