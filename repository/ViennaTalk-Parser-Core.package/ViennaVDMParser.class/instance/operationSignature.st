parsers-interfaces
operationSignature
	^ super operationSignature ==> [ :array | ViennaNode label: 'OperationSignature' withAll: array ]