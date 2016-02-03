tests
testSubtype
	self assert: quote <= quote.
	self deny: quote <= (ViennaType quote: 'ANOTHER')