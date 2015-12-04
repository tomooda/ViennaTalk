tests-statements
testBlockStatement
	self
		assert:
			(Compiler
				evaluate:
					'| a |' , (ViennaVDM2SmalltalkTranslator new statement end parse: '(dcl b : nat := 2 ; a := b + 3)') , '. a')
		equals: 5