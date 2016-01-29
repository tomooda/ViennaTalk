tests-bound variables-definitions
testBoundVariablesDocumentInto
	| node binds |
	node := ViennaVDMParser new document end parse: 'types t1 = t2; t3 = t4; values v1:t5 = e1; v2:t6 = e2'.
	self deny: node isPetitFailure.
	self assert: node label = 'Document'.
	binds := Set new.
	ViennaVDM2Smalltalk new boundVariables: node into: binds.
	self
		assert: binds
		equals:
			{'t1'.
			't3'.
			'v1'.
			'v2'} asSet.
	node := ViennaVDMParser new document end
		parse:
			'module m1 exports all definitions values v1 : t1 = e1 end m1 module m2 exports all definitions values v2 : t2 = e2 end m2'.
	self deny: node isPetitFailure.
	self assert: node label = 'Document'.
	binds := Set new.
	ViennaVDM2Smalltalk new boundVariables: node into: binds.
	self
		assert: binds
		equals:
			{'m1'.
			'm2'} asSet