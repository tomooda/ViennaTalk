stringifying
stringifyToString: aString into: aStream
	aStream nextPut: $".
	aString do: [ :char | self writeChar: char into: aStream ].
	aStream nextPut: $"