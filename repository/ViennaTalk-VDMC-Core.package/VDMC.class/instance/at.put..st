accessing
at: aString put: anObject
	^ state at: aString put: (writer stringify: anObject)