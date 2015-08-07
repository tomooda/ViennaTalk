accessing-actions
dispatchActionAt: aSymbol ifAbsent: errorBlock
	^ (actions at: aSymbol asSymbol ifAbsent: [  ]) ifNotNilDo: [ :action | action value: self ] ifNil: errorBlock