tests-bound variables-types
testBoundVariablesSeqTypeInto
	| node binds |
	node := ViennaVDMParser new seqType end parse: 'seq of t'.
	self deny: node isPetitFailure.
	self assert: node label = 'SeqType'.
	binds := Set new.
	ViennaVDM2Smalltalk new boundVariables: node into: binds.
	self assert: binds equals: {} asSet