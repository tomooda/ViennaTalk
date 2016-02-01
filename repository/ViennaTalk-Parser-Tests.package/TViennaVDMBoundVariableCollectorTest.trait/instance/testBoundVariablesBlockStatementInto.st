tests-bound variables-statements
testBoundVariablesBlockStatementInto
	| node binds |
	node := ViennaVDMParser new blockStatement end
		parse: '(dcl v1:t1 := e, v2:t1 := v1; dcl v3:t3 := f(v1, v2); op(v1, v2, v3))'.
	self deny: node isPetitFailure.
	self assert: node label = 'BlockStatement'.
	binds := Set new.
	ViennaVDM2Smalltalk new boundVariables: node into: binds.
	self
		assert: binds
		equals:
			{'v1'.
			'v2'.
			'v3'} asSet