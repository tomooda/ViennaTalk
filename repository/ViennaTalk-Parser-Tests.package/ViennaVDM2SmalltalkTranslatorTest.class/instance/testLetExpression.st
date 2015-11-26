tests-expressions
testLetExpression
	self
		assert:
			(Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression parse: 'let s = power {<a>, <b>, <c>} in card s'))
		equals: 8