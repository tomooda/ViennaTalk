parsers-patterns
tuplePattern
	^ super tuplePattern ==> [ :array | ViennaNode label: 'TuplePattern' with: array ]