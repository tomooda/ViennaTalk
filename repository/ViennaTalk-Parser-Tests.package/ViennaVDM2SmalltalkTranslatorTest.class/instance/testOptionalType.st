tests-types
testOptionalType
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new type end parse: '[nat]'))
		equals: ViennaType nat optional