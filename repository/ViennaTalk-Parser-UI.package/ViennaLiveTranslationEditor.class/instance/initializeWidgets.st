initialize-release
initializeWidgets
	sourceText := self newText.
	sourceText autoAccept: true.
	sourceText
		whenTextChanged: [ :source | 
			process ifNotNil: [ process terminate ].
			process := [ 
			[ 
			targetText
				accept:
					(self
						translate: source
						ifError: [ :error | 
							[ sourceText text: (sourceText text in: [ :t | t addAttribute: TextColor red from: error position + 1 to: t size ]) ]
								fork.
							'' ])
				notifying: nil ]
				on: Error
				do: [ :ex |  ] ] forkAt: Processor userBackgroundPriority ].
	targetText := self newText.
	self title: self defaultTitle