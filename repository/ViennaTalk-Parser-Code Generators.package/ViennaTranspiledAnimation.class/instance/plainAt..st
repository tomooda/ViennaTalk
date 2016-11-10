accessing
plainAt: aString
	^ self plainAt: aString ifPresent: [ :value | value ] ifAbsent: [  ]