printing
viennaStringOn: aStream
	aStream
		nextPutAll: 'mk_';
		nextPutAll: constructorName;
		nextPutAll: '('.
	self do: [ :obj | obj viennaStringOn: aStream ] separatedBy: [ aStream nextPutAll: ', ' ].
	aStream nextPutAll: ')'