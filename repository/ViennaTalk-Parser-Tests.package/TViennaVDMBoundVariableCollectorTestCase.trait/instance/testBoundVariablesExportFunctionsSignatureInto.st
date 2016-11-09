tests-bound variables-interfaces
testBoundVariablesExportFunctionsSignatureInto
	| node binds |
	node := ViennaVDMParser new exportFunctionsSignature end parse: 'functions f1[@t1,@t2]:t3->t4; f2[@t5,@t6]:t7->t8'.
	self deny: node isPetitFailure.
	self assert: node label = 'ExportFunctionsSignature'.
	binds := Set new.
	ViennaVDM2SmalltalkScript new boundVariables: node into: binds.
	self
		assert: binds
		equals:
			{'f1'.
			't3'.
			't4'.
			'f2'.
			't7'.
			't8'} asSet