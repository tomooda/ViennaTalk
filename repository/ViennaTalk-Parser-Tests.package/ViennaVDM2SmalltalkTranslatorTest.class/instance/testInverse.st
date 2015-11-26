tests-operators
testInverse
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: 'inverse {1|->2, 2|->3}'))
		equals:
			(Dictionary new
				at: 3 put: 2;
				at: 2 put: 1;
				yourself)