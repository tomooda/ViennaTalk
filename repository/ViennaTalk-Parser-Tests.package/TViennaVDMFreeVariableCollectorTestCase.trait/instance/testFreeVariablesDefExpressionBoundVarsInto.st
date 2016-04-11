tests-free variables-expressions
testFreeVariablesDefExpressionBoundVarsInto
	| node binds |
	node := ViennaVDMParser new defExpression end parse: 'def v1 : t1 = f(v2) ; v2 : t2 = e1 in f(v1, v2)'.
	self deny: node isPetitFailure.
	self assert: node label = 'DefExpression'.
	binds := Set new.
	self
		assert: (ViennaVDM2Smalltalk new freeVariables: node env: Dictionary new)
		equals:
			{'t1'.
			'f'.
			't2'.
			'e1'.
			'f'} asSet