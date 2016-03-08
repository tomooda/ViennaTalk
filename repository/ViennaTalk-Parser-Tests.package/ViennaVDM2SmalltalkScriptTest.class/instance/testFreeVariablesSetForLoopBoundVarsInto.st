tests-free variables-statements
testFreeVariablesSetForLoopBoundVarsInto
	| node |
	node := ViennaVDMParser new setForLoop end parse: 'for all v in set s do op(v)'.
	self deny: node isPetitFailure.
	self assert: node label = 'SetForLoop'.
	self
		assert: (ViennaVDM2SmalltalkScript new freeVariables: node env: Dictionary new)
		equals:
			{'s'.
			'op'} asSet