accessing
at: aString ifPresent: aBlock ifAbsent: errorBlock
	^ state at: aString ifPresent: [ :value | aBlock cull: (reader parseOn: value readStream) ] ifAbsent: errorBlock