translating
accept: anObject
	^ anObject = object
		ifTrue: [ Dictionary new ]
		ifFalse: [ nil ]