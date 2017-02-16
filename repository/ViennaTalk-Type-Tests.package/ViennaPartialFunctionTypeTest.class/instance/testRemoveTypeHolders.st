tests
testRemoveTypeHolders
	self
		assert: (ViennaType nat asTypeHolder -> ViennaType int asTypeHolder) removeTypeHolders
		equals: ViennaType nat -> ViennaType int