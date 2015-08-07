event handling
handlesMouseDown: anEvent
	"anEvent yellowButtonPressed
		ifTrue: [ ^ true ].
	(self edgeName: anEvent position) ifNotEmpty: [ :edge | ^ true ].
	^ super handlesMouseDown: anEvent"
	^true