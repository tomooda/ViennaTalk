initialize-release
buildTextPane
	textMorph := PluggableTextMorph
		on: self
		text: #contents
		accept: #acceptContents:
		readSelection: nil
		menu: #textPaneMenu:shifted:.
	textMorph
		acceptOnCR: true;
		acceptOnFocusChange: true;
		autoAccept: true;
		borderColor: Color black;
		borderWidth: 1;
		font: self textFont;
		showHScrollBarOnlyWhenNeeded: true;
		hideVScrollBarIndefinitely: false.
	self changeProportionalLayout.
	self addMorph: textMorph fullFrame: self layoutFrameForTextPane.
	^ textMorph