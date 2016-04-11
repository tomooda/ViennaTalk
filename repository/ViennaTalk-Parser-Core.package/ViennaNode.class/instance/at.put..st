accessing
at: anInteger put: anObject
	(anObject isKindOf: ViennaNode)
		ifTrue: [ anObject parent: self ].
	^ super at: anInteger put: anObject