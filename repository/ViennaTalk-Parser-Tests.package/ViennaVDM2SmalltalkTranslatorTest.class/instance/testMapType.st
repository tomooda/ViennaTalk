tests-types
testMapType
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new type end parse: 'map int to nat'))
		equals: (ViennaType int mapTo: ViennaType nat)