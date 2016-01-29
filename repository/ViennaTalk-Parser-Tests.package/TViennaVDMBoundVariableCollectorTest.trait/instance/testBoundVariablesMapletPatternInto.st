tests-bound variables-patterns and binds
testBoundVariablesMapletPatternInto
	| node binds |
	node := ViennaVDMParser new mapletPattern end parse: 'k |-> v'.
	self deny: node isPetitFailure.
	self assert: node label = 'MapletPattern'.
	binds := Set new.
	ViennaVDM2Smalltalk new boundVariables: node into: binds.
	self
		assert: binds
		equals:
			{'k'.
			'v'} asSet