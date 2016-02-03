tests-code generation-types
testSeq1TypeEnv
	| node |
	node := ViennaVDMParser new type end parse: 'seq1 of nat'.
	self deny: node isPetitFailure.
	self assert: node label = 'Seq1Type'.
	self assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node)) equals: ViennaType nat seq1