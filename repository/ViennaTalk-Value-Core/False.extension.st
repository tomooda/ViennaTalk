Extension { #name : #False }

{ #category : #'*ViennaTalk-Value-Core' }
False >> vdmcStringOn: aStream [
	aStream nextPutAll: 'false'
]
