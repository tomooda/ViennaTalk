operations
hideName
	showsName := false.
	textMorph ifNotNil: [ textMorph layoutFrame: self layoutFrameForTextPane ].
	self changed