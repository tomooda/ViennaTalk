tests
testRemoveTypeHolders
	self
		assert: ViennaType nat asTypeHolder set1 removeTypeHolders
		equals: ViennaType nat set1