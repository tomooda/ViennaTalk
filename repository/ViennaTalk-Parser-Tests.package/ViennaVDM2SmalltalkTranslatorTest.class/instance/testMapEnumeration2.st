tests-expressions
testMapEnumeration2
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '{|->}'))
		equals: Dictionary new