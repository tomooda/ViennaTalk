parsers-definitions
equalDefinition
	^ super equalDefinition ==> [ :array | ViennaNode label: 'EqualDefinition' withAll: array ]