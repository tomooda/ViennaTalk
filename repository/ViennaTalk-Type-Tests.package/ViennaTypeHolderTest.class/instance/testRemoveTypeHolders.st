tests
testRemoveTypeHolders
	self
		assert: (ViennaType nat asTypeHolder mapTo: ViennaType int) asTypeHolder removeTypeHolders
		equals: (ViennaType nat mapTo: ViennaType int)