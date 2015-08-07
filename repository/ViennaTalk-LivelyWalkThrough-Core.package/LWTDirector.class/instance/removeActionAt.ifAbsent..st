accessing-actions
removeActionAt: aSymbol ifAbsent: errorBlock
	^ actions removeKey: aSymbol asSymbol ifAbsent: errorBlock