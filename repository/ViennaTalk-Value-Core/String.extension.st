Extension { #name : 'String' }

{ #category : '*ViennaTalk-Value-Core' }
String >> isSequence [
	^ true
]

{ #category : '*ViennaTalk-Value-Core' }
String >> viennaStringOn: aStream [
	aStream nextPutAll: '"'.
	self
		do: [ :char | 
			char = Character cr
				ifTrue: [ aStream nextPutAll: '\r' ]
				ifFalse: [ 
					char = Character lf
						ifTrue: [ aStream nextPutAll: '\n' ]
						ifFalse: [ 
							char = $\
								ifTrue: [ aStream nextPutAll: '\\' ]
								ifFalse: [ 
									(char = $" or: [ char = $' ])
										ifTrue: [ aStream nextPut: $\ ].
									aStream nextPut: char ] ] ] ].
	aStream nextPutAll: '"'
]
