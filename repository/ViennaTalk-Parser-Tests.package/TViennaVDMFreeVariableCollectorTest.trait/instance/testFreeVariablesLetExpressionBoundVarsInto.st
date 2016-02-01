tests-free variables-expressions
testFreeVariablesLetExpressionBoundVarsInto
	| node binds |
	node := ViennaVDMParser new letExpression end parse: 'let v1 : t1 = f(v2), v2 : t2 = e in g(v1, v2)'.
	self deny: node isPetitFailure.
	self assert: node label = 'LetExpression'.
	binds := Set new.
	self
		assert: (ViennaVDM2Smalltalk new freeVariables: node env: Dictionary new)
		equals:
			{'t1'.
			'f'.
			't2'.
			'e'.
			'g'} asSet