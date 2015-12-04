tests-statements
testMultipleAssignStatement
	self
		assert:
			(Compiler
				evaluate:
					'| a b |' , (ViennaVDM2SmalltalkTranslator new statement end parse: 'atomic(a := 2 * 3; b := 4)') , '. {a. b}')
		equals: #(6 4)