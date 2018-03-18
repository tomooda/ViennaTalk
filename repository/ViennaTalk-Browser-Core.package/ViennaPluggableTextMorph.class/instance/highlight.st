stepping and presenter
highlight
	| source |
	highlighter ifNil: [ ^ self stopStepping ].
	highlighterProcess
		ifNotNil: [ highlighterProcess terminate.
			highlighterProcess := nil ].
	source := self text asString copy.
	highlighterProcess := [ wantsHighlighting := false.
	highlighter text: source asText.
	highlighter parse: source.
	self text size = highlighter text runs size ifTrue: [self text runs: highlighter text runs].
	highlighterProcess := nil.
	self changed ] forkAt: Processor userBackgroundPriority