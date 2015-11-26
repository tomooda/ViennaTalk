tests-operators
testDinter
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: 'dinter {{1,2,3}, {2,3,4}}'))
		equals: #(2 3) asSet