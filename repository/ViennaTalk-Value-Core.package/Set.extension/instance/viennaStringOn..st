*ViennaTalk-Value-Core
viennaStringOn: aStream
	aStream nextPutAll: '{'.
	self do: [ :obj | obj viennaStringOn: aStream ] separatedBy: [ aStream nextPutAll: ', ' ].
	aStream nextPutAll: '}'