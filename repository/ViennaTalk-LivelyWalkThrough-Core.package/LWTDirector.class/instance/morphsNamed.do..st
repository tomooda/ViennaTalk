accessing-morphs
morphsNamed: aString do: aBlock
	self
		allMorphsDo: [ :submorph | 
			submorph name = aString
				ifTrue: [ aBlock value: submorph ] ]