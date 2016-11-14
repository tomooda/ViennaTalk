accessing
plainAt: aString ifAbsent: absentBlock
	^ self
		plainAt: aString
		ifPresent: [ :value | value ]
		ifAbsent: absentBlock