tests-operators
testDiffAnd
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '{1,2,3} \ {2,3,4}'))
		equals: #(1) asSet