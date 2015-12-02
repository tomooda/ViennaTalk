parsers-definitions
valueDefinition
	^ super valueDefinition ==> [ :array | ViennaNode label: 'ValueDefinition' withAll: array ]