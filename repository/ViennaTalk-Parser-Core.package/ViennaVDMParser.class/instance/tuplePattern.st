parsers-patterns
tuplePattern
	^ super tuplePattern ==> [ :array | ViennaNode label: 'TuplePattern' with: (ViennaNode label: 'PatternList' withAll: array) ]