tests-bound variables-interfaces
testBoundVariablesExportModuleSignatureInto
	| node binds |
	node := ViennaVDMParser new exportModuleSignature end parse: 'values v1 : t1; types t2'.
	self deny: node isPetitFailure.
	self assert: node label = 'ExportModuleSignature'.
	binds := Set new.
	ViennaVDM2Smalltalk new boundVariables: node into: binds.
	self
		assert: binds
		equals:
			{'v1'.
			't1'.
			't2'} asSet