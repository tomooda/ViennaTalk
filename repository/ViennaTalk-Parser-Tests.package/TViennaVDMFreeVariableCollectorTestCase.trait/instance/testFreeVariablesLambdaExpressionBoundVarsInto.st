tests-free variables-expressions
testFreeVariablesLambdaExpressionBoundVarsInto
	| node binds |
	node := ViennaVDMParser new lambdaExpression end parse: 'lambda v : t & f(v)'.
	self deny: node isPetitFailure.
	self assert: node label = 'LambdaExpression'.
	binds := Set new.
	self
		assert: (ViennaVDM2SmalltalkScript new freeVariables: node env: Dictionary new)
		equals:
			{'t'.
			'f'} asSet