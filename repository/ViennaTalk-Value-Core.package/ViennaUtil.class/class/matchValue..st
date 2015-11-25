pattern matching
matchValue: anObject
	^ [ :value | 
	anObject = value
		ifTrue: [ Array with: Dictionary new ]
		ifFalse: [ Array new ] ]