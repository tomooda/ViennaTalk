private
removeTypeHolders: aSet
	(aSet includes: self) ifTrue: [ ^self ].
	aSet add: self.
	1 to: self size do: [ :index | 
		| field |
		field := self at: index.
		field at: 3 put: ((field at: 3) removeTypeHolders: aSet) ]