private
removeTypeHolders: aSet
	(aSet includes: self) ifTrue: [ ^self ].
	aSet add: self.
	basetype := basetype removeTypeHolders: aSet