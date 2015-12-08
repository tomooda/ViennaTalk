*ViennaTalk-Value-Core
viennaStringOn: aStream
	aStream nextPutAll: 'mk_('.
	self do: [ :obj | obj viennaStringOn: aStream ] separatedBy: [ aStream nextPutAll: ', ' ].
	aStream nextPutAll: ')'