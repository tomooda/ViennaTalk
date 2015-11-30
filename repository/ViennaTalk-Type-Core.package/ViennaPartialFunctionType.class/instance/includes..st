testing
includes: anObject
	^ anObject isFunction and: [ argtypes size = anObject numArgs ]