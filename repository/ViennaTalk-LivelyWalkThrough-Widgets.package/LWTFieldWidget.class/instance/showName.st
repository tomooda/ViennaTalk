operations
showName
	super showName.
	textMorph ifNotNil: [ textMorph layoutFrame: self layoutFrameForTextPane ]