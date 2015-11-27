tests-operators
testUnionAnd
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '{0,1,2} union {1,2,3}'))
		equals: #(0 1 2 3) asSet