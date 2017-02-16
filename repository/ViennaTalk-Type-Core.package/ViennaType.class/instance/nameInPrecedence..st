accessing
nameInPrecedence: anInteger
	^ self precedence < anInteger
		ifTrue: [ '(' , self shortName , ')' ]
		ifFalse: [ self shortName ]