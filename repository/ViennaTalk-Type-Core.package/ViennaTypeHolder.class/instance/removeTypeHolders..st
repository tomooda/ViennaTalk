accessing
removeTypeHolders: aSet
	(aSet includes: self) ifTrue: [ ^self ].
	aSet add: self.
	^ type removeTypeHolders: aSet