parsers-definitions
operationDefinition
	^ super operationDefinition ==> [ :def | ViennaNode label: 'OperationDefinition' with: def ]