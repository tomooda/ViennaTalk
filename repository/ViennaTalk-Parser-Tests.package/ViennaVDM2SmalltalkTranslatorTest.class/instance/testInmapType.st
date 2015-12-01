tests-types
testInmapType
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new type end parse: 'inmap int to nat'))
		equals: (ViennaType int inmapTo: ViennaType nat)