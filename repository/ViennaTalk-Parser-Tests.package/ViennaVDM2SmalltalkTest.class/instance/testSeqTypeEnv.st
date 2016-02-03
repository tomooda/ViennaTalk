tests-code generation-types
testSeqTypeEnv
	| node |
	node := ViennaVDMParser new type end parse: 'seq of nat'.
	self deny: node isPetitFailure.
	self assert: node label = 'SeqType'.
	self assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node)) equals: ViennaType nat seq