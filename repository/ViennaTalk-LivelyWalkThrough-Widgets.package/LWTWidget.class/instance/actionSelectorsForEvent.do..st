events
actionSelectorsForEvent: aSymbol do: aBlock
	self eventActionDict in: [ :actionDict | (actionDict at: aSymbol ifAbsent: [ #() ]) do: aBlock ]