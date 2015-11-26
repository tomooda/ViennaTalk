tests-patterns
testRecordPattern
	self
		assert:
			(Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: 'cases mk_t(1) : mk_t(a) -> a end'))
		equals: 1