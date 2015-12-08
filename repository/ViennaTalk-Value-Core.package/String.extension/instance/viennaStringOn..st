*ViennaTalk-Value-Core
viennaStringOn: aStream
	aStream nextPutAll: '"'.
	self
		do: [ :char | 
			char = Character cr
				ifTrue: [ aStream nextPutAll: '\n' ]
				ifFalse: [ 
					(char = $" or: [ char = $' ])
						ifTrue: [ aStream nextPut: $\ ].
					aStream nextPut: char ] ].
	aStream nextPutAll: '"'