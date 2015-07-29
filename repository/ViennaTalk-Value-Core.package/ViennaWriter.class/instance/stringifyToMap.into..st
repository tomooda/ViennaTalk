stringifying
stringifyToMap: aDictionary into: aStream
	aStream nextPut: ${.
	aDictionary
		ifEmpty: [ aStream nextPutAll: '|->' ]
		ifNotEmpty: [ 
			aDictionary associations
				do: [ :assoc | 
					self stringify: assoc key into: aStream.
					aStream nextPutAll: '|->'.
					self stringify: assoc value into: aStream ]
				separatedBy: [ aStream nextPut: $, ] ].
	aStream nextPut: $}