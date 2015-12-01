tests-types
testSetType
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new type end parse: 'set of nat'))
		equals: ViennaType nat set