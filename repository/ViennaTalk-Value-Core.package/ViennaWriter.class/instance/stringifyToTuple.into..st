stringifying
stringifyToTuple: anArray into: aStream
	anArray size < 2 ifTrue: [ ^ self error: 'A tuple must have more than one argument.' ].
	 aStream nextPutAll: 'mk_('.
	anArray do: [ :obj | self stringify: obj into: aStream ] separatedBy: [ aStream nextPut: $, ].
	aStream nextPut: $)