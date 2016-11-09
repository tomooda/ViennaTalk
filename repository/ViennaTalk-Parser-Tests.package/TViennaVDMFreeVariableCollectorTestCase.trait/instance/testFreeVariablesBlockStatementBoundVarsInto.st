tests-free variables-statements
testFreeVariablesBlockStatementBoundVarsInto
	| node binds |
	node := ViennaVDMParser new blockStatement end parse: '(dcl v1:t1 := e1; dcl v2:t2 := f(v1); op(v1, v2))'.
	self deny: node isPetitFailure.
	self assert: node label = 'BlockStatement'.
	binds := Set new.
	self
		assert: (ViennaVDM2SmalltalkScript new freeVariables: node env: Dictionary new)
		equals:
			{'t1'.
			'e1'.
			't2'.
			'f'.
			'op'} asSet