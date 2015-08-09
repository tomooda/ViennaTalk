parsing
skipCommentOn: aStream
	(aStream nextMatchAll: '/*')
		ifFalse: [ ^ self error: 'expected /*' ].
	[ aStream atEnd ]
		whileFalse: [ 
			(aStream nextMatchAll: '*/')
				ifTrue: [ ^ self ].
			aStream next ].
	^ self error: 'unexpected EOF before */'