printing
printOn: aStream 
	timestamp printOn: aStream.
	aStream nextPutAll: ' : VDM : '.
	aStream nextPutAll: expression.
	aStream nextPutAll: '='.
	aStream nextPutAll: value