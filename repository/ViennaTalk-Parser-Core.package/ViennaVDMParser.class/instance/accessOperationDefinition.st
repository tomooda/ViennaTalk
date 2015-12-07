parsers-definitions
accessOperationDefinition
	^ super accessOperationDefinition
		==> [ :array | ViennaNode label: 'AccessOperationDefinition' with: (ViennaNode label: 'Access' withAll: array first) with: array second ]