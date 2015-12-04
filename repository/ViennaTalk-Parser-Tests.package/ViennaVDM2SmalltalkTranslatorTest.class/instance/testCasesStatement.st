tests-statements
testCasesStatement
	self
		assert:
			(Compiler
				evaluate:
					(ViennaVDM2SmalltalkTranslator new statement end parse: 'cases 2: 0, 1 -> return -1, a -> return a + 1 end'))
		equals: 3.
	self
		assert:
			(Compiler
				evaluate:
					(ViennaVDM2SmalltalkTranslator new statement end
						parse:
							'
			cases 1:
				0, 2, 3 -> return 0, 
				4, 5, 6 -> return 1, 
				others -> return 2
			end'))
		equals: 2