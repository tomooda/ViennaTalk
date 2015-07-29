parsing
parseStringOn: aStream
	| string |
	(aStream nextMatchAll: '"')
		ifFalse: [ ^ self error: 'expected "' ].
	string := String
		streamContents: [ :stream | [ aStream peek = $" ] whileFalse: [ stream nextPut: (self readCharOn: aStream) ] ].
	(aStream nextMatchAll: '"')
		ifFalse: [ ^ self error: 'expected "' ].
	^ specials at: #'seq of char' ifPresent: [ :block | block value: string ] ifAbsent: [ string ]