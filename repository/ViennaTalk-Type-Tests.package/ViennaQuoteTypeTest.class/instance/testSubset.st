tests
testSubset
	self assert: quote <= quote.
	self deny: quote <= (ViennaType quote: '<ANOTHER>')