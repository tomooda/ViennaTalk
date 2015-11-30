instance creation
applyTo: anArray
	^ anArray size = 1
		ifTrue: [ self value: anArray first ]
		ifFalse: [ self error: 'token accepts only one argument.' ]