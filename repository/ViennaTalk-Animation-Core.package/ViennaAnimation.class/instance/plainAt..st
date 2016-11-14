accessing-plain
plainAt: aString
	^ self
		plainAt: aString
		ifAbsent: [ KeyNotFound signalFor: aString in: self ]