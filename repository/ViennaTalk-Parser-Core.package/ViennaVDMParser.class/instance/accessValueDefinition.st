parsers-definitions
accessValueDefinition
	^ super accessValueDefinition
		==> [ :array | ViennaNode label: 'AccessValueDefinition' with: (ViennaNode label: 'Access' withAll: array first) with: array second ]