testing
includes: anObject
	^ anObject isSet and: [ anObject notEmpty and: [ anObject allSatisfy: [ :value | basetype includes: value ] ] ]