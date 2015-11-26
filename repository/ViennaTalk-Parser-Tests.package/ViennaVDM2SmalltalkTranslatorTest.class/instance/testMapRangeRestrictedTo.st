tests-operators
testMapRangeRestrictedTo
	self
		assert:
			(Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '{1|->2, 2|->3, 4|->5} :> {1,2}'))
		equals:
			(Dictionary new
				at: 1 put: 2;
				yourself)