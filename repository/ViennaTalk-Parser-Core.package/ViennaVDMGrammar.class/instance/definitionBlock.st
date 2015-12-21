parsers-definitions
definitionBlock
	^ (self typeDefinitions / self valueDefinitions / self functionDefinitions / self operationDefinitions / self stateDefinition) trim