parsers-definitions
explicitOperationDefinition
	^ super explicitOperationDefinition ==> [ :array | ViennaNode label: 'ExplicitOperationDefinition' withAll: array ]