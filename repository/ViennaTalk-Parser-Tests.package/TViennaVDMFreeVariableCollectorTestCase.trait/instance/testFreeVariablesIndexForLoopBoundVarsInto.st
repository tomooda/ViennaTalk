tests-free variables-statements
testFreeVariablesIndexForLoopBoundVarsInto
	| node |
	node := ViennaVDMParser new indexForLoop end parse: 'for v = e1 to e2 by e3 do op(v)'.
	self deny: node isPetitFailure.
	self assert: node label = 'IndexForLoop'.
	self
		assert: (ViennaVDM2Smalltalk new freeVariables: node env: Dictionary new)
		equals:
			{'e1'.
			'e2'.
			'e3'.
			'op'} asSet