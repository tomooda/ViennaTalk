accessing-plain
plainAt: aString ifAbsentPut: errorBlock
	^ self plainAt: aString ifPresent: [ :value | value ] ifAbsent: [ state at: aString put: errorBlock value ]