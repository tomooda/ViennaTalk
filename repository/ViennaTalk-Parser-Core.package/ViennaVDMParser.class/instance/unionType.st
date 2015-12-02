parsers-types
unionType
	^ super unionType ==> [ :array | ViennaNode label: 'UnionType' with: array ]