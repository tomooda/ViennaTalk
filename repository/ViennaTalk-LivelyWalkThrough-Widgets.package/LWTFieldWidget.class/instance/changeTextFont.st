operations
changeTextFont
	self
		openModal:
			(FontChooser
				openWithWindowTitle: 'Choose a font for the text'
				for: self
				setSelector: #textFont:
				getSelector: #textFont)