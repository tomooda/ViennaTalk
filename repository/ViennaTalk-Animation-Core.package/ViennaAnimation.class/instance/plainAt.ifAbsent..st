accessing-plain
plainAt: aString ifAbsent: errorBlock
	^ self plainAt: aString ifPresent: [ :value | value ] ifAbsent: errorBlock