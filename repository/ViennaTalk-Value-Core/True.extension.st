Extension { #name : #True }

{ #category : #'*ViennaTalk-Value-Core' }
True >> vdmcStringOn: aStream [
	aStream nextPutAll: 'true'
]
