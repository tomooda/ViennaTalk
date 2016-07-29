testing
basicIncludes: anObject
	^ (basetype includes: anObject) and: [ invariant value: anObject ]