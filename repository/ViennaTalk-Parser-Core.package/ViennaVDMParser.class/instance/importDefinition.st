parsers-interfaces
importDefinition
	^ super importDefinition ==> [ :array | ViennaNode label: 'ImportDefinition' withAll: array ]