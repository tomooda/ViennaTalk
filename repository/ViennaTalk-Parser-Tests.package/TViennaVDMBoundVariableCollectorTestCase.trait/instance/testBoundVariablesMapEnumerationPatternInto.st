tests-bound variables-patterns and binds
testBoundVariablesMapEnumerationPatternInto
	| node binds |
	node := ViennaVDMParser new mapEnumerationPattern end parse: '{k1 |-> v1, k2 |-> v2}'.
	self deny: node isPetitFailure.
	self assert: node label = 'MapEnumerationPattern'.
	binds := Set new.
	ViennaVDM2Smalltalk new boundVariables: node into: binds.
	self
		assert: binds
		equals:
			{'k1'.
			'v1'.
			'k2'.
			'v2'} asSet