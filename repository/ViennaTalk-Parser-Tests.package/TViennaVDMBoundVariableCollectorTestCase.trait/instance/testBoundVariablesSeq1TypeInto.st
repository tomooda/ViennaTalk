tests-bound variables-types
testBoundVariablesSeq1TypeInto
	| node binds |
	node := ViennaVDMParser new seq1Type end parse: 'seq1 of t'.
	self deny: node isPetitFailure.
	self assert: node label = 'Seq1Type'.
	binds := Set new.
	ViennaVDM2Smalltalk new boundVariables: node into: binds.
	self assert: binds equals: {'t'} asSet