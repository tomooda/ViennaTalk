parsing
parseCharOn: aStream
	| char |
	(aStream nextMatchAll: '''')
		ifFalse: [ ^ self error: 'expected ''' ].
	char := self readCharOn: aStream.
	(aStream nextMatchAll: '''')
		ifFalse: [ ^ self error: 'expected ''' ].
	^ specials at: #char ifPresent: [ :block | block value: char ] ifAbsent: [ char ]