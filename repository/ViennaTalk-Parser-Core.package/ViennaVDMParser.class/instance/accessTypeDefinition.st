parsers-definitions
accessTypeDefinition
	^ super accessTypeDefinition
		==> [ :array | ViennaNode label: 'AccessTypeDefinition' with: (ViennaNode label: 'Access' withAll: array first) with: array second ]