user interface
buildCodePane
	^ (ViennaPluggableTextMorph
		on: self
		text: #code
		accept: #acceptCode:
		readSelection: #codeSelection
		menu: #codePaneMenu:shifted:
		setSelection: #codeSelection:)
		setBalloonText: 'VDM specification';
		askBeforeDiscardingEdits: true;
		yourself