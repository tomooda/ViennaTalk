tests-code generation-statements
testAlwaysStatementEnv
	self
		assert:
			(Compiler
				evaluate:
					' | a | ['
						,
							(ViennaVDM2SmalltalkScript new
								generate: (ViennaVDMParser new statement parse: 'always a := 2 in return 1'))
						, '] value')
		equals: 1.
	self
		assert:
			(Compiler
				evaluate:
					' | a | ['
						,
							(ViennaVDM2SmalltalkScript new
								generate: (ViennaVDMParser new statement parse: 'always a := 2 in return 1'))
						, '] value. a')
		equals: 2.
	self
		assert:
			(Compiler
				evaluate:
					' | a | ['
						,
							(ViennaVDM2SmalltalkScript new
								generate: (ViennaVDMParser new statement parse: 'always a := 2 in exit 1'))
						, '] on: ViennaException do: [:ex | ex return]. a')
		equals: 2