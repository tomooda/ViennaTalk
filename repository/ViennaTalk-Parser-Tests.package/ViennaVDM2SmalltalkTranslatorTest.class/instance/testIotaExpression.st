tests-expressions
testIotaExpression
	self
		assert:
			(Compiler
				evaluate:
					(ViennaVDM2SmalltalkTranslator new expression parse: 'iota mk_(x,y) in set {mk_(1, 2), mk_(2, 3)} & x > 1'))
		equals: #(2 3).
	self
		should: [ Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression parse: 'iota x in set {1, 2, 3} & x < 0') ]
		raise: NotFound