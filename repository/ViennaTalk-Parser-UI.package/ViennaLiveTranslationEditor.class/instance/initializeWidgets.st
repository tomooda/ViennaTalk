initialize-release
initializeWidgets
	sourceText := self newText.
	sourceText autoAccept: true.
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
				do: [ :ex |  ] ].
	targetText := self newText.
	self title: self defaultTitle