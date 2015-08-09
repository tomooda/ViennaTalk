private
modulePositionsFrom: aString
	| reader stream modulesAndPositions |
	reader := ViennaReader new.
	stream := aString readStream.
	modulesAndPositions := Array new writeStream.
	[ stream atEnd ]
		whileFalse: [ 
			stream peek
				in: [ :char | 
					char isSeparator
						ifTrue: [ 
							stream next.
							stream position
								in: [ :position | 
									((stream nextMatchAll: 'module') and: [ stream next isSeparator ])
										ifTrue: [ 
											(String
												new: 1
												streamContents: [ :nameStream | 
													[ stream atEnd or: [ stream peek isSeparator or: [ '-/' includes: stream peek ] ] ]
														whileFalse: [ nameStream nextPut: stream next ] ])
												in: [ :name | modulesAndPositions nextPut: name -> position ] ] ] ].
					char = $'
						ifTrue: [ reader parseCharOn: stream ].
					char = $"
						ifTrue: [ reader parseStringOn: stream ].
					(stream nextMatchAll: '/*')
						ifTrue: [ 
							stream skip: -2.
							reader skipCommentOn: stream ].
					(stream nextMatchAll: '--')
						ifTrue: [ 
							stream skip: -2.
							reader skipCommentOn: stream ] ] ].
	^ modulesAndPositions contents