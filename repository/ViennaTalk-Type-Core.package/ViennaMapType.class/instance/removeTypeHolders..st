private
removeTypeHolders: aSet
	(aSet includes: self) ifTrue: [ ^self ].
	aSet add: self.
	keytype := keytype removeTypeHolders: aSet.
	valuetype := valuetype removeTypeHolders: aSet