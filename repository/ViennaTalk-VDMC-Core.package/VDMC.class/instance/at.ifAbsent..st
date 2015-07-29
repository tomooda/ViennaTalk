accessing
at: aString ifAbsent: errorBlock
	^ self at: aString ifPresent: [ :value | value ] ifAbsent: errorBlock