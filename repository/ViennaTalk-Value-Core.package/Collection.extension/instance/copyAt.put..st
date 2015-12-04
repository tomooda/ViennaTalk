*ViennaTalk-Value-Core
copyAt: anInteger put: anObject
	| copy |
	copy := self copy.
	copy at: anInteger put: anObject.
	^ copy