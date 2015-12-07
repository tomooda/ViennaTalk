tests-definitions
testStateDefinition
	self
		assert:
			(Compiler
				evaluate:
					' | a b c |'
						,
							(ViennaVDM2SmalltalkTranslator new stateDefinition end
								parse: 'state S of a : int b : nat c : nat1 init s == s = mk_S(0, 1, 2) end') second , '{a . b . c}')
		equals: #(0 1 2)