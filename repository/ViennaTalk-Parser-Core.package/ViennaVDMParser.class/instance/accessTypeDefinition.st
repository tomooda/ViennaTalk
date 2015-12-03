parsers-definitions
accessTypeDefinition
	^ super accessTypeDefinition ==> [ :array | ViennaNode label: 'AccessTypeDefinition' withAll: array ]