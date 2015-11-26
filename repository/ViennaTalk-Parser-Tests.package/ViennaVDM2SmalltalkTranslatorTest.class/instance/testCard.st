tests-operators
testCard
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: 'card {1,...,10}'))
		equals: 10