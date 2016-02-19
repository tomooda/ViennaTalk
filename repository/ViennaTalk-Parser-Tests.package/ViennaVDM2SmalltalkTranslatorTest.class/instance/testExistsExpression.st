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
		equals: false.
	self
		assert:
			(Compiler
				evaluate:
					(ViennaVDM2SmalltalkTranslator new expression end
						parse: 'exists mk_(x, y) in set {mk_(1,2), mk_(2, 3)}, z in set {2,3} & x + y + z < 0'))
		equals: false