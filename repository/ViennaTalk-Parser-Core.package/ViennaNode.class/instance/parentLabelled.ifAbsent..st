accessing
parentLabelled: aString ifAbsent: errorBlock
	self
		ぱparentsDo: [ :node | 
			node label = aString
				ifTrue: [ ^ node ] ].
	^ errorBlock value