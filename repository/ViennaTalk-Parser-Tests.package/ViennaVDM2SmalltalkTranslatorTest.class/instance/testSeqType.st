tests-types
testSeqType
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new type end parse: 'seq of nat'))
		equals: ViennaType nat seq