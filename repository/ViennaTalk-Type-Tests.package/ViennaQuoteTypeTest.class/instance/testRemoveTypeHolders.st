tests
testRemoveTypeHolders
	self
		assert: (ViennaType quote: #Q) asTypeHolder removeTypeHolders
		equals: (ViennaType quote: #Q)