tests-operators
testSubsetAnd
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '{1} subset {1, 2}'))
		equals: true.
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '{1, 2} subset {1, 2}'))
		equals: true.
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '{0, 1} subset {1, 2}'))
		equals: false