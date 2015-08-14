drawing
drawOn: aCanvas
	self showsName
		ifTrue: [ 
			aCanvas
				drawString: self name
				at: self position + self nameOffset
				font: self nameFont
				color: self nameColor ].
	self drawHighlightedOn: aCanvas