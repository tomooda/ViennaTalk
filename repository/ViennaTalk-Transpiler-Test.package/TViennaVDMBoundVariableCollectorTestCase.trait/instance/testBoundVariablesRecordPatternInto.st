tests-bound variables-patterns and binds
testBoundVariablesRecordPatternInto
	| node binds |
	node := ViennaVDMParser new recordPattern end parse: 'mk_T(v1, v2)'.
	self deny: node isPetitFailure.
	self assert: node label = 'RecordPattern'.
	binds := Set new.
	ViennaVDM2SmalltalkScript new boundVariables: node into: binds.
	self
		assert: binds
		equals:
			{'v1'.
			'v2'} asSet