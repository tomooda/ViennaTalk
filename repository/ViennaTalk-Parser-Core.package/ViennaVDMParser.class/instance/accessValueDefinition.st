parsers-definitions
accessValueDefinition
	^ super accessValueDefinition ==> [ :array | ViennaNode label: 'AccessValueDefinition' withAll: array ]