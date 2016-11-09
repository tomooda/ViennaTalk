tests-free variables-statements
testFreeVariablesSequenceForLoopBoundVarsInto
	| node |
	node := ViennaVDMParser new sequenceForLoop end parse: 'for v in s do op(v)'.
	self deny: node isPetitFailure.
	self assert: node label = 'SequenceForLoop'.
	self
		assert: (ViennaVDM2SmalltalkScript new freeVariables: node env: Dictionary new)
		equals:
			{'s'.
			'op'} asSet