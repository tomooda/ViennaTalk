tests-patterns
testSetEnumPattern
	self
		assert:
			(Compiler
				evaluate:
					(ViennaVDM2SmalltalkTranslator new expression end parse: 'cases {{1}, {1, 2}} : {{a}, {1, b}} -> mk_(a, b) end'))
		equals: #(1 2)