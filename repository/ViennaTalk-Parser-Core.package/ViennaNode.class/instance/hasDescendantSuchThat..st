enumerating
hasDescendantSuchThat: aBlock
	self allDescendantsDo: [ :n | (aBlock value: n) ifTrue: [ ^true ] ].
	^ false