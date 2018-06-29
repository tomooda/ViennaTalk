Extension { #name : #UndefinedObject }

{ #category : #'*ViennaTalk-Value-Core' }
UndefinedObject >> vdmcStringOn: aStream [
	aStream nextPutAll: 'nil'
]
