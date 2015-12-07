parsers-definitions
operationDefinitions
	^ super operationDefinitions ==> [ :array | ViennaNode label: 'OperationDefinitions' withAll: array ]