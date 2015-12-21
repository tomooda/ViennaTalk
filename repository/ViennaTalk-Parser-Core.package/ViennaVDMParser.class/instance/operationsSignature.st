parsers-interfaces
operationsSignature
	^ super operationsSignature ==> [ :array | ViennaNode label: 'OperationsSignature' withAll: array ]