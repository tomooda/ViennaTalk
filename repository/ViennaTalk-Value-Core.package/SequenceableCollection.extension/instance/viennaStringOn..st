*ViennaTalk-Value-Core
viennaStringOn: aStream
	(self allSatisfy: #isCharacter)
		ifTrue: [ (String withAll: self) viennaStringOn: aStream ].
	aStream nextPutAll: '['.
	self do: [ :obj | obj viennaStringOn: aStream ] separatedBy: [ aStream nextPutAll: ', ' ].
	aStream nextPutAll: ']'