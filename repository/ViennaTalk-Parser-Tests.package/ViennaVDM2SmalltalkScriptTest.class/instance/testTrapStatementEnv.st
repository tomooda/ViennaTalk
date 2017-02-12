tests-code generation-statements
testTrapStatementEnv
	self
		assert:
			(Compiler
				evaluate:
					(ViennaVDM2SmalltalkScript new
						generate: (ViennaVDMParser new statement parse: 'trap p with return p in exit 1')))
		equals: 1.
	self
		assert:
			(Compiler
				evaluate:
					(ViennaVDM2SmalltalkScript new
						generate: (ViennaVDMParser new statement parse: 'trap - with return 1 in exit nil')))
		equals: 1