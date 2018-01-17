printing
printOn: aStream
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