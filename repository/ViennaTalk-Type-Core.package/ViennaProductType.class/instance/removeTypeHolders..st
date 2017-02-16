private
removeTypeHolders: aSet
	(aSet includes: self) ifTrue: [ ^self ].
	aSet add: self.
	basetypes := basetypes collect: [ :type | type removeTypeHolders: aSet ]