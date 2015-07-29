parsing
parseTrueOn: aStream
	(aStream nextMatchAll: 'true')
		ifFalse: [ ^ self error: 'expected true' ].
	^ specials at: #true ifAbsent: [ true ]