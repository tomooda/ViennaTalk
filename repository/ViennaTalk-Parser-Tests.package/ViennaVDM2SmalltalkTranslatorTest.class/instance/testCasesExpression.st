tests-expressions
testCasesExpression
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: 'cases 1: a -> a + 1 end'))
		equals: 2