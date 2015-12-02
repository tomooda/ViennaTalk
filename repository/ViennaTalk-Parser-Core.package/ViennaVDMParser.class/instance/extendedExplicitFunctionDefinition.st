parsers-definitions
extendedExplicitFunctionDefinition
	^ super extendedExplicitFunctionDefinition
		==> [ :array | ViennaNode label: 'ExtendedExplicitFunctionDefinition' withAll: array ]