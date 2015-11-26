tests-patterns
testPatternIdentifier
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: 'cases 1 : a -> a end'))
		equals: 1