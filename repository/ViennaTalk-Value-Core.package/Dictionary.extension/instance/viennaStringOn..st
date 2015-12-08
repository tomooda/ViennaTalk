*ViennaTalk-Value-Core
viennaStringOn: aStream
	aStream nextPutAll: '{'.
	self isEmpty
		ifTrue: [ aStream nextPutAll: '|->' ]
		ifFalse: [ 
			self associations
				do: [ :assoc | 
					assoc key viennaStringOn: aStream.
					aStream nextPutAll: ' |-> '.
					assoc value viennaStringOn: aStream ]
				separatedBy: [ aStream nextPutAll: ', ' ] ].
	aStream nextPutAll: '}'