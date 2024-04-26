Extension { #name : #Base64MimeConverter }

{ #category : #'*ViennaTalk-LivelyWalkThrough-Core' }
Base64MimeConverter class >> mimeDecodeToBytes: aStream [

	| decoder byteStream |
	decoder := self new.
	decoder mimeStream: aStream.
	byteStream := ByteArray new writeStream.
	decoder dataStream: byteStream.
	decoder mimeDecodeToByteArray.
	^ byteStream contents
]
