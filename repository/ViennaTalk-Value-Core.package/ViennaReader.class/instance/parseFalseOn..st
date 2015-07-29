parsing
parseFalseOn: aStream
	(aStream nextMatchAll: 'false')
		ifFalse: [ ^ self error: 'expected false' ].
	^ specials at: #false ifAbsent: [ false ]