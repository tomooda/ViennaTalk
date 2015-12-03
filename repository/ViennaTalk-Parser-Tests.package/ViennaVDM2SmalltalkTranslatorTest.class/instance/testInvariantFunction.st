tests-types
testInvariantFunction
	self
		assert:
			(Compiler
				evaluate: (ViennaVDM2SmalltalkTranslator new invariantFunction end parse: 'mk_(a, b) == a > b') , ' value: {2 . 1}')
		equals: true.
	self
		assert:
			(Compiler
				evaluate: (ViennaVDM2SmalltalkTranslator new invariantFunction end parse: 'mk_(a, b) == a > b') , ' value: {2 . 3}')
		equals: false.
	self
		assert:
			(Compiler evaluate: (ViennaVDM2SmalltalkTranslator new invariantFunction end parse: 'mk_(a, b) == a > b') , ' value: 1')
		equals: false