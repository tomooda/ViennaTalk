parsing
skipLineCommentOn: aStream
	(aStream nextMatchAll: '--')
		ifFalse: [ ^ self error: 'expected --' ].
	[ aStream atEnd ]
		whileFalse: [ 
			('\n\r' includes: aStream next)
				ifTrue: [ ^ self ] ]