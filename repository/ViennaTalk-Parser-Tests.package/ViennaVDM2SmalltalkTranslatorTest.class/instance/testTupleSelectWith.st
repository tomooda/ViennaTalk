tests-operators
testTupleSelectWith
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: 'mk_(10, 20, 30).#2'))
		equals: 20