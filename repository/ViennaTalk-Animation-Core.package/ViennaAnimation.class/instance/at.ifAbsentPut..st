accessing
at: aString ifAbsentPut: errorBlock
	^ self
		at: aString
		ifPresent: [ :value | value ]
		ifAbsent: [ state at: aString put: (writer stringify: errorBlock value) ]