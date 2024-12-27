Extension { #name : 'Collection' }

{ #category : '*ViennaTalk-Value-Core' }
Collection >> copyAt: anInteger put: anObject [
	| copy |
	copy := self copy.
	copy at: anInteger put: anObject.
	^ copy
]

{ #category : '*ViennaTalk-Value-Core' }
Collection >> copyAtPath: anArrayOfKey put: anObject [
	| copy |
	copy := self copy.
	anArrayOfKey size = 1
		ifTrue: [ copy at: anArrayOfKey first put: anObject ]
		ifFalse: [ copy at: anArrayOfKey first put: ((copy at: anArrayOfKey first) copyAtPath: anArrayOfKey tail put: anObject) ].
	^ copy
]

{ #category : '*ViennaTalk-Value-Core' }
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

{ #category : '*ViennaTalk-Value-Core' }
Collection >> power [
	| array size power |
	array := self asArray.
	size := array size.
	power := self species new: 1 << size.
	0 to: (1 << size) - 1 do: [ :index | 
		| member |
		member := self species new: size.
		1 to: array size do: [ :bit | 
			(index bitAt: bit) = 0
				ifTrue: [ member add: (array at: bit) ] ].
		power add: member ].
	^ power
]

{ #category : '*ViennaTalk-Value-Core' }
Collection >> powerDo: aBlock [
	self asArray powerDo: aBlock
]
