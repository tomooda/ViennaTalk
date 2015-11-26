tests-operators
testMunionAnd
	self
		assert:
			(Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '{1|->2, 2|->3} munion {2|->3, 4|->5}'))
		equals:
			(Dictionary new
				at: 1 put: 2;
				at: 2 put: 3;
				at: 4 put: 5;
				yourself)