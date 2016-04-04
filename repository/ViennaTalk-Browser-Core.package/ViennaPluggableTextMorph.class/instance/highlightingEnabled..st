accessing
highlightingEnabled: aBoolean
	aBoolean = true
		ifTrue: [ 
			highlighter := ViennaVDMHighlighter new.
			self startStepping ]
		ifFalse: [ highlighter := nil ]