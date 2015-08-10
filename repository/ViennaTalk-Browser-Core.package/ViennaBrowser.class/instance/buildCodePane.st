user interface
buildCodePane
	^ (PluggableTextMorph
		on: self
		text: #code
		accept: #acceptCode:
		readSelection: #codeSelection
		menu: #codePaneMenu:shifted:
		setSelection: #codeSelection:)
		askBeforeDiscardingEdits: true;
		yourself