Extension { #name : 'Array' }

{ #category : '*ViennaTalk-Value-Core' }
Array >> applyTo: anArray [
	^ self error: 'Array can not be applied'
]

{ #category : '*ViennaTalk-Value-Core' }
Array >> isSequence [
	^ false
]

{ #category : '*ViennaTalk-Value-Core' }
Array >> power [
	| power |
	power := self species new: 1 << self size.
	0 to: (1 << self size) - 1 do: [ :index | 
		| i member |
		i := 0.
		1 to: self size do: [ :bit | 
			(index bitAt: bit) = 0
				ifTrue: [ i := i + 1 ] ].
		member := self species new: i.
		i := 0.
		1 to: self size do: [ :bit | 
			(index bitAt: bit) = 0
				ifTrue: [ member at: (i := i + 1) put: (self at: bit) ] ].
		power at: index + 1 put: member ].
	^ power
]

{ #category : '*ViennaTalk-Value-Core' }
Array >> powerDo: aBlock [
	0 to: (1 << self size) - 1 do: [ :index | 
		| i member |
		i := 0.
		1 to: self size do: [ :bit | 
			(index bitAt: bit) = 0
				ifTrue: [ i := i + 1 ] ].
		member := self species new: i.
		i := 0.
		1 to: self size do: [ :bit | 
			(index bitAt: bit) = 0
				ifTrue: [ member at: (i := i + 1) put: (self at: bit) ] ].
		aBlock value: member ]
]

{ #category : '*ViennaTalk-Value-Core' }
Array >> viennaStringOn: aStream [
	aStream nextPutAll: 'mk_('.
	self do: [ :obj | obj viennaStringOn: aStream ] separatedBy: [ aStream nextPutAll: ', ' ].
	aStream nextPutAll: ')'
]
