tests-types
testProductType
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new type end parse: 'bool*nat*int'))
		equals: ViennaType bool * ViennaType nat * ViennaType int