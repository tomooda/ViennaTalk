tests-bound variables-interfaces
testBoundVariablesExportDefinitionInto
	| node binds |
	node := ViennaVDMParser new exportDefinition end parse: 'exports types t1; t2; values v1:t3; v2:t4'.
	self deny: node isPetitFailure.
	self assert: node label = 'ExportDefinition'.
	binds := Set new.
	ViennaVDM2Smalltalk new boundVariables: node into: binds.
	self
		assert: binds
		equals:
			{'t1'.
			't2'.
			't3'.
			't4'.
			'v1'.
			'v2'} asSet