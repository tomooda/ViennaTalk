printing
printOn: aStream
	aStream
		nextPutAll: self class name;
		nextPutAll: '('.
	value printOn: aStream.
	aStream nextPutAll: ') '