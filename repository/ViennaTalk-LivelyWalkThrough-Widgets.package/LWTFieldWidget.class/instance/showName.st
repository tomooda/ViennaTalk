operations
showName
	showsName := true.
	textMorph ifNotNil: [ textMorph layoutFrame: self layoutFrameForTextPane ].
	self changed