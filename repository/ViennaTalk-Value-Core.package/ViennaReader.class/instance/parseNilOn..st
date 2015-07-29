parsing
parseNilOn: aStream
	(aStream nextMatchAll: 'nil')
		ifFalse: [ ^ self error: 'expected nil' ].
	^ specials at: #nil ifAbsent: [ nil ]