initialize-release
initializeWidgets
	sourceText := self newText.
	sourceText autoAccept: true.
	sourceText
		whenTextChanged: [ :source | targetText accept: (self translate: source ifError: [ :error | '' ]) notifying: nil ].
	targetText := self newText.
	self title: 'VDM->Smalltalk'