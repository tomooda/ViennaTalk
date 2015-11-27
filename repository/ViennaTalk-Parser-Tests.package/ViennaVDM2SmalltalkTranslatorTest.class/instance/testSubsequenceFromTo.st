tests-operators
testSubsequenceFromTo
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '[10,20,30,40,50](2,...,3)'))
		equals: #(20 30) asOrderedCollection