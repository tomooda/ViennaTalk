accessing
copyAt: anIntegerOrString put: anObject
	^ self copy
		at:
			(anIntegerOrString isString
				ifTrue: [ namedFields at: anIntegerOrString ]
				ifFalse: [ anIntegerOrString ])
		put: anObject