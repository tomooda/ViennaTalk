tests-free variables-expressions
testFreeVariablesLetBeExpressionBoundVarsInto
	| node binds |
	node := ViennaVDMParser new letBeExpression end parse: 'let v in set s be st p(v) in f(v)'.
	self deny: node isPetitFailure.
	self assert: node label = 'LetBeExpression'.
	binds := Set new.
	self
		assert: (ViennaVDM2Smalltalk new freeVariables: node env: Dictionary new)
		equals:
			{'s'.
			'p'.
			'f'} asSet