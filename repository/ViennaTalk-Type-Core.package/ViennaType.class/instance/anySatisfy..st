enumerating
anySatisfy: aBlock
	self
		do: [ :value | 
			(aBlock value: value)
				ifTrue: [ ^ true ] ].
	^ false