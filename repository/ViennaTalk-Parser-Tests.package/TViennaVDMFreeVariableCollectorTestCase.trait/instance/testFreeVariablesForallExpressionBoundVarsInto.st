tests-free variables-expressions
testFreeVariablesForallExpressionBoundVarsInto
	| node binds |
	node := ViennaVDMParser new forallExpression end parse: 'forall v1:t, v2 in set s & p(v1, v2, e)'.
	self deny: node isPetitFailure.
	self assert: node label = 'ForallExpression'.
	binds := Set new.
	self
		assert: (ViennaVDM2SmalltalkScript new freeVariables: node env: Dictionary new)
		equals:
			{'t'.
			's'.
			'p'.
			'e'} asSet