testing
includes: anObject
	^ (basetype includes: anObject) and: [ invariant value: anObject ]