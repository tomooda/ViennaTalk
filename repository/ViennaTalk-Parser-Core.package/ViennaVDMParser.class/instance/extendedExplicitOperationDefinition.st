parsers-definitions
extendedExplicitOperationDefinition
	^ super extendedExplicitOperationDefinition
		==> [ :array | ViennaNode label: 'ExtendedExplicitOperationDefinition' withAll: array ]