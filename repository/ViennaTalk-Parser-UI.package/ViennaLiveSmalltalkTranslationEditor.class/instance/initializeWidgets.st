initialize-release
initializeWidgets
	super initializeWidgets.
	sourceText
		menuHolder: [ self sourceTextMenu ];
		bindKeyCombination: $p command toAction: [ self viennaItInSourceText ].
	targetText help: 'Smalltalk code'.
	codeText := self newText.
	codeText
		help: 'VDM expression/statement/type to evaluate';
		autoAccept: true;
		isCodeCompletionAllowed: false;
		wantsVisualFeedback: true;
		menuHolder: [ self codeTextMenu ];
		bindKeyCombination: $p command toAction: [ self viennaItInCodeText ];
		bindKeyCombination: $t command toAction: [ self translateIt ]