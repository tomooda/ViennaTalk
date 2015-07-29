parsing
parseSeqOn: aStream
	| args |
	(aStream nextMatchAll: '[')
		ifFalse: [ ^ self error: 'expected [' ].
	args := Array new writeStream.
	aStream skipSeparators.
	aStream peek = $]
		ifFalse: [ 
			[ 
			args nextPut: (self parseOn: aStream).
			aStream skipSeparators.
			aStream peek = $, ] whileTrue: [ aStream next ] ].
	(aStream nextMatchFor: $])
		ifFalse: [ ^ self error: 'expected ]' ].
	args := args contents.
	^ specials at: #seq ifPresent: [ :block | block valueWithArguments: args ] ifAbsent: [ args asOrderedCollection ]