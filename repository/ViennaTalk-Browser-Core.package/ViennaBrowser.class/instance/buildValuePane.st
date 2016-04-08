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
		bindKeyCombination: $d command toAction: [ self doItIn: valuePane ];
		bindKeyCombination: $p command toAction: [ self printItIn: valuePane ];
		font: ViennaLauncher font;
		yourself