tests-bound variables-patterns and binds
testBoundVariablesMapMunionPatternInto
	| node binds |
	node := ViennaVDMParser new mapMunionPattern end parse: '{k1 |-> v1, k2 |-> v2} munion {k3 |-> v3}'.
	self deny: node isPetitFailure.
	self assert: node label = 'MapMunionPattern'.
	binds := Set new.
	ViennaVDM2SmalltalkScript new boundVariables: node into: binds.
	self
		assert: binds
		equals:
			{'k1'.
			'v1'.
			'k2'.
			'v2'.
			'k3'.
			'v3'} asSet