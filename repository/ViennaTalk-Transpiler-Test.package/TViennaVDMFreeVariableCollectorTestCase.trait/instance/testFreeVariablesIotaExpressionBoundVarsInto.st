tests-free variables-expressions
testFreeVariablesIotaExpressionBoundVarsInto
	| node binds |
	node := ViennaVDMParser new iotaExpression end parse: 'iota v:t & p(v, e)'.
	self deny: node isPetitFailure.
	self assert: node label = 'IotaExpression'.
	binds := Set new.
	self
		assert: (ViennaVDM2SmalltalkScript new freeVariables: node env: Dictionary new)
		equals:
			{'t'.
			'p'.
			'e'} asSet