tests-free variables-expressions
testFreeVariablesRecordConstructorBoundVarsInto
	| node binds |
	node := ViennaVDMParser new recordConstructor end parse: 'mk_T(v)'.
	self deny: node isPetitFailure.
	self assert: node label = 'RecordConstructor'.
	binds := Set new.
	self
		assert: (ViennaVDM2Smalltalk new freeVariables: node env: Dictionary new)
		equals:
			{'T'.
			'v'} asSet