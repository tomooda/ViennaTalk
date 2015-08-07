accessing-morphs
valueOf: aString ifAbsent: errorBlock
	self morphsNamed: aString do: [ :morph | ^ morph value ].
	^ errorBlock value