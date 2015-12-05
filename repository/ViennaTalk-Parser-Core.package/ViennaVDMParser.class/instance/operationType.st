parsers-types
operationType
	^ super operationType ==> [ :array | ViennaNode label: 'OperationType' withAll: array ]