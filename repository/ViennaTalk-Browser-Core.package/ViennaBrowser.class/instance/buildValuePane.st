user interface
buildValuePane
	^ (PluggableTextMorph
		on: self
		text: #value
		accept: #acceptValue:
		readSelection: #valueSelection
		menu: #valuePaneMenu:shifted:
		setSelection: #valueSelection:)
		askBeforeDiscardingEdits: true;
		yourself