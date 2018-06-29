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
	self printOn: aStream
]
