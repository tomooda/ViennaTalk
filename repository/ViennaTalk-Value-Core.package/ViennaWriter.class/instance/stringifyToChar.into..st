stringifying
stringifyToChar: aCharacter into: aStream
	aStream nextPut: $'.
	self writeChar: aCharacter into: aStream.
	aStream nextPut: $'