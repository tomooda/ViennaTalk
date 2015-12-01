tests-types
testSeq1Type
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new type end parse: 'seq1 of nat'))
		equals: ViennaType nat seq1