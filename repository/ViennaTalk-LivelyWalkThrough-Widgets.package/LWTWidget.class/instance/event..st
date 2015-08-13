events
event: aSymbol
	self director ifNotNil: [ :director | director dispatchEvent: aSymbol at: self name ]