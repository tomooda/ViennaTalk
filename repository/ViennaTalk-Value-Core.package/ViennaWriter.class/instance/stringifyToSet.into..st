stringifying
stringifyToSet: aSet into: aStream
	aStream nextPut: ${.
	aSet do: [ :obj | self stringify: obj into: aStream ] separatedBy: [ aStream nextPut: $, ].
	aStream nextPut: $}