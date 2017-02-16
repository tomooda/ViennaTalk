tests
testRemoveTypeHolders
	self
		assert: ViennaType nat asTypeHolder seq removeTypeHolders
		equals: ViennaType nat seq