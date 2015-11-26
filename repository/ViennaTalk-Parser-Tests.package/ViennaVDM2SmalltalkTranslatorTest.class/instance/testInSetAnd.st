tests-operators
testInSetAnd
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '1 in set {1,...,10}'))
		equals: true.
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '0 in set {1,...,10}'))
		equals: false