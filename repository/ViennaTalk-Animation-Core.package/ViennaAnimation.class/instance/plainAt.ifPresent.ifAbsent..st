accessing-plain
plainAt: aString ifPresent: aBlock ifAbsent: errorBlock
	^ state at: aString ifPresent: [ :value | aBlock cull: value ] ifAbsent: errorBlock