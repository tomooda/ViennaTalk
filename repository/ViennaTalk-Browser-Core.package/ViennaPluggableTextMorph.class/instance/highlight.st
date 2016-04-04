stepping and presenter
highlight
	| source |
	highlighter ifNil: [^ self stopStepping ].
	source := self text asString.
	wantsHighlighting := false.
	highlighter text: source asText.
	highlighter parse: source.
	self text runs: highlighter text runs