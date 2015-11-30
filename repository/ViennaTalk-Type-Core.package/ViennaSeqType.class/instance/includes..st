testing
includes: anObject
	^ anObject isSequence and: [ anObject allSatisfy: [ :value | basetype includes: value ] ]