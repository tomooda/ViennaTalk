parsers-interfaces
valuesSignature
	^ super valuesSignature ==> [ :array | ViennaNode label: 'ValuesSignature' withAll: array ]