parsers-definitions
definitionBlock
	^ super definitionBlock ==> [ :array | ViennaNode label: 'DefinitionBlock' with: array ]