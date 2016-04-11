initialize-release
initialize
	super initialize.
	wantsHighlighting := false.
	self highlightingEnabled: self class defaultHighlightingEnabled 