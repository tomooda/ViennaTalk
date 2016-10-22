enumerating
detect: aBlock ifNone: errorBlock
	self
		do: [ :value | 
			(aBlock value: value)
				ifTrue: [ ^ value ] ].
	^ errorBlock value