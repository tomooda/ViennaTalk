tests-operators
testMapRangeRestrictedBy
	self
		assert:
			(Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '{1|->2, 2|->3, 4|->5} :-> {1,2}'))
		equals:
			(Dictionary new
				at: 2 put: 3;
				at: 4 put: 5;
				yourself)