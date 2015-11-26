accessing
applyTo: anArray
	| t |
	t := arg2 applyTo: anArray.
	t isArray
		ifFalse: [ t := Array with: t ].
	^ arg1 applyTo: t