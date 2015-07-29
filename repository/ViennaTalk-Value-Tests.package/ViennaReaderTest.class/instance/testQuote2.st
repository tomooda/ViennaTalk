tests
testQuote2
	self should: [reader parse: '<quo!te>'] raise: Error