testing
includes: anObject
	^ anObject isSequence and: [ anObject notEmpty and: [ anObject allSatisfy: [ :value | basetype includes: value ] ] ]