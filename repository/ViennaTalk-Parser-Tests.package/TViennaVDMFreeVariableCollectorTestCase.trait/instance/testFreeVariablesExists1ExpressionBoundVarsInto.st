tests-free variables-expressions
testFreeVariablesExists1ExpressionBoundVarsInto
	| node binds |
	node := ViennaVDMParser new exists1Expression end parse: 'exists1 v:t & p(v, e)'.
	self deny: node isPetitFailure.
	self assert: node label = 'Exists1Expression'.
	binds := Set new.
	self
		assert: (ViennaVDM2Smalltalk new freeVariables: node env: Dictionary new)
		equals:
			{'t'.
			'p'.
			'e'} asSet