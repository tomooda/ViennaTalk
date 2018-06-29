Extension { #name : #Character }

{ #category : #'*ViennaTalk-Value-Core' }
Character >> viennaStringOn: aStream [
	aStream nextPut: $'.
	self = Character cr
		ifTrue: [ aStream nextPutAll: '\r' ]
		ifFalse: [ self = Character lf
				ifTrue: [ aStream nextPutAll: '\n' ]
				ifFalse: [ self = $\
						ifTrue: [ aStream nextPutAll: '\\' ]
						ifFalse: [ (self = $" or: [ self = $' ])
								ifTrue: [ aStream nextPut: $\ ].
							aStream nextPut: self ] ] ].
	aStream nextPut: $'
]
