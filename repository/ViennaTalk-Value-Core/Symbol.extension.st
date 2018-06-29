Extension { #name : #Symbol }

{ #category : #'*ViennaTalk-Value-Core' }
Symbol >> viennaStringOn: aStream [
	aStream nextPutAll: self
]
