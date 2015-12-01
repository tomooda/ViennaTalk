tests-types
testQuoteType
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new type end parse: '<QUOTE>'))
		equals: (ViennaType quote: '<QUOTE>')