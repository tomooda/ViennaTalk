tests-operators
testConc
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: 'conc [[1,2,3],[4,5,6]]'))
		equals: #(1 2 3 4 5 6) asOrderedCollection