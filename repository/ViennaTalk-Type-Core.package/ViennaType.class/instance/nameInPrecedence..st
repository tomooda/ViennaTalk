accessing
nameInPrecedence: anInteger
	^ self class precedence < anInteger
		ifTrue: [ '(' , self name , ')' ]
		ifFalse: [ self name ]