parsers-definitions
typeSynonym
	^ super typeSynonym ==> [ :array | ViennaNode label: 'TypeDefinition' withAll: array ]