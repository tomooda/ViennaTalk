tests-bound variables-interfaces
testBoundVariablesExportTypesSignatureInto
	| node binds |
	node := ViennaVDMParser new exportTypesSignature end parse: 'types t1; t2'.
	self deny: node isPetitFailure.
	self assert: node label = 'ExportTypesSignature'.
	binds := Set new.
	ViennaVDM2Smalltalk new boundVariables: node into: binds.
	self
		assert: binds
		equals:
			{'t1'.
			't2'} asSet