accessing-morphs
let: aString be: anObject ifAbsentDo: errorBlock
	^ self morphsNamed: aString ifNotEmpty: [ :morph | morph value: anObject ] ifEmpty: [ errorBlock value: anObject ]