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
		bindKeyCombination: $d command toAction: [ self doItIn: codePane ];
		bindKeyCombination: $p command toAction: [ self printItIn: codePane ];
		bindKeyCombination: $f shift command toAction: [ codePane prettyPrint ];
		bindKeyCombination: $t command toAction: [ codePane template ];
		font: ViennaLauncher font;
		highlightingEnabled: true;
		yourself