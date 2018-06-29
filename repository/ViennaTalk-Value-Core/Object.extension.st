Extension { #name : #Object }

{ #category : #'*ViennaTalk-Value-Core' }
Object >> isFunction [
	^ false
]

{ #category : #'*ViennaTalk-Value-Core' }
Object >> isSequence [
	^ false
]

{ #category : #'*ViennaTalk-Value-Core' }
Object >> isSet [
	^ false
]

{ #category : #'*ViennaTalk-Value-Core' }
Object >> isViennaComposite [
	^ false
]

{ #category : #'*ViennaTalk-Value-Core' }
Object >> viennaString [
	^ String new: 128 streamContents: [ :stream | self viennaStringOn: stream ]
]

{ #category : #'*ViennaTalk-Value-Core' }
Object >> viennaStringOn: aStream [
	aStream nextPutAll: 'mk_'.
	aStream nextPutAll: self class name.
	aStream nextPut: $(.
	(1 to: self class instSize)
		do: [ :index | self stringify: (self instVarAt: index) into: aStream ]
		separatedBy: [ aStream nextPut: $, ].
	aStream nextPut: $)
]
