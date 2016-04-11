tests-bound variables-interfaces
testBoundVariablesFunctionExportInto
	| node binds |
	node := ViennaVDMParser new functionExport end parse: 'f1[@t1,@t2]:t3->t4'.
	self deny: node isPetitFailure.
	self assert: node label = 'FunctionExport'.
	binds := Set new.
	ViennaVDM2Smalltalk new boundVariables: node into: binds.
	self
		assert: binds
		equals:
			{'f1'.
			't3'.
			't4'} asSet