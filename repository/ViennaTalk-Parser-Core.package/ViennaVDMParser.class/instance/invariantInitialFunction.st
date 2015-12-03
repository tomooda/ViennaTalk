parsers-types
invariantInitialFunction
	^ super invariantInitialFunction ==> [ :array | ViennaNode label: 'InvariantInitialFunction' withAll: array ]