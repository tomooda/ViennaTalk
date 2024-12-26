Extension { #name : 'Set' }

{ #category : '*ViennaTalk-Value-Core' }
Set >> isSet [
	^ true
]

{ #category : '*ViennaTalk-Value-Core' }
Set >> viennaStringOn: aStream [
	aStream nextPutAll: '{'.
	self do: [ :obj | obj viennaStringOn: aStream ] separatedBy: [ aStream nextPutAll: ', ' ].
	aStream nextPutAll: '}'
]
