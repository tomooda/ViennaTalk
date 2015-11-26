tests-expressions
testMapComprehension
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression parse: '{ i |-> i+1 | i in set {1,...,9} & i mod 2 = 0}'))
		equals:
			(Dictionary new
				at: 2 put: 3;
				at: 4 put: 5;
				at: 6 put: 7;
				at: 8 put: 9;
				yourself)