testing
basicIncludes: anObject
	^ anObject isSequence and: [ anObject allSatisfy: [ :value | basetype includes: value ] ]