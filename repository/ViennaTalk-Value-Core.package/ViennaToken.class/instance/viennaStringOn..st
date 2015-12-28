printing
viennaStringOn: aStream
	aStream nextPutAll: 'mk_token('.
	value viennaStringOn: aStream.
	aStream nextPutAll: ')'