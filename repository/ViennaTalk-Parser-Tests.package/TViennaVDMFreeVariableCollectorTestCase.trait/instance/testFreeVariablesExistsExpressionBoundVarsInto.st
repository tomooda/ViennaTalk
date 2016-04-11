tests-free variables-expressions
testFreeVariablesExistsExpressionBoundVarsInto
	| node binds |
	node := ViennaVDMParser new existsExpression end parse: 'exists v1:t, v2 in set s & p(v1, v2, e)'.
	self deny: node isPetitFailure.
	self assert: node label = 'ExistsExpression'.
	binds := Set new.
	self
		assert: (ViennaVDM2Smalltalk new freeVariables: node env: Dictionary new)
		equals:
			{'t'.
			's'.
			'p'.
			'e'} asSet