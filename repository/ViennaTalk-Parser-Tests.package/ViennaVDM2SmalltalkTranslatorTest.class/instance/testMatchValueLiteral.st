tests-patterns
testMatchValueLiteral
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: 'cases {1,2} : {a, 2} -> a end'))
		equals: 1