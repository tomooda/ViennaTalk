accessing-morphs
morphsNamed: aString do: aBlock
	self
		allMorphsDo: [ :submorph | 
			((submorph isKindOf: LWTWidget) and: [ submorph name = aString ])
				ifTrue: [ aBlock value: submorph ] ]