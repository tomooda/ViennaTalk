tests-expressions
testForallExpression
	self
		assert:
			(Compiler
				evaluate:
					(ViennaVDM2SmalltalkTranslator new expression end parse: 'forall x, y in set {1,2}, z in set {5,6} & x + y < z'))
		equals: true.
	self
		assert:
			(Compiler
				evaluate:
					(ViennaVDM2SmalltalkTranslator new expression end parse: 'forall x, y in set {1,2}, z in set {2,3} & x + y < z'))
		equals: false