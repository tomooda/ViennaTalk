tests-free variables-statements
testFreeVariablesLetStatementBoundVarsInto
	| node binds |
	node := ViennaVDMParser new letStatement end parse: 'let v1 : t1 =e, v2 : t2 = f(v1) in op(v1, v2)'.
	self deny: node isPetitFailure.
	self assert: node label = 'LetStatement'.
	binds := Set new.
	self
		assert: (ViennaVDM2SmalltalkScript new freeVariables: node env: Dictionary new)
		equals:
			{'t1'.
			'f'.
			't2'.
			'e'.
			'op'} asSet