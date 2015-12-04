tests-statements
testLetStatement
	self
		assert:
			(Compiler
				evaluate: '| a |' , (ViennaVDM2SmalltalkTranslator new statement end parse: 'let b : nat = 1 in a := b') , '. a')
		equals: 1