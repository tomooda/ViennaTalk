user interface
buildCodePane
	^ (ViennaPluggableTextMorph
		on: self
		text: #code
		accept: #acceptCode:
		readSelection: #codeSelection
		menu: #codePaneMenu:shifted:
		setSelection: #codeSelection:)
		askBeforeDiscardingEdits: true;
		bindKeyCombination: $d command toAction: [  ];
		bindKeyCombination: $p command toAction: [  ];
		font: ViennaLauncher font;
		yourself