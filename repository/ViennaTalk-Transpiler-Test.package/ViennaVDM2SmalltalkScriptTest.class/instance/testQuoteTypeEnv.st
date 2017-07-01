tests-code generation-types
testQuoteTypeEnv
	| node |
	node := ViennaVDMParser new type end parse: '<quote>'.
	self deny: node isPetitFailure.
	self assert: node label = 'QuoteType'.
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkScript new generate: node)) equals: (ViennaType quote: #quote)