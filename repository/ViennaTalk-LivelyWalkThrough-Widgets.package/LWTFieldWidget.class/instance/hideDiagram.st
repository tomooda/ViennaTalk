operations
hideDiagram
	showsDiagram := false.
	textMorph ifNotNil: [ textMorph layoutFrame: self layoutFrameForTextPane ].
	self changed