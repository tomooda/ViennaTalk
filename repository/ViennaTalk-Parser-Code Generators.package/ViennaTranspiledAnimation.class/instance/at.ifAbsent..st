accessing
at: aString ifAbsent: aBlock
	^ self at: aString ifPresent: [ :value | ] ifAbsent: aBlock