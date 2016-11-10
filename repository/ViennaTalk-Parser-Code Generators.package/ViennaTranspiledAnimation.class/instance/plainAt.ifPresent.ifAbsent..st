accessing
plainAt: aString ifPresent: presentBlock ifAbsent: absentBlock
	^ self
		at: aString
		ifPresent: [ :value | presentBlock value: (writer stringify: value) ]
		ifAbsent: absentBlock