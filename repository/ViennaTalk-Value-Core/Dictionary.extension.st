Extension { #name : 'Dictionary' }

{ #category : '*ViennaTalk-Value-Core' }
Dictionary >> ** anInteger [
	| dict |
	dict := Dictionary new.
	self
		keysDo: [ :key | 
			| value |
			value := key.
			anInteger timesRepeat: [ value := self at: value ].
			dict at: key put: value ].
	^ dict
]

{ #category : '*ViennaTalk-Value-Core' }
Dictionary >> applyTo: anArray [
	^ anArray size = 1
		ifTrue: [ self at: anArray first ]
		ifFalse: [ self error: 'One argument is expected.' ]
]

{ #category : '*ViennaTalk-Value-Core' }
Dictionary >> comp: applicative [
	^ ViennaComposition with: self with: applicative
]

{ #category : '*ViennaTalk-Value-Core' }
Dictionary >> inversed [
	| dict |
	dict := Dictionary new.
	self keysAndValuesDo: [ :key :value | dict at: value put: key ].
	^ dict
]

{ #category : '*ViennaTalk-Value-Core' }
Dictionary >> value: anObject [
	^ self at: anObject
]

{ #category : '*ViennaTalk-Value-Core' }
Dictionary >> viennaStringOn: aStream [
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
]
