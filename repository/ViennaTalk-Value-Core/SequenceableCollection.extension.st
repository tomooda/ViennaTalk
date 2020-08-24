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
SequenceableCollection >> subsequenceFrom: anInteger1 to: anInteger2 [
	^ self copyFrom: (1 max: anInteger1) to: (anInteger2 min: self size)
]

{ #category : #'*ViennaTalk-Value-Core' }
SequenceableCollection >> tail [
	^ self ifEmpty: [ SubscriptOutOfBounds signal ] ifNotEmpty: [ self copyFrom: 2 to: self size ]
]

{ #category : #'*ViennaTalk-Value-Core' }
SequenceableCollection >> value: anInteger [
	^ self at: anInteger
]

{ #category : #'*ViennaTalk-Value-Core' }
SequenceableCollection >> viennaStringOn: aStream [
	(self notEmpty and: [self allSatisfy: #isCharacter])
		ifTrue: [ (String withAll: self) viennaStringOn: aStream ]
		ifFalse: [ aStream nextPutAll: '['.
			self
				do: [ :obj | obj viennaStringOn: aStream ]
				separatedBy: [ aStream nextPutAll: ', ' ].
			aStream nextPutAll: ']' ]
]
