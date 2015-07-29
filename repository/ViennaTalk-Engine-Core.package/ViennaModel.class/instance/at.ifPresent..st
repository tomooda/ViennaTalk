accessing
at: aString ifPresent: errorBlock
	^ self at: aString ifPresent: errorBlock ifAbsent: [  ]