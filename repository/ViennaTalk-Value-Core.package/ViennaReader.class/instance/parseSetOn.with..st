parsing
parseSetOn: aStream with: first
	| args |
	(aStream nextMatchAll: ',')
		ifFalse: [ ^ self error: 'expected ,' ].
	args := Array new writeStream.
	args nextPut: first.
	aStream skipSeparators.
	[ 
	args nextPut: (self parseOn: aStream).
	aStream skipSeparators.
	aStream peek = $, ] whileTrue: [ aStream next ].
	(aStream nextMatchFor: $})
		ifFalse: [ ^ self error: 'expected }' ].
	args := args contents.
	^ specials at: #set ifPresent: [ :block | block value: args ] ifAbsent: [ args asSet ]