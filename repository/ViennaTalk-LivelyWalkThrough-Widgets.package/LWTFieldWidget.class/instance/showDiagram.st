operations
showDiagram
	showsDiagram := true.
	textMorph ifNotNil: [ textMorph layoutFrame: self layoutFrameForTextPane ].
	self changed