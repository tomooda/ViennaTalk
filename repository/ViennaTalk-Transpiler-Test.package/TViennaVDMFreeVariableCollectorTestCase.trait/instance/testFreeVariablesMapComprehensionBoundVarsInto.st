tests-free variables-expressions
testFreeVariablesMapComprehensionBoundVarsInto
	| node binds |
	node := ViennaVDMParser new mapComprehension end parse: '{f(v1) |-> g(v2) | v1, v2 in set s & p(v1, v2)}'.
	self deny: node isPetitFailure.
	self assert: node label = 'MapComprehension'.
	binds := Set new.
	self
		assert: (ViennaVDM2SmalltalkScript new freeVariables: node env: Dictionary new)
		equals:
			{'f'.
			'g'.
			's'.
			'p'} asSet