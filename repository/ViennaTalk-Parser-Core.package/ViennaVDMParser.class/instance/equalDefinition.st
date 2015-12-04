parsers-expressions-basics
equalDefinition
	^ super equalDefinition ==> [ :array | ViennaNode label: 'EqualDefinition' withAll: array ]