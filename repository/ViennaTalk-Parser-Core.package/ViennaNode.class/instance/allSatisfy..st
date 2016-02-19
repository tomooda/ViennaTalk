enumerating
allSatisfy: aBlock
	self
		do: [ :node | 
			(aBlock value: node)
				ifFalse: [ ^ false ] ].
	^ true