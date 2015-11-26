tests-operators
testDunion
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: 'dunion {{1,2,3}, {2,3,4}}'))
		equals: #(1 2 3 4) asSet