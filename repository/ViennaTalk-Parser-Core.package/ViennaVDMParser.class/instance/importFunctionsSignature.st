parsers-interfaces
importFunctionsSignature
	^ super importFunctionsSignature ==> [ :array | ViennaNode label: 'ImportFunctionsSignature' withAll: array ]