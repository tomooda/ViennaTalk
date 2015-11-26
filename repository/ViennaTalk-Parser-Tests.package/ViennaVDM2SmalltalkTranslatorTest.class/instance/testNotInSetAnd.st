tests-operators
testNotInSetAnd
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '1 not in set {1,...,10}'))
		equals: false.
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '0 not in set {1,...,10}'))
		equals: true