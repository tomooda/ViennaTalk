accessing
textFont: aFont
	textFont := aFont.
	textMorph ifNotNil: [ :m | m font: aFont ].
	self changed