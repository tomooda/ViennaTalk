tests-operators
testRng
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: 'rng {1|->2, 2|->3}'))
		equals: #(2 3) asSet