accessing
contents
	| newContents |
	newContents := [ (ZnEasy get: self url asUrl) entity contents ]
		on: Error
		do: [ :ex | ^ super contents ].
	super acceptContents: newContents.
	self changed: #basicContents.
	^ self contentsToValue: newContents