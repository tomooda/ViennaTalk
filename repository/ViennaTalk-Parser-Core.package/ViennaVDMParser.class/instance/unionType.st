parsers-types
unionType
	^ super unionType ==> [ :array | ViennaNode label: 'UnionType' withAll: array ]