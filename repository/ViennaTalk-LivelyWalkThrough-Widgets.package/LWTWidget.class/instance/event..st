events
event: aSymbol
	(eventActionDict includesKey: aSymbol)
		ifFalse: [ ^ self ].
	LWTDirector current recordEvent: aSymbol at: self.
	self actionSelectorsForEvent: aSymbol do: [ :selector | LWTDirector dispatchActionAt: selector ]