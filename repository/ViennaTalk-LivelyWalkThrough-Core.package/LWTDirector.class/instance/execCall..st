interpreting
execCall: aString
	| name |
	name := thisContext sender name.
	^ self
		dispatchActionAt: aString asSymbol
		ifAbsent: [ self error: 'Can not read an undefined variable: ' , aString actionName: name ]