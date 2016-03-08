tests-bound variables-patterns and binds
testBoundVariablesPatternListInto
	| node binds |
	node := ViennaVDMParser new patternList end parse: 'v1, v2'.
	self deny: node isPetitFailure.
	self assert: node label = 'PatternList'.
	binds := Set new.
	ViennaVDM2SmalltalkScript new boundVariables: node into: binds.
	self
		assert: binds
		equals:
			{'v1'.
			'v2'} asSet