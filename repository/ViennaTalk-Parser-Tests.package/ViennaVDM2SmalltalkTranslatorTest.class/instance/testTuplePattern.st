tests-patterns
testTuplePattern
	self
		assert:
			(Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: 'cases mk_(1,2,3) : mk_(a,2,3) -> a end'))
		equals: 1