tests-free variables-expressions
testFreeVariablesSequenceComprehensionBoundVarsInto
	| node binds |
	node := ViennaVDMParser new sequenceComprehension end parse: '[f(v) | v in set s & p(v)]'.
	self deny: node isPetitFailure.
	self assert: node label = 'SequenceComprehension'.
	binds := Set new.
	self
		assert: (ViennaVDM2SmalltalkScript new freeVariables: node env: Dictionary new)
		equals:
			{'f'.
			's'.
			'p'} asSet