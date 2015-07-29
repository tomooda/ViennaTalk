private
writeChar: aCharacter into: aStream
	aCharacter codePoint
		in: [ :code | 
			code = 8
				ifTrue: [ ^ aStream nextPutAll: '\b' ].
			code = 9
				ifTrue: [ ^ aStream nextPutAll: '\t' ].
			code = 10
				ifTrue: [ ^ aStream nextPutAll: '\r' ].
			code = 12
				ifTrue: [ ^ aStream nextPutAll: '\f' ].
			code = 13
				ifTrue: [ ^ aStream nextPutAll: '\n' ].
			code = 34
				ifTrue: [ ^ aStream nextPutAll: '\"' ].
			code = 39
				ifTrue: [ ^ aStream nextPutAll: '\''' ].
			code = 92
				ifTrue: [ ^ aStream nextPutAll: '\\' ].
			code < 32
				ifTrue: [ 
					aStream nextPutAll: '\x'.
					^ code printOn: aStream base: 16 nDigits: 2 ].
			code > 126
				ifTrue: [ 
					aStream nextPutAll: '\u'.
					^ code printOn: aStream base: 16 nDigits: 4 ] ].
	aStream nextPut: aCharacter