operations
hideName
	super hideName.
	textMorph ifNotNil: [ textMorph layoutFrame: self layoutFrameForTextPane ]