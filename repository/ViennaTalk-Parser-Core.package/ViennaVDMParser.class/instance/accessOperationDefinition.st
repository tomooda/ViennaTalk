parsers-definitions
accessOperationDefinition
	^ super accessOperationDefinition ==> [ :array | ViennaNode label: 'AccessOperationDefinition' withAll: array ]