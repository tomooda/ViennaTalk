parsers-definitions
stateDefinition
	^ super stateDefinition ==> [ :array | ViennaNode label: 'StateDefinition' withAll: array ]