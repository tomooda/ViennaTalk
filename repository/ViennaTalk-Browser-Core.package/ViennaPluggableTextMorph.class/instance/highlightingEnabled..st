accessing
highlightingEnabled: aBoolean
	aBoolean = true
		ifTrue: [ 
			highlighter := ViennaVDMHighlighter new.
			self startStepping.
			self wantsHighlighting: true ]
		ifFalse: [ highlighter := nil.
			[self text runs: self text asString asText runs ] on: Error do: [:ex |]]