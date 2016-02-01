tests-free variables-statements
testFreeVariablesLetBeStatementBoundVarsInto
	| node binds |
	node := ViennaVDMParser new letBeStatement end parse: 'let v in set s be st p(v) in op(v)'.
	self deny: node isPetitFailure.
	self assert: node label = 'LetBeStatement'.
	binds := Set new.
	self
		assert: (ViennaVDM2Smalltalk new freeVariables: node env: Dictionary new)
		equals:
			{'s'.
			'p'.
			'op'} asSet