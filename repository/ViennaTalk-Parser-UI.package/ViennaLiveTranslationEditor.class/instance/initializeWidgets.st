initialize-release
initializeWidgets
	sourceText := self newText.
	sourceText
		help: 'VDM source';
		autoAccept: true;
		isCodeCompletionAllowed: false;
		menuHolder: [ self sourceTextMenu ];
		bindKeyCombination: $f shift command toAction: [ self formatSourceText ];
		bindKeyCombination: $p command toAction: [ self viennaItInSourceText ];
		whenTextChanged: [ [self translate] forkAt: Processor userBackgroundPriority  ];
		whenBuiltDo: [ sourceText widget font: ViennaLauncher font ].
	targetText := self newText.
	targetText
		help: 'Translation output';
		whenBuiltDo: [ targetText widget font: ViennaLauncher font ].
	self title: self defaultTitle