printing
viennaStringOn: aStream
	aStream
		nextPutAll: 'mk_';
		nextPutAll: constructorName;
		nextPutAll: '('.
	(1 to: self size) do: [ :index | (self at: index) viennaStringOn: aStream ] separatedBy: [ aStream nextPutAll: ', ' ].
	aStream nextPutAll: ')'