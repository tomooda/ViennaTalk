tests-free variables-statements
testFreeVariablesFieldReferenceBoundVarsInto
	| node binds |
	node := ViennaVDMParser new indexForLoop end parse: 'for v = e1 to e2 by e3 do op(v)'.
	self deny: node isPetitFailure.
	self assert: node label = 'IndexForLoop'.
	binds := Set new.
	self
		assert: (ViennaVDM2SmalltalkScript new freeVariables: node env: Dictionary new)
		equals:
			{'e1'.
			'e2'.
			'e3'.
			'op'} asSet