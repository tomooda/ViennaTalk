tests-types
testPartialFunctionType
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new type end parse: 'int -> nat'))
		equals: ViennaType int -> ViennaType nat