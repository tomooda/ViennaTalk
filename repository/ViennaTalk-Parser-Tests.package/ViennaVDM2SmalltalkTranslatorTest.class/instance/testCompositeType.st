tests-types
testCompositeType
	self
		assert:
			(Compiler evaluate: (ViennaVDM2SmalltalkTranslator new type end parse: 'compose T of bool i : int n :- nat end'))
		equals:
			(ViennaType
				compose: 'T'
				of:
					{{nil.
					false.
					(ViennaType bool)}.
					{'i'.
					false.
					(ViennaType int)}.
					{'n'.
					true.
					(ViennaType nat)}})