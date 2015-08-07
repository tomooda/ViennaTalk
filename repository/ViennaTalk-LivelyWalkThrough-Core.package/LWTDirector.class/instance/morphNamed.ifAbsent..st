accessing-morphs
morphNamed: aString ifAbsent: errorBlock
	self morphsNamed: aString do: [ :morph | ^morph ].
	^ errorBlock value