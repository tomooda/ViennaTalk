parsing
skipLineCommentOn: aStream
	| crlf |
	(aStream nextMatchAll: '--')
		ifFalse: [ ^ self error: 'expected --' ].
	crlf := String with: Character cr with: Character lf.
	[ aStream atEnd ]
		whileFalse: [ 
			(crlf includes: aStream next)
				ifTrue: [ ^ self ] ]