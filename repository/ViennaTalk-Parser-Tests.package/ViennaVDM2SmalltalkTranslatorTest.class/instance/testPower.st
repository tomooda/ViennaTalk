tests-operators
testPower
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: 'power {1,2,3}'))
		equals:
			{({} asSet).
			({1} asSet).
			({2} asSet).
			({3} asSet).
			({1.
			2} asSet).
			({2.
			3} asSet).
			({1.
			3} asSet).
			({1.
			2.
			3} asSet)} asSet