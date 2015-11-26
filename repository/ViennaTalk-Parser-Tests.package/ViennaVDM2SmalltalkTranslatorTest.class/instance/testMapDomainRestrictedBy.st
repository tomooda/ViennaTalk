tests-operators
testMapDomainRestrictedBy
	self
		assert:
			(Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '{0,1,2} <-: {1|->2, 2|->3, 4|->5}'))
		equals:
			(Dictionary new
				at: 4 put: 5;
				yourself)