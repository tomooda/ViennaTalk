private
strlen: aString
	^ aString
		inject: 0
		into: [ :len :char | 
			len
				+
					(char charCode < 256
						ifTrue: [ 1 ]
						ifFalse: [ 2 ]) ]