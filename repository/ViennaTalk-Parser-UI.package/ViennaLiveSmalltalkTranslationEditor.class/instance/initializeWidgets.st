initialize-release
initializeWidgets
	super initializeWidgets.
	targetText help: 'Smalltalk code'.
	codeText := self newText.
	codeText
		help: 'VDM expression/statement/type to evaluate';
		autoAccept: true;
		isCodeCompletionAllowed: false;
		wantsVisualFeedback: true;
		menuHolder: [ self codeTextMenu ];
		bindKeyCombination: $f shift command toAction: [ self formatSelectionInCodeText ];
		bindKeyCombination: $p command toAction: [ self viennaItInCodeText ];
		bindKeyCombination: $t command toAction: [ self translateIt ];
		whenBuiltDo: [ codeText widget font: ViennaLauncher font ]