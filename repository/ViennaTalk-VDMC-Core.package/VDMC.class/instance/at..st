accessing
at: aString
	^ self
		at: aString
		ifAbsent: [ KeyNotFound signalFor: aString in: self ]