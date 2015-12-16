initialize-release
initializeWidgets
	sourceText := self newText.
	sourceText
		help: 'VDM source';
		autoAccept: true;
		isCodeCompletionAllowed: false;
		menuHolder: [ self sourceTextMenu ];
		bindKeyCombination: $f shift command toAction: [ self formatSourceText ];
		bindKeyCombination: $p command toAction: [ self viennaItInSourceText ].
	sourceText
		whenTextChanged: [ :source | 
			[ 
			| failure |
			failure := nil.
			targetText
				accept:
					(self
						translate: source
						ifError: [ :error | 
							failure := error.
							'' ])
				notifying: nil.
			failure
				ifNotNil: [ sourceText text: (source addAttribute: TextColor red from: failure position + 1 to: source size) ] ]
				on: Error
				do: [ :ex | 
					Transcript
						cr;
						show: ex printString ] ].
	targetText := self newText.
	targetText help: 'Translation output'.
	self title: self defaultTitle