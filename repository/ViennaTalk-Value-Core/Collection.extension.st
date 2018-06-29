Extension { #name : #Collection }

{ #category : #'*ViennaTalk-Value-Core' }
Collection >> copyAt: anInteger put: anObject [
	| copy |
	copy := self copy.
	copy at: anInteger put: anObject.
	^ copy
]

{ #category : #'*ViennaTalk-Value-Core' }
Collection >> copyAtPath: anArrayOfKey put: anObject [
	| copy |
	copy := self copy.
	anArrayOfKey size = 1
		ifTrue: [ copy at: anArrayOfKey first put: anObject ]
		ifFalse: [ (copy at: anArrayOfKey first) copyAtPath: anArrayOfKey tail put: anObject ].
	^ copy
]

{ #category : #'*ViennaTalk-Value-Core' }
Collection >> onlyOneSatisfy: aBlock [
	"Evaluate aBlock with the elements of the receiver.
	If aBlock returns true for the only one element return true.
	Otherwise return false."

	| found |
	found := false.
	self
		do: [ :each | 
			(aBlock value: each)
				ifTrue: [ 
					found
						ifTrue: [ ^ false ].
					found := true ] ].
	^ found
]

{ #category : #'*ViennaTalk-Value-Core' }
Collection >> power [
	| power powerSet |
	power := self asArray power.
	powerSet := self species new: power size * 3 // 2.
	powerSet addAll: power.
	^ powerSet
]

{ #category : #'*ViennaTalk-Value-Core' }
Collection >> powerDo: aBlock [
	self asArray powerDo: aBlock
]
