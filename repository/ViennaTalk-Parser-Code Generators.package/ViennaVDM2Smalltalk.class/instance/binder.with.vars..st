utilities
binder: aBlockString with: aString vars: anArrayOfString
	^ String
		new: 256
		streamContents: [ :stream | 
			stream
				nextPutAll: '((';
				nextPutAll: aBlockString;
				nextPutAll: ' value: ';
				nextPutAll: aString;
				nextPutAll: ') ifEmpty: [false] ifNotEmpty: [:binds | ';
				nextPutAll:
						('.'
								join:
									(anArrayOfString select: #notNil thenCollect: [ :varName | varName , ' := binds first at: ' , varName storeString ]));
				nextPutAll: '. true])' ]