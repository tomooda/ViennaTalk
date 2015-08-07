accessing-actions
actionAt: aSymbol ifAbsent: errorBlock
	^ actions at: aSymbol asSymbol ifAbsent: errorBlock