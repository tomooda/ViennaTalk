tests-definitions
testValueDefinition
	self
		assert:
			(Compiler
				evaluate: '|one|' , (ViennaVDM2SmalltalkTranslator new valueDefinition end parse: 'one = 1') second , '. one + 2')
		equals: 3