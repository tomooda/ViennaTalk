tests-patterns
testSetUnionPattern
	self
		assert:
			(Compiler
				evaluate:
					(ViennaVDM2SmalltalkTranslator new expression end parse: 'cases {{1}, {1, 2}} : {a} union {{1, b}} -> mk_(a, b) end'))
		equals:
			{(#(1) asSet).
			2}