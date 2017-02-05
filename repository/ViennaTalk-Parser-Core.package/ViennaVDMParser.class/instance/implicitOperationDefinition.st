parsers-definitions
implicitOperationDefinition
	^ super implicitOperationDefinition ==> [ :array | ViennaNode label: 'ImplicitOperationDefinition' withAll: array ]