enumerating
allSatisfy: aBlock
	self
		do: [ :value | 
			(aBlock value: value)
				ifFalse: [ ^ false ] ].
	^ true