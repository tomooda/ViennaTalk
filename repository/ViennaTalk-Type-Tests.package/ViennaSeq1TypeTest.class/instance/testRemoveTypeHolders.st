tests
testRemoveTypeHolders
	self
		assert: ViennaType nat asTypeHolder seq1 removeTypeHolders
		equals: ViennaType nat seq1