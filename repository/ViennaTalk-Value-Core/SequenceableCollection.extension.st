Extension { #name : #SequenceableCollection }

{ #category : #'*ViennaTalk-Value-Core' }
SequenceableCollection >> applyTo: anArray [
	^ anArray size = 1
		ifTrue: [ self at: anArray first ]
		ifFalse: [ self error: 'One argument is expected.' ]
]

{ #category : #'*ViennaTalk-Value-Core' }
SequenceableCollection >> isSequence [
	^ true
]

{ #category : #'*ViennaTalk-Value-Core' }
SequenceableCollection >> tail [
	^ self ifEmpty: [ SubscriptOutOfBounds signal ] ifNotEmpty: [ self copyFrom: 2 to: self size ]
]

{ #category : #'*ViennaTalk-Value-Core' }
SequenceableCollection >> viennaStringOn: aStream [
	(self allSatisfy: #isCharacter)
		ifTrue: [ (String withAll: self) viennaStringOn: aStream ].
	aStream nextPutAll: '['.
	self do: [ :obj | obj viennaStringOn: aStream ] separatedBy: [ aStream nextPutAll: ', ' ].
	aStream nextPutAll: ']'
]
