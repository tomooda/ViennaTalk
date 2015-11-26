tests-operators
testConcatAnd
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '[1,2,3]^[4,5,6]'))
		equals: #(1 2 3 4 5 6) asOrderedCollection