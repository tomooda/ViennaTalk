tests-statements
testLetBeStatement
	self
		assert:
			(Compiler
				evaluate:
					'| a |' , (ViennaVDM2SmalltalkTranslator new statement end parse: 'let b in set {1, 2} be st b mod 2 = 0 in a := b')
						, '. a')
		equals: 2