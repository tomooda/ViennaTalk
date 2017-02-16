tests
testRemoveTypeHolders
	| inv |
	inv := [ :i | true ].
	self assert: (int asTypeHolder inv: inv) removeTypeHolders equals: (int inv: inv)