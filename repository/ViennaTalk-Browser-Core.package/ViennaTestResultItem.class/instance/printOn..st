printing
printOn: aStream
	aStream space.
	module
		ifNotNil: [ aStream
				nextPutAll: module;
				nextPut: $` ].
	operation
		ifNotNil: [ aStream
				nextPutAll: operation;
				nextPutAll: '()' ].
	aStream nextPutAll: ' -> '.
	message ifNotNil: [ aStream nextPutAll: message ]