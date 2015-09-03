initialize-release
buildTextPane
	textMorph := PluggableTextMorph
		on: self
		text: #basicContents
		accept: #acceptContents:
		readSelection: nil
		menu: #textPaneMenu:shifted:.
	textMorph
		acceptOnCR: true;
		acceptOnFocusChange: true;
		borderColor: Color black;
		borderWidth: 1;
		font: self textFont;
		showHScrollBarOnlyWhenNeeded: true;
		hideVScrollBarIndefinitely: false;
		disable.
	self changeProportionalLayout.
	self addMorph: textMorph fullFrame: self layoutFrameForTextPane.
	^ textMorph