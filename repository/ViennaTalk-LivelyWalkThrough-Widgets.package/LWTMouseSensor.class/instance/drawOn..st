drawing
drawOn: aCanvas
	aCanvas
		frameAndFillRectangle: self bounds
		fillColor: self color
		borderWidth: self borderWidth
		borderColor: self borderColor.
	super drawOn: aCanvas