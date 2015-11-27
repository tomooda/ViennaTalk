tests-expressions
testExists1Expression
	self
		assert:
			(Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression parse: 'exists1 x in set {1, 2, 3} & x < 2'))
		equals: true.
	self
		assert:
			(Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression parse: 'exists1 x in set {1, 2, 3} & x < 0'))
		equals: false.
	self
		assert:
			(Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression parse: 'exists1 x in set {1, 2, 3} & x <= 2'))
		equals: false