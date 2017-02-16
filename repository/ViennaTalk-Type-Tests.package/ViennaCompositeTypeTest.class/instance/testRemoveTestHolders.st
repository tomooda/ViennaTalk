running
testRemoveTestHolders
	self
		assert:
			(ViennaCompositeType
				constructorName: 'T'
				withAll:
					{{nil.
					false.
					ViennaType int asTypeHolder}.
					{'f2'.
					true.
					ViennaType nat asTypeHolder}.
					{'f3'.
					false.
					(ViennaType quote: '<QUOTE>')}}) removeTypeHolders
		equals:
			(ViennaCompositeType
				constructorName: 'T'
				withAll:
					{{nil.
					false.
					ViennaType int}.
					{'f2'.
					true.
					ViennaType nat}.
					{'f3'.
					false.
					(ViennaType quote: '<QUOTE>')}})