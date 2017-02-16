tests
testRemoveTypeHolders
	self
		assert: ViennaType nat asTypeHolder optional removeTypeHolders
		equals: ViennaType nat optional