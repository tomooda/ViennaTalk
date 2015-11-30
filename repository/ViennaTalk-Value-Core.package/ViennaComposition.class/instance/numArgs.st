accessing
numArgs
	^ arg2 isFunction
		ifTrue: [ arg2 numArgs ]
		ifFalse: [ 1 ]