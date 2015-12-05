tests-statements
testCallStatement
	self
		assert:
			(Compiler
				evaluate: (ViennaVDM2SmalltalkTranslator new statement end parse: 'let inc = lambda x:nat&x+1 in return inc(2)'))
		equals: 3