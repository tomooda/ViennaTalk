accessing
at: anIntegerOrString put: anObject
	^ super
		at:
			(anIntegerOrString isString
				ifTrue: [ namedFields at: anIntegerOrString ]
				ifFalse: [ anIntegerOrString ])
		put: anObject