tests-patterns
testMatchValueExpression
	self
		assert:
			(Compiler
				evaluate:
					(ViennaVDM2SmalltalkTranslator new expression end parse: 'cases {{1}, {1, 2}} : {{a}, ({1,...,2})} -> a end'))
		equals: 1