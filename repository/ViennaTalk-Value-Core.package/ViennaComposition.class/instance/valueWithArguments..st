accessing
valueWithArguments: anArray
	| t |
	t := arg2 isCollection
		ifTrue: [ arg2 at: anArray first ]
		ifFalse: [ arg2 valueWithArguments: anArray ].
	t isArray
		ifFalse: [ t := Array with: t ].
	^ arg1 isCollection
		ifTrue: [ arg1 at: t first ]
		ifFalse: [ arg1 valueWithArguments: t ]