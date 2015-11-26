tests-operators
testElems
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: 'elems [5,6,7]'))
		equals: #(5 6 7) asSet