tests-patterns
testMapEnumerationPattern
	self
		assert:
			(Compiler
				evaluate:
					(ViennaVDM2SmalltalkTranslator new expression end
						parse: 'cases { 1 |-> 2, 2 |-> 3 } : { a |-> b, b |-> c } -> mk_(a, b, c) end'))
		equals: #(1 2 3)