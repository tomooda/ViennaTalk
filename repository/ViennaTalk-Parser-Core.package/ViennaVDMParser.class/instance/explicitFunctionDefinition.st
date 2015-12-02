parsers-definitions
explicitFunctionDefinition
	^ super explicitFunctionDefinition ==> [ :array | ViennaNode label: 'ExplicitFunctionDefinition' withAll: array ]