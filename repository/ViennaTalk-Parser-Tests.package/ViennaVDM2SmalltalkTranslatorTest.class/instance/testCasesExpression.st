tests-expressions
testCasesExpression
	self
		assert:
			(Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: 'cases 2: 0, 1 -> -1, a -> a + 1 end'))
		equals: 3.
	self
		assert:
			(Compiler
				evaluate:
					(ViennaVDM2SmalltalkTranslator new expression end
						parse:
							'
			cases 1:
				0, 2, 3 -> 0, 
				4, 5, 6 -> 1, 
				others -> 2
			end'))
		equals: 2