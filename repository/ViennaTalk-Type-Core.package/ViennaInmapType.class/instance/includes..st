testing
includes: anObject
	^ anObject isDictionary
		and: [ 
			(anObject keys allSatisfy: [ :key | keytype includes: key ])
				and: [ (anObject values allSatisfy: [ :value | valuetype includes: value ]) and: [ anObject values asSet size = anObject size ] ] ]