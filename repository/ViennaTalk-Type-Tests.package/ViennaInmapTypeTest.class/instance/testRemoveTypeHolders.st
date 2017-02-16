tests
testRemoveTypeHolders
	self
		assert: (ViennaType int asTypeHolder inmapTo: ViennaType nat asTypeHolder) removeTypeHolders
		equals: (ViennaType int inmapTo: ViennaType nat)