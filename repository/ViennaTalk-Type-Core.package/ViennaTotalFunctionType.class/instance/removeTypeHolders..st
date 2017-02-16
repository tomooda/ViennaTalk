private
removeTypeHolders: aSet
	(aSet includes: self) ifTrue: [ ^self ].
	aSet add: self.
	argtypes := argtypes collect: [ :type | type removeTypeHolders: aSet ].
	returntype := returntype removeTypeHolders: aSet 