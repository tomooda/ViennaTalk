parsers-definitions
accessFunctionDefinition
	^ super accessFunctionDefinition
		==> [ :array | ViennaNode label: 'AccessFunctionDefinition' with: (ViennaNode label: 'Access' withAll: array first) with: array second ]