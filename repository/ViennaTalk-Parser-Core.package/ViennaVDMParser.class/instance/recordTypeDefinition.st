parsers-definitions
recordTypeDefinition
	^ super recordTypeDefinition ==> [ :array | ViennaNode label: 'RecordTypeDefinition' withAll: array ]