tests-types
testInvariantInitialFunction
	self
		assert: (ViennaVDMGrammar new invariantInitialFunction end parse: 'p == e')
		equals:
			{'p'.
			'e'}