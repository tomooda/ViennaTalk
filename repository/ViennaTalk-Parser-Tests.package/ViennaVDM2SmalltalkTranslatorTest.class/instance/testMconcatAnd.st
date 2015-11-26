tests-operators
testMconcatAnd
	self
		assert:
			(Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '{1|->2, 2|->3} ++ {2|->4, 4|->5}'))
		equals:
			(Dictionary new
				at: 1 put: 2;
				at: 2 put: 4;
				at: 4 put: 5;
				yourself)