tests-expressions
testCasesExpression2
	self
		assert:
			(Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: 'cases 1: 0 -> a + 1, others -> 2 end'))
		equals: 2