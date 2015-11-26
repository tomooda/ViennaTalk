tests-operators
testInds
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: 'inds [10,20,30]'))
		equals: #(1 2 3) asSet