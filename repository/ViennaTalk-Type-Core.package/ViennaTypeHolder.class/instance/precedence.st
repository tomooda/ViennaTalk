accessing
precedence
	^ type ifNil: [ 0 ] ifNotNil: [ type precedence ]