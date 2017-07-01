tests-code generation-statements
testTixeStatementEnv
	self
		assert:
			(Compiler
				evaluate:
					(ViennaVDM2SmalltalkScript new
						generate: (ViennaVDMParser new statement parse: 'tixe { mk_(-, -) |-> return 1, p |-> return p+2 } in exit 3')))
		equals: 5.
