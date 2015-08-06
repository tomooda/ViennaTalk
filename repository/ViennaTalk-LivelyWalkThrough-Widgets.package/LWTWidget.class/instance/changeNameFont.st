operations
changeNameFont
	self
		openModal:
			(FontChooser
				openWithWindowTitle: 'Choose a font for the name'
				for: self
				setSelector: #nameFont:
				getSelector: #nameFont)