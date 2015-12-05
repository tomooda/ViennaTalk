tests-definitions
testExplicitOperationDefinition
	self
		assert:
			(Compiler
				evaluate:
					'|inc|'
						,
							(ViennaVDM2SmalltalkTranslator new explicitOperationDefinition end
								parse:
									'inc : int ==> int 
									inc(x) == return x + 1') second , '. inc value: 2')
		equals: 3