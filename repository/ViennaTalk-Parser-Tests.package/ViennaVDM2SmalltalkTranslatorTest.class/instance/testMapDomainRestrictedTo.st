tests-operators
testMapDomainRestrictedTo
	self
		assert:
			(Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '{0,1,2} <: {1|->2, 2|->3, 4|->5}'))
		equals:
			(Dictionary new
				at: 1 put: 2;
				at: 2 put: 3;
				yourself)