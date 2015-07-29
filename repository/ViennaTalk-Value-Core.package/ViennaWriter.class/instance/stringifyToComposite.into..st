stringifying
stringifyToComposite: anObject into: aStream
	aStream nextPutAll: 'mk_'.
	aStream nextPutAll: anObject class name.
	aStream nextPut: $(.
	(1 to: anObject class instSize)
		do: [ :index | self stringify: (anObject instVarAt: index) into: aStream ]
		separatedBy: [ aStream nextPut: $, ].
	aStream nextPut: $)