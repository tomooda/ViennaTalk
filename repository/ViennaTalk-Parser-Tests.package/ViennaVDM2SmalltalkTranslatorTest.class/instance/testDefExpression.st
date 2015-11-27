tests-expressions
testDefExpression
	self
		assert:
			(Compiler
				evaluate:
					(ViennaVDM2SmalltalkTranslator new expression
						parse:
							'
			def
				s = power {<a>, <b>, <c>};
				mk_(a, b) = mk_(1, 2)
			in
				card s + a + b'))
		equals: 11