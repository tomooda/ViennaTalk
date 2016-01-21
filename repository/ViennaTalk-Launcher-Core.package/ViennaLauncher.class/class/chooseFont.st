settings
chooseFont
	FreeTypeFontProvider current updateFromSystem.
	FontChooser
		openWithWindowTitle: 'Choose Font for VDM source...'
		for: self
		setSelector: #font:
		getSelector: #font