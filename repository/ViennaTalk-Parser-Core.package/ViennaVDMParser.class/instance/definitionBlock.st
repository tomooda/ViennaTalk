parsers-definitions
definitionBlock
	^ super definitionBlock ==> [ :array | ViennaNode label: 'DefinitionBlock' withAll: array ]