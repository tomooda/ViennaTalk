parsing
parseMapOn: aStream with: first
	| args |
	(aStream nextMatchAll: '|->')
		ifFalse: [ ^ self error: 'expected |->' ].
	aStream skipSeparators.
	args := Array new writeStream.
	args nextPut: first -> (self parseOn: aStream).
	[ 
	aStream skipSeparators.
	aStream peek = $, ]
		whileTrue: [ 
			| key value |
			aStream next.
			key := self parseOn: aStream.
			aStream skipSeparators.
			(aStream nextMatchAll: '|->')
				ifFalse: [ ^ self error: 'expected |->' ].
			value := self parseOn: aStream.
			args nextPut: key -> value ].
	(aStream nextMatchFor: $})
		ifFalse: [ ^ self error: 'expected }' ].
	args := args contents.
	^ specials at: #set ifPresent: [ :block | block value: args ] ifAbsent: [ args asDictionary ]