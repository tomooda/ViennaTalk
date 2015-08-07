printing
printOn: aStream
	timestamp printOn: aStream.
	aStream nextPutAll: ' : EVENT : ['.
	aStream nextPutAll: morphName.
	aStream nextPutAll: ']'.
	event printOn: aStream