private
modulePositionsFrom: aString
	| reader stream modulesAndPositions ends |
	reader := ViennaReader new.
	stream := aString readStream.
	modulesAndPositions := Array new writeStream.
	((stream nextMatchAll: 'module') and: [ stream next isSeparator ])
		ifTrue: [ 
			(String
				new: 1
				streamContents: [ :nameStream | 
					[ stream atEnd or: [ stream peek isSeparator or: [ '-/' includes: stream peek ] ] ]
						whileFalse: [ nameStream nextPut: stream next ] ]) in: [ :name | modulesAndPositions nextPut: name -> 1 ] ].
	[ stream atEnd ]
		whileFalse: [ 
			stream next
				in: [ :char | 
					char isSeparator
						ifTrue: [ 
							stream position
								in: [ :position | 
									((stream nextMatchAll: 'module') and: [ stream next isSeparator ])
										ifTrue: [ 
											(String
												new: 1
												streamContents: [ :nameStream | 
													[ stream atEnd or: [ stream peek isSeparator or: [ '-/' includes: stream peek ] ] ]
														whileFalse: [ nameStream nextPut: stream next ] ])
												in: [ :name | modulesAndPositions nextPut: name -> (position + 1) ] ] ] ].
					char = $'
						ifTrue: [ 
							stream skip: -1.
							reader parseCharOn: stream ].
					char = $"
						ifTrue: [ 
							stream skip: -1.
							reader parseStringOn: stream ].
					(char = $/ and: [ stream nextMatchAll: '*' ])
						ifTrue: [ 
							stream skip: -2.
							reader skipCommentOn: stream ].
					(char = $- and: [ stream nextMatchAll: '-' ])
						ifTrue: [ 
							stream skip: -2.
							reader skipLineCommentOn: stream ] ] ].
	modulesAndPositions := modulesAndPositions contents.
	modulesAndPositions ifEmpty: [ ^ Array with: 'DEFAULT' -> (1 to: aString size) ].
	ends := ((2 to: modulesAndPositions size) collect: [ :index | (modulesAndPositions at: index) value - 1 ])
		copyWith: aString size.
	^ (1 to: modulesAndPositions size)
		collect: [ :index | (modulesAndPositions at: index) key -> ((modulesAndPositions at: index) value to: (ends at: index)) ]