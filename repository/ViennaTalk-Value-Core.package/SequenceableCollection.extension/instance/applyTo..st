*ViennaTalk-Value-Core
applyTo: anArray
	^ anArray size = 1
		ifTrue: [ self at: anArray first ]
		ifFalse: [ self error: 'One argument is expected.' ]