tests-operators
testPsubsetAnd
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '{1} psubset {1, 2}'))
		equals: true.
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '{1, 2} psubset {1, 2}'))
		equals: false.
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '{0, 1} psubset {1, 2}'))
		equals: false