interpreting
execLet: aString be: anObject
	| name |
	name := thisContext sender name.
	(self
		morphNamed: aString
		ifAbsent: [ self error: 'Can not assign to an undefined variable: ' , aString actionName: name ]) value: anObject.
	^ anObject