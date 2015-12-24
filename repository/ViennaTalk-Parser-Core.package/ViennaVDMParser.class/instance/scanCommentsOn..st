parsing
scanCommentsOn: aStream
	| sourceStream source |
	sourceStream := aStream asPetitStream.
	source := sourceStream contents.
	^ Array
		new: 16
		streamContents: [ :comments | 
			(self textLiteral / self characterLiteral
				/
					(comment
						>=> [ :commentStream :continuation | 
							| commentString position |
							position := commentStream position.
							commentString := continuation value.
							commentString isPetitFailure
								ifTrue: [ commentString ]
								ifFalse: [ 
									| guard |
									[ position > 0 and: [ (source at: position) isSeparator ] ] whileTrue: [ position := position - 1 ].
									guard := position > 0
										ifTrue: [ 
											| char |
											char := source at: position.
											char -> ((source copyFrom: 1 to: position) occurrencesOf: char) ].
									comments nextPut: guard -> commentString ] ]) / #any asParser) star end parse: sourceStream ]