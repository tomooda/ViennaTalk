tests-free variables-expressions
testFreeVariablesSetComprehensionBoundVarsInto
	| node binds |
	node := ViennaVDMParser new setComprehension end parse: '{f(v) | v in set s & p(v)}'.
	self deny: node isPetitFailure.
	self assert: node label = 'SetComprehension'.
	binds := Set new.
	self
		assert: (ViennaVDM2Smalltalk new freeVariables: node env: Dictionary new)
		equals:
			{'f'.
			's'.
			'p'} asSet