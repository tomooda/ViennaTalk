printing
printOn: aStream 
	timestamp printOn: aStream.
	aStream nextPutAll: ' : State : {'.
	states keys asSortedCollection
		do: [:module | 
			aStream nextPutAll: module;
				 nextPutAll: ': {'.
			(states at: module)
				do: [:binding | aStream nextPutAll: binding key;
						 nextPut: $:;
						 nextPutAll: binding value]
				separatedBy: [aStream nextPut: $,].
			aStream nextPutAll: '}']
		separatedBy: [aStream nextPutAll: ', '].
	aStream nextPutAll: '}'