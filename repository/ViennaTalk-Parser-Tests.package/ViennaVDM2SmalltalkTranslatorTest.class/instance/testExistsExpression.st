tests-expressions
testExistsExpression
	self
		assert:
			(Compiler
				evaluate:
					(ViennaVDM2SmalltalkTranslator new expression end parse: 'exists x, y in set {1,2}, z in set {2,3} & x + y = z'))
		equals: true.
	self
		assert:
			(Compiler
				evaluate:
					(ViennaVDM2SmalltalkTranslator new expression end parse: 'exists x, y in set {1,2}, z in set {2,3} & x = y and y = z'))
		equals: true.
	self
		assert:
			(Compiler
				evaluate:
					(ViennaVDM2SmalltalkTranslator new expression end parse: 'exists x, y in set {1,2}, z in set {2,3} & x + y + z < 0'))
		equals: false