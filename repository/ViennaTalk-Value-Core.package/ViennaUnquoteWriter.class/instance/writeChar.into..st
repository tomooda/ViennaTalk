private
writeChar: aCharacter into: aStream
	aCharacter codePoint
		in: [ :code | 
			code = 34
				ifTrue: [ ^ aStream nextPutAll: '\"' ].
			code = 39
				ifTrue: [ ^ aStream nextPutAll: '\''' ].
			code = 92
				ifTrue: [ ^ aStream nextPutAll: '\\' ] ].
	aStream nextPut: aCharacter