tests-patterns
testSeqConcPattern
	self
		assert:
			(Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: 'cases [ 1,2,3 ] : [a]^[2,3] -> a end'))
		equals: 1