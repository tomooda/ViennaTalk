interpreting
execValueOf: aString
	^ (self morphNamed: aString ifAbsent: [ self abort: 'Can not read an undefined variable: ' , aString ]) value