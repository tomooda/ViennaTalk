tests-definitions
testExplicitFunctionDefinition
	self
		assert:
			(Compiler
				evaluate:
					'|inc|'
						,
							(ViennaVDM2SmalltalkTranslator new explicitFunctionDefinition end parse: 'inc: int -> int inc(x) == x + 1') second
						, '. inc value: 2')
		equals: 3