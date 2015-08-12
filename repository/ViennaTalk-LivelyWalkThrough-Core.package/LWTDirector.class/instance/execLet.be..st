interpreting
execLet: aString be: anObject
	(self morphNamed: aString ifAbsent: [ self abort: 'Can not assign to an undefined variable: ' , aString ])
		value: anObject.
	^ anObject