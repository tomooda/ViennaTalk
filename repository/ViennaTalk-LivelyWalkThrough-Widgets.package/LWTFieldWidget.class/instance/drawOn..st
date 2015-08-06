drawing
drawOn: aCanvas
	aCanvas
		frameAndFillRectangle: self bounds
		fillColor: Color white
		borderWidth: 1
		borderColor: Color lightGray.
	aCanvas
		drawString: self name
		at: self position + self nameOffset
		font: self nameFont
		color: self nameColor