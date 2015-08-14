events
event: aSymbol
	self director ifNotNil: [ :director | director execEvent: aSymbol at: self name ]