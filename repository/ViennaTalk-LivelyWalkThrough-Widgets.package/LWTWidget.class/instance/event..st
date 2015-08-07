events
event: aSymbol
	self director
		ifNotNil: [ :director | 
			(eventActionDict includesKey: aSymbol)
				ifFalse: [ ^ self ].
			director recordEvent: aSymbol at: self.
			self actionSelectorsForEvent: aSymbol do: [ :selector | director dispatchActionAt: selector ] ]