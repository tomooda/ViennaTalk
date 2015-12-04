tests-statements
testDefStatement
	self
		assert:
			(Compiler
				evaluate: '| a |' , (ViennaVDM2SmalltalkTranslator new statement end parse: 'def b : nat = 1 in a := b + 2') , '. a')
		equals: 3