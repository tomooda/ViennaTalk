stringifying
stringifyToQuote: aSymbol into: aStream
	(aSymbol allSatisfy: #isLetter)
		ifFalse: [ ^ self error: 'Invalid character in a VDM quote ' ].
	aStream
		nextPut: $<;
		nextPutAll: aSymbol;
		nextPut: $>