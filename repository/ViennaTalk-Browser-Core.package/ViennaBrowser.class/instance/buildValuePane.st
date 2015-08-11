user interface
buildValuePane
	^ (ViennaPluggableTextMorph
		on: self
		text: #value
		accept: #acceptValue:
		readSelection: #valueSelection
		menu: #valuePaneMenu:shifted:
		setSelection: #valueSelection:)
		askBeforeDiscardingEdits: false;
		alwaysAccept: true;
		yourself