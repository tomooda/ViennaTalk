tests-expressions
testSetMembership
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression parse: '2 in set dom {1|->"one", 2|->"two", 3|->"three"}'))
		equals: true