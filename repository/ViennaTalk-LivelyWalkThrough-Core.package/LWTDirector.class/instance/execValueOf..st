interpreting
execValueOf: aString
	| name |
	name := thisContext sender name.
	^ (self
		morphNamed: aString
		ifAbsent: [ self error: 'Can not read an undefined variable: ' , aString actionName: name ]) value