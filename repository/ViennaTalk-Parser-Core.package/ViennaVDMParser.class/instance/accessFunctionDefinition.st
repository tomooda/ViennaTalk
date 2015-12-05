parsers-definitions
accessFunctionDefinition
	^ super accessFunctionDefinition ==> [ :array | ViennaNode label: 'AccessFunctionDefinition' withAll: array ]