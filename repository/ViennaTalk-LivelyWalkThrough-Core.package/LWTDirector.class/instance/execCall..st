interpreting
execCall: aString
	^ self dispatchActionAt: aString asSymbol ifAbsent: [ self abort: 'Can not read an undefined variable: ' , aString ]