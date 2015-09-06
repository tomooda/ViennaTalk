printing
printOn: aStream 
	timestamp printOn: aStream.
	aStream nextPutAll: ' : State : {'.
	states keys asSortedCollection
		do: [:module | 
			aStream nextPutAll: module;
				 nextPutAll: ': {'.
			states associations do: [:bind|
				aStream nextPutAll: bind key;
						 nextPut: $:;
						 nextPutAll: bind value]
				separatedBy: [aStream nextPut: $,].
			aStream nextPutAll: '}']
		separatedBy: [aStream nextPutAll: ', '].
	aStream nextPutAll: '}'