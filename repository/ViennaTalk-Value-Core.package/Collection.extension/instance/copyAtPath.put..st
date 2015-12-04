*ViennaTalk-Value-Core
copyAtPath: anArrayOfKey put: anObject
	| copy |
	copy := self copy.
	anArrayOfKey size = 1
		ifTrue: [ copy at: anArrayOfKey first put: anObject ]
		ifFalse: [ (copy at: anArrayOfKey first) copyAtPath: anArrayOfKey tail put: anObject ].
	^ copy