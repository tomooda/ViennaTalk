testing
basicIncludes: anObject
	^ anObject isFunction and: [ argtypes size = anObject numArgs ]