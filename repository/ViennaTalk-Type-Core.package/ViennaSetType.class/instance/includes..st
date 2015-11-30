testing
includes: anObject
	^ anObject isSet and: [ anObject allSatisfy: [ :value | basetype includes: value ] ]