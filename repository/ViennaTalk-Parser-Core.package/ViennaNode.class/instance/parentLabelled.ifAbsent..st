accessing
parentLabelled: aString ifAbsent: errorBlock
	self
		parentsDo: [ :node | 
			node label = aString
				ifTrue: [ ^ node ] ].
	^ errorBlock value