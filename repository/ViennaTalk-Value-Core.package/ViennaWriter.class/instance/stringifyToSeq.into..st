stringifying
stringifyToSeq: anOrderedCollection into: aStream
	aStream nextPut: $[.
	anOrderedCollection do: [ :obj | self stringify: obj into: aStream ] separatedBy: [ aStream nextPut: $, ].
	aStream nextPut: $]